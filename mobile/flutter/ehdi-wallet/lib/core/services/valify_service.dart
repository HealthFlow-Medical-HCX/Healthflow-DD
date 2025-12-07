import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/valify_config.dart';

/// Valify eKYC Service
/// Handles OAuth authentication and all KYC API calls
class ValifyService {
  static final ValifyService _instance = ValifyService._internal();
  factory ValifyService() => _instance;
  ValifyService._internal();

  final Dio _dio = Dio(BaseOptions(
    baseUrl: ValifyConfig.baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 60),
    headers: {'Content-Type': 'application/json'},
  ));

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? _accessToken;
  DateTime? _tokenExpiry;

  /// Initialize the service
  Future<void> initialize() async {
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
    await _loadStoredToken();
  }

  /// Load stored token from secure storage
  Future<void> _loadStoredToken() async {
    _accessToken = await _storage.read(key: 'valify_access_token');
    final expiryStr = await _storage.read(key: 'valify_token_expiry');
    if (expiryStr != null) {
      _tokenExpiry = DateTime.tryParse(expiryStr);
    }
  }

  /// Get OAuth 2.0 Access Token
  Future<String> getAccessToken() async {
    // Check if we have a valid token
    if (_accessToken != null && _tokenExpiry != null) {
      if (DateTime.now().isBefore(_tokenExpiry!.subtract(const Duration(minutes: 5)))) {
        return _accessToken!;
      }
    }

    // Request new token
    try {
      final response = await _dio.post(
        ValifyConfig.oauthToken,
        data: {
          'grant_type': 'password',
          'username': ValifyConfig.username,
          'password': ValifyConfig.password,
          'client_id': ValifyConfig.clientId,
          'client_secret': ValifyConfig.clientSecret,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (response.statusCode == 200) {
        _accessToken = response.data['access_token'];
        final expiresIn = response.data['expires_in'] as int;
        _tokenExpiry = DateTime.now().add(Duration(seconds: expiresIn));

        // Store token securely
        await _storage.write(key: 'valify_access_token', value: _accessToken);
        await _storage.write(key: 'valify_token_expiry', value: _tokenExpiry!.toIso8601String());

        return _accessToken!;
      }
      throw ValifyException('Failed to get access token: ${response.statusCode}');
    } on DioException catch (e) {
      throw ValifyException('OAuth Error: ${e.message}');
    }
  }

  /// Generate HMAC signature for requests
  String _generateHmac(String data) {
    final key = utf8.encode(ValifyConfig.hmacKey);
    final bytes = utf8.encode(data);
    final hmacSha256 = Hmac(sha256, key);
    final digest = hmacSha256.convert(bytes);
    return digest.toString();
  }

  /// National ID OCR - Extract data from ID image
  Future<NationalIdOcrResult> performNationalIdOcr({
    required Uint8List frontImage,
    Uint8List? backImage,
  }) async {
    final token = await getAccessToken();
    
    final formData = FormData.fromMap({
      'bundle_key': ValifyConfig.bundleKey,
      'front_image': MultipartFile.fromBytes(
        frontImage,
        filename: 'front_id.jpg',
      ),
      if (backImage != null)
        'back_image': MultipartFile.fromBytes(
          backImage,
          filename: 'back_id.jpg',
        ),
    });

    try {
      final response = await _dio.post(
        ValifyConfig.nationalIdOcr,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        return NationalIdOcrResult.fromJson(response.data);
      }
      throw ValifyException('OCR failed: ${response.statusCode}');
    } on DioException catch (e) {
      throw ValifyException('OCR Error: ${e.response?.data ?? e.message}');
    }
  }

  /// Liveness Detection - Verify user is real
  Future<LivenessResult> performLivenessDetection({
    required Uint8List selfieImage,
  }) async {
    final token = await getAccessToken();

    final formData = FormData.fromMap({
      'bundle_key': ValifyConfig.bundleKey,
      'image': MultipartFile.fromBytes(
        selfieImage,
        filename: 'selfie.jpg',
      ),
    });

    try {
      final response = await _dio.post(
        ValifyConfig.liveness,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        return LivenessResult.fromJson(response.data);
      }
      throw ValifyException('Liveness check failed: ${response.statusCode}');
    } on DioException catch (e) {
      throw ValifyException('Liveness Error: ${e.response?.data ?? e.message}');
    }
  }

  /// Face Match - Compare selfie with ID photo
  Future<FaceMatchResult> performFaceMatch({
    required Uint8List selfieImage,
    required Uint8List idImage,
  }) async {
    final token = await getAccessToken();

    final formData = FormData.fromMap({
      'bundle_key': ValifyConfig.bundleKey,
      'selfie_image': MultipartFile.fromBytes(
        selfieImage,
        filename: 'selfie.jpg',
      ),
      'id_image': MultipartFile.fromBytes(
        idImage,
        filename: 'id_photo.jpg',
      ),
    });

    try {
      final response = await _dio.post(
        ValifyConfig.faceMatch,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        return FaceMatchResult.fromJson(response.data);
      }
      throw ValifyException('Face match failed: ${response.statusCode}');
    } on DioException catch (e) {
      throw ValifyException('Face Match Error: ${e.response?.data ?? e.message}');
    }
  }

  /// National ID Validation - Verify against Root of Trust
  Future<NidValidationResult> validateNationalId({
    required String nationalId,
  }) async {
    final token = await getAccessToken();

    try {
      final response = await _dio.post(
        ValifyConfig.nidValidation,
        data: {
          'bundle_key': ValifyConfig.bundleKey,
          'national_id': nationalId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return NidValidationResult.fromJson(response.data);
      }
      throw ValifyException('NID validation failed: ${response.statusCode}');
    } on DioException catch (e) {
      throw ValifyException('NID Validation Error: ${e.response?.data ?? e.message}');
    }
  }

  /// Full eKYC Flow - Complete verification process
  Future<EkycResult> performFullEkyc({
    required Uint8List frontIdImage,
    Uint8List? backIdImage,
    required Uint8List selfieImage,
  }) async {
    try {
      // Step 1: OCR on National ID
      final ocrResult = await performNationalIdOcr(
        frontImage: frontIdImage,
        backImage: backIdImage,
      );

      // Step 2: Liveness Detection
      final livenessResult = await performLivenessDetection(
        selfieImage: selfieImage,
      );

      // Step 3: Face Match
      final faceMatchResult = await performFaceMatch(
        selfieImage: selfieImage,
        idImage: frontIdImage,
      );

      // Step 4: National ID Validation (if NID extracted)
      NidValidationResult? nidValidation;
      if (ocrResult.nationalId != null) {
        nidValidation = await validateNationalId(
          nationalId: ocrResult.nationalId!,
        );
      }

      return EkycResult(
        success: livenessResult.isLive && faceMatchResult.isMatch,
        ocrResult: ocrResult,
        livenessResult: livenessResult,
        faceMatchResult: faceMatchResult,
        nidValidation: nidValidation,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      return EkycResult(
        success: false,
        error: e.toString(),
        timestamp: DateTime.now(),
      );
    }
  }
}

// ============ Result Models ============

class NationalIdOcrResult {
  final String? nationalId;
  final String? fullNameAr;
  final String? fullNameEn;
  final String? dateOfBirth;
  final String? gender;
  final String? address;
  final String? governorate;
  final String? expiryDate;
  final String? religion;
  final String? maritalStatus;
  final String? jobTitle;
  final double? confidence;
  final String? transactionId;

  NationalIdOcrResult({
    this.nationalId,
    this.fullNameAr,
    this.fullNameEn,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.governorate,
    this.expiryDate,
    this.religion,
    this.maritalStatus,
    this.jobTitle,
    this.confidence,
    this.transactionId,
  });

  factory NationalIdOcrResult.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return NationalIdOcrResult(
      nationalId: data['national_id'] ?? data['nationalId'],
      fullNameAr: data['full_name_ar'] ?? data['fullNameAr'],
      fullNameEn: data['full_name_en'] ?? data['fullNameEn'],
      dateOfBirth: data['date_of_birth'] ?? data['dateOfBirth'],
      gender: data['gender'],
      address: data['address'],
      governorate: data['governorate'],
      expiryDate: data['expiry_date'] ?? data['expiryDate'],
      religion: data['religion'],
      maritalStatus: data['marital_status'] ?? data['maritalStatus'],
      jobTitle: data['job_title'] ?? data['jobTitle'],
      confidence: (data['confidence'] as num?)?.toDouble(),
      transactionId: json['transaction_id'] ?? json['transactionId'],
    );
  }
}

class LivenessResult {
  final bool isLive;
  final double? score;
  final String? transactionId;

  LivenessResult({
    required this.isLive,
    this.score,
    this.transactionId,
  });

  factory LivenessResult.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return LivenessResult(
      isLive: data['is_live'] ?? data['isLive'] ?? false,
      score: (data['liveness_score'] ?? data['score'] as num?)?.toDouble(),
      transactionId: json['transaction_id'] ?? json['transactionId'],
    );
  }
}

class FaceMatchResult {
  final bool isMatch;
  final double? matchScore;
  final String? transactionId;

  FaceMatchResult({
    required this.isMatch,
    this.matchScore,
    this.transactionId,
  });

  factory FaceMatchResult.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return FaceMatchResult(
      isMatch: data['is_match'] ?? data['isMatch'] ?? false,
      matchScore: (data['match_score'] ?? data['score'] as num?)?.toDouble(),
      transactionId: json['transaction_id'] ?? json['transactionId'],
    );
  }
}

