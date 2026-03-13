import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoSection {
  final String title;
  final String content;
  final IconData icon;

  const InfoSection({
    required this.title,
    required this.content,
    this.icon = Icons.privacy_tip_outlined,
  });
}
