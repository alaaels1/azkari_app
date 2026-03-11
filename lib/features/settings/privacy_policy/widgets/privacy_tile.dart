import 'package:flutter/material.dart';
import '../../../../core/components/setting_tile.dart';
import '../privacy_policy_screen.dart';

class PrivacyTile extends StatelessWidget {
  const PrivacyTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingTile(
      title: 'سياسة الخصوصية',
      leading:Icon(Icons.privacy_tip_outlined, color: Theme.of(context).primaryColor,),
      trailing: IconButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const PrivacyPolicyScreen(),
          ),
        ),
        icon: const Icon(Icons.chevron_right),
      ),
    );
  }
}

