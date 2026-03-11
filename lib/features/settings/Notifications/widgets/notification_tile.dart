import 'package:flutter/material.dart';
import '../../../../core/components/setting_tile.dart';
import '../repo/notification_repo.dart';

class NotificationTile extends StatefulWidget {
  const NotificationTile({super.key});

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  final _repo = NotificationRepository();
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    setState(() => _notificationsEnabled = _repo.notificationsEnabled);
  }

  Future<void> _toggle(bool value) async {
    setState(() => _notificationsEnabled = value);
    await _repo.setNotificationsEnabled(value);
  }

  @override
  Widget build(BuildContext context) {
    return SettingTile(
      title: 'الإشعارات',
      leading: Icon(
        _notificationsEnabled
            ? Icons.notifications_active
            : Icons.notifications_off,
        color: _notificationsEnabled ? Theme.of(context).primaryColor : Colors.grey,
      ),
      trailing: Switch(
        value: _notificationsEnabled,
        activeColor: Theme.of(context).primaryColor,
        onChanged: _toggle,
      ),
    );
  }
}