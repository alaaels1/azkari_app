import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DeleteDataDialog {
  static Future<void> show(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'تأكيد الحذف',
          textDirection: TextDirection.rtl,
        ),
        content: const Text(
          'هل أنتِ متأكدة أنك تريدين حذف جميع البيانات؟',
          textDirection: TextDirection.rtl,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('لا'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('نعم'),
              ),
            ],
          ),
        ],
      ),
    );

    if (confirm == true) {
      await Hive.box('azkarBox').clear();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم حذف البيانات بنجاح')),
        );
      }
    }
  }
}