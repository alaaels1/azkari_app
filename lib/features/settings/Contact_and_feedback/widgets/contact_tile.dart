import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/setting_tile.dart';
import '../Contact_and_feedback_screen.dart';

class ContactAndFeedbackTile extends StatelessWidget {
  const ContactAndFeedbackTile({super.key});

  @override
  Widget build(BuildContext context) {
    return    SettingTile(
      title: "اتصل بنا",
      leading:Icon(
        Icons.mail_outline_outlined,
        color: Theme.of(context).primaryColor,
      ),
      trailing: IconButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ContactAndFeedbackScreen(),
          ),
        ),
        icon: const Icon(Icons.chevron_right),
      ),
    );
  }
}
