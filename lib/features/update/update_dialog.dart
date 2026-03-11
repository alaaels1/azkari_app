import 'package:azkari_app/features/update/update_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> checkAndShowUpdate(BuildContext context) async {
  final result = await UpdateService().checkForUpdates();
  if (result == null || !context.mounted) return;

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('تحديث متاح 🎉'),
      content: Text(
        'الإصدار الحالي: ${result.currentVersion}\n'
            'الإصدار الجديد: ${result.latestVersion}\n\n'
            '${result.releaseNotes}',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('لاحقاً'),
        ),
        ElevatedButton(
          onPressed: () => launchUrl(Uri.parse(result.downloadUrl)),
          child: const Text('تحديث الآن'),
        ),
      ],
    ),
  );
}