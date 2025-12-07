import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';

class PrescriptionDetailScreen extends StatelessWidget {
  final String prescriptionId;
  
  const PrescriptionDetailScreen({
    super.key,
    required this.prescriptionId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('تفاصيل الوصفة'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: Text('Prescription ID: $prescriptionId'),
      ),
    );
  }
}
