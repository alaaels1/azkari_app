import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final Widget leading;
  final Widget trailing;

  const SettingTile({
    super.key,
    required this.title,
    required this.leading,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: leading,
      trailing: trailing,
    );
  }
}