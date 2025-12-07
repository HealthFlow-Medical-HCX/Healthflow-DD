import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import '../models/claim_model.dart';

/// Submit New Claim Screen
class SubmitClaimScreen extends StatefulWidget {
  const SubmitClaimScreen({super.key});

  @override
  State<SubmitClaimScreen> createState() => _SubmitClaimScreenState();
}

class _SubmitClaimScreenState extends State<SubmitClaimScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  int _currentStep = 0;
  bool _isSubmitting = false;

  // Form Controllers
  final _providerNameController = TextEditingController();
  final _providerLicenseController = TextEditingController();
  final _diagnosisController = TextEditingController();
  final _diagnosisCodeController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();
  final _preAuthController = TextEditingController();

  // Form Values
  ClaimType _selectedType = ClaimType.outpatient;
  DateTime _serviceDate = DateTime.now();
  List<Uint8List> _attachments = [];
  List<ClaimItem> _items = [];

  @override
  void dispose() {
    _providerNameController.dispose();
    _providerLicenseController.dispose();
    _diagnosisController.dispose();
    _diagnosisCodeController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    _preAuthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('مطالبة جديدة', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: const Color(0xFF008B8B),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: _onStepContinue,
          onStepCancel: _onStepCancel,
          controlsBuilder: (context, details) => _buildStepControls(details),
          steps: [
            _buildServiceTypeStep(),
            _buildProviderStep(),
            _buildDiagnosisStep(),
            _buildItemsStep(),
            _buildAttachmentsStep(),
            _buildReviewStep(),
          ],
        ),
      ),
    );
  }

  Step _buildServiceTypeStep() {
    return Step(
      title: const Text('نوع الخدمة', style: TextStyle(fontFamily: 'Cairo')),
      subtitle: Text(_selectedType.labelAr, style: const TextStyle(fontFamily: 'Cairo')),
      isActive: _currentStep >= 0,
      state: _currentStep > 0 ? StepState.complete : StepState.indexed,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'اختر نوع المطالبة',
            style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ClaimType.values.map((type) {
              final isSelected = _selectedType == type;
              return GestureDetector(
                onTap: () => setState(() => _selectedType = type),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF008B8B) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF008B8B) : Colors.grey[300]!,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        type.icon,
                        color: isSelected ? Colors.white : Colors.grey[600],
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        type.labelAr,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          color: isSelected ? Colors.white : Colors.grey[800],
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'تاريخ الخدمة',
            style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _serviceDate,
                firstDate: DateTime.now().subtract(const Duration(days: 90)),
                lastDate: DateTime.now(),
                locale: const Locale('ar'),
              );
              if (date != null) setState(() => _serviceDate = date);
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: Color(0xFF008B8B)),
                  const SizedBox(width: 12),
                  Text(
                    '${_serviceDate.day}/${_serviceDate.month}/${_serviceDate.year}',
                    style: const TextStyle(fontFamily: 'Cairo', fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Step _buildProviderStep() {
    return Step(
      title: const Text('مقدم الخدمة', style: TextStyle(fontFamily: 'Cairo')),
      subtitle: _providerNameController.text.isNotEmpty
          ? Text(_providerNameController.text, style: const TextStyle(fontFamily: 'Cairo'))
          : null,
      isActive: _currentStep >= 1,
      state: _currentStep > 1 ? StepState.complete : StepState.indexed,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _providerNameController,
            decoration: _inputDecoration('اسم مقدم الخدمة', Icons.local_hospital),
            style: const TextStyle(fontFamily: 'Cairo'),
            validator: (v) => v?.isEmpty ?? true ? 'مطلوب' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _providerLicenseController,
            decoration: _inputDecoration('رقم الترخيص', Icons.badge),
            style: const TextStyle(fontFamily: 'Cairo'),
            validator: (v) => v?.isEmpty ?? true ? 'مطلوب' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _preAuthController,
            decoration: _inputDecoration('رقم الموافقة المسبقة (اختياري)', Icons.verified),
            style: const TextStyle(fontFamily: 'Cairo'),
          ),
        ],
      ),
    );
  }

  Step _buildDiagnosisStep() {
    return Step(
      title: const Text('التشخيص', style: TextStyle(fontFamily: 'Cairo')),
      subtitle: _diagnosisController.text.isNotEmpty
          ? Text(_diagnosisController.text, style: const TextStyle(fontFamily: 'Cairo'))
          : null,
      isActive: _currentStep >= 2,
      state: _currentStep > 2 ? StepState.complete : StepState.indexed,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _diagnosisController,
            decoration: _inputDecoration('التشخيص', Icons.medical_information),
            style: const TextStyle(fontFamily: 'Cairo'),
            maxLines: 2,
            validator: (v) => v?.isEmpty ?? true ? 'مطلوب' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _diagnosisCodeController,
            decoration: _inputDecoration('رمز التشخيص ICD-10 (اختياري)', Icons.code),
            style: const TextStyle(fontFamily: 'Cairo'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _notesController,
            decoration: _inputDecoration('ملاحظات إضافية', Icons.notes),
            style: const TextStyle(fontFamily: 'Cairo'),
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Step _buildItemsStep() {
    final totalAmount = _items.fold(0.0, (sum, item) => sum + item.totalPrice);

    return Step(
      title: const Text('الخدمات والمبالغ', style: TextStyle(fontFamily: 'Cairo')),
      subtitle: _items.isNotEmpty
          ? Text('${_items.length} خدمات - ${totalAmount.toStringAsFixed(2)} ج.م', 
              style: const TextStyle(fontFamily: 'Cairo'))
          : null,
      isActive: _currentStep >= 3,
      state: _currentStep > 3 ? StepState.complete : StepState.indexed,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_items.isNotEmpty) ...[
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.descriptionAr,
                              style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '${item.quantity} × ${item.unitPrice.toStringAsFixed(2)} ج.م',
                              style: TextStyle(fontFamily: 'Cairo', color: Colors.grey[600], fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${item.totalPrice.toStringAsFixed(2)} ج.م',
                        style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                        onPressed: () => setState(() => _items.removeAt(index)),
                      ),
                    ],
                  ),
                );
              },
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF008B8B).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'الإجمالي',
                    style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${totalAmount.toStringAsFixed(2)} ج.م',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF008B8B),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          OutlinedButton.icon(
            onPressed: _showAddItemDialog,
            icon: const Icon(Icons.add),
            label: const Text('إضافة خدمة', style: TextStyle(fontFamily: 'Cairo')),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              side: const BorderSide(color: Color(0xFF008B8B)),
            ),
          ),
        ],
      ),
    );
  }

  Step _buildAttachmentsStep() {
    return Step(
      title: const Text('المرفقات', style: TextStyle(fontFamily: 'Cairo')),
      subtitle: _attachments.isNotEmpty
          ? Text('${_attachments.length} مرفقات', style: const TextStyle(fontFamily: 'Cairo'))
          : null,
      isActive: _currentStep >= 4,
      state: _currentStep > 4 ? StepState.complete : StepState.indexed,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'أرفق المستندات المطلوبة',
            style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            '• فاتورة مقدم الخدمة\n• التقارير الطبية\n• نتائج الفحوصات',
            style: TextStyle(fontFamily: 'Cairo', color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          if (_attachments.isNotEmpty) ...[
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _attachments.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: MemoryImage(_attachments[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 12,
                        child: GestureDetector(
                          onTap: () => setState(() => _attachments.removeAt(index)),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.close, color: Colors.white, size: 14),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _pickAttachment(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('الكاميرا', style: TextStyle(fontFamily: 'Cairo')),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _pickAttachment(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('المعرض', style: TextStyle(fontFamily: 'Cairo')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Step _buildReviewStep() {
    final totalAmount = _items.fold(0.0, (sum, item) => sum + item.totalPrice);

    return Step(
      title: const Text('مراجعة وإرسال', style: TextStyle(fontFamily: 'Cairo')),
      isActive: _currentStep >= 5,
      state: StepState.indexed,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReviewRow('نوع المطالبة', _selectedType.labelAr),
          _buildReviewRow('تاريخ الخدمة', '${_serviceDate.day}/${_serviceDate.month}/${_serviceDate.year}'),
          _buildReviewRow('مقدم الخدمة', _providerNameController.text),
          _buildReviewRow('التشخيص', _diagnosisController.text),
          _buildReviewRow('عدد الخدمات', '${_items.length}'),
          _buildReviewRow('المبلغ الإجمالي', '${totalAmount.toStringAsFixed(2)} ج.م'),
          _buildReviewRow('المرفقات', '${_attachments.length} ملفات'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: Colors.amber[700]),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'يرجى التأكد من صحة البيانات قبل الإرسال',
                    style: TextStyle(fontFamily: 'Cairo'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(fontFamily: 'Cairo', color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepControls(ControlsDetails details) {
    final isLastStep = _currentStep == 5;

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: details.onStepCancel,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Color(0xFF008B8B)),
                ),
                child: const Text('السابق', style: TextStyle(fontFamily: 'Cairo')),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : details.onStepContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: isLastStep ? const Color(0xFF4CAF50) : const Color(0xFF008B8B),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : Text(
                      isLastStep ? 'إرسال المطالبة' : 'التالي',
                      style: const TextStyle(fontFamily: 'Cairo', color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontFamily: 'Cairo'),
      prefixIcon: Icon(icon, color: const Color(0xFF008B8B)),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF008B8B), width: 2),
      ),
    );
  }

  void _onStepContinue() {
    if (_currentStep == 5) {
      _submitClaim();
    } else {
      if (_validateCurrentStep()) {
        setState(() => _currentStep++);
      }
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 1:
        return _providerNameController.text.isNotEmpty && _providerLicenseController.text.isNotEmpty;
      case 2:
        return _diagnosisController.text.isNotEmpty;
      case 3:
        return _items.isNotEmpty;
      default:
        return true;
    }
  }

  Future<void> _pickAttachment(ImageSource source) async {
    final image = await _picker.pickImage(source: source, imageQuality: 85);
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() => _attachments.add(bytes));
    }
  }

  void _showAddItemDialog() {
    final descController = TextEditingController();
    final codeController = TextEditingController();
    final qtyController = TextEditingController(text: '1');
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة خدمة', style: TextStyle(fontFamily: 'Cairo')),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descController,
                decoration: const InputDecoration(
                  labelText: 'وصف الخدمة',
                  labelStyle: TextStyle(fontFamily: 'Cairo'),
                ),
                style: const TextStyle(fontFamily: 'Cairo'),
              ),
              TextField(
                controller: codeController,
                decoration: const InputDecoration(
                  labelText: 'الكود (اختياري)',
                  labelStyle: TextStyle(fontFamily: 'Cairo'),
                ),
              ),
              TextField(
                controller: qtyController,
                decoration: const InputDecoration(
                  labelText: 'الكمية',
                  labelStyle: TextStyle(fontFamily: 'Cairo'),
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'السعر (ج.م)',
                  labelStyle: TextStyle(fontFamily: 'Cairo'),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () {
              final qty = int.tryParse(qtyController.text) ?? 1;
              final price = double.tryParse(priceController.text) ?? 0;
              if (descController.text.isNotEmpty && price > 0) {
                setState(() {
                  _items.add(ClaimItem(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    code: codeController.text.isEmpty ? 'N/A' : codeController.text,
                    description: descController.text,
                    descriptionAr: descController.text,
                    quantity: qty,
                    unitPrice: price,
                    totalPrice: qty * price,
                  ));
                });
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF008B8B)),
            child: const Text('إضافة', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _submitClaim() async {
    setState(() => _isSubmitting = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isSubmitting = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إرسال المطالبة بنجاح!', style: TextStyle(fontFamily: 'Cairo')),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
      Navigator.pop(context);
    }
  }
}
