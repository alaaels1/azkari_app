import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

class DeleteDataDialog {
  static Future<void> show(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor ,
        title: Text(
          'تأكيد الحذف',
          textDirection: TextDirection.rtl,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.titleLarge!.color),
        ),
        content: Text(
          'هل أنت متأكدة أنك تريد حذف جميع البيانات؟',
          textDirection: TextDirection.rtl,
          style: TextStyle(fontSize: 16.sp),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('لا', style: TextStyle(fontSize: 16.sp, color: Theme.of(context).primaryColor)),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('نعم', style: TextStyle(fontSize: 16.sp, color: Colors.red)),
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
          SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
            content: Text(
              textDirection: TextDirection.rtl,
              'تم حذف البيانات بنجاح',
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
        );
      }
    }
  }
}
