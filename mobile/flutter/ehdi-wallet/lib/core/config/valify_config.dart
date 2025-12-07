/// Valify eKYC Configuration - Sandbox Environment
/// HealthFlow EHDI Wallet Integration

class ValifyConfig {
  // Base URL - Sandbox
  static const String baseUrl = 'https://www.valifystage.com';
  
  // OAuth Credentials
  static const String username = 'healthflow__79742_integration_bundle';
  static const String password = '9ud5nKUeC@96W3S7';
  static const String clientId = 'lwsx7HOCt5o3bm6QmxBb3F3TExi72drzayCIZOnh';
  static const String clientSecret = 'Uv24K9zhKs6kiPpySvE2pnIo2Zzu29Ii8glz2cYMmu2QESJeMw1nWP5g4w2JaceVaCDagsulvmboI490HTAWz9paFXczdjWDYuTGj34d4tjuv9kY5UfTGGbmNMdfQ5bE';
  
  // Bundle & HMAC Keys
  static const String bundleKey = 'b2978014d0b94653be8da42d5d99058b';
  static const String hmacKey = '81725cacb6ad56fffb024e27082874ad512f933c0d55baef3e005ed8d07608c574bd1bc2500c91ac3c0e9789702a014358cc83a429462a19573778862606400f';
  
  // API Endpoints
  static const String oauthToken = '/api/o/token/';
  static const String nationalIdOcr = '/api/v1/ocr/national-id/';
  static const String liveness = '/api/v1/liveness/';
  static const String faceMatch = '/api/v1/face-match/';
  static const String nidValidation = '/api/v1/nid-root-of-trust/';
}