class NidValidationResult {
  final bool isValid;
  final String? fullName;
  final String? dateOfBirth;
  final String? gender;
  final String? governorate;
  final String? transactionId;

  NidValidationResult({
    required this.isValid,
    this.fullName,
    this.dateOfBirth,
    this.gender,
    this.governorate,
    this.transactionId,
  });

  factory NidValidationResult.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return NidValidationResult(
      isValid: data['is_valid'] ?? data['isValid'] ?? false,
      fullName: data['full_name'] ?? data['fullName'],
      dateOfBirth: data['date_of_birth'] ?? data['dateOfBirth'],
      gender: data['gender'],
      governorate: data['governorate'],
      transactionId: json['transaction_id'] ?? json['transactionId'],
    );
  }
}

class EkycResult {
  final bool success;
  final NationalIdOcrResult? ocrResult;
  final LivenessResult? livenessResult;
  final FaceMatchResult? faceMatchResult;
  final NidValidationResult? nidValidation;
  final String? error;
  final DateTime timestamp;

  EkycResult({
    required this.success,
    this.ocrResult,
    this.livenessResult,
    this.faceMatchResult,
    this.nidValidation,
    this.error,
    required this.timestamp,
  });
}

class ValifyException implements Exception {
  final String message;
  ValifyException(this.message);

  @override
  String toString() => 'ValifyException: $message';
}
