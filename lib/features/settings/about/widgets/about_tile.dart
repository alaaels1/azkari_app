import 'package:flutter/material.dart';
import '../../../../core/components/setting_tile.dart';
import '../about_screen.dart';

class AboutTile extends StatelessWidget {
  const AboutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingTile(
      title: 'عن التطبيق',
      leading: Icon(Icons.info_outline, color: Theme.of(context).primaryColor),
      trailing: IconButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AboutScreen()),
        ),
        icon: const Icon(Icons.chevron_right),
      ),
    );
  }
}