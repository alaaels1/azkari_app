import 'package:azkari_app/core/constants/app_colors.dart';
import 'package:azkari_app/features/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class customAppbar extends StatelessWidget implements PreferredSizeWidget {
  customAppbar({
    super.key,
    required this.icon1,
    required this.onPressedIcon1,
    this.icon2,
    this.onPressedIcon2,
    required this.icon3,
    required this.onPressedIcon3,
    required this.title,
  });
  final IconData icon1;
  final VoidCallback onPressedIcon1;
  final IconData? icon2;
  final VoidCallback? onPressedIcon2;
  final IconData icon3;
  final VoidCallback onPressedIcon3;
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 80,
      elevation: 10,
      automaticallyImplyLeading: false,
      leading: Row(
        children: [
          IconButton(
            onPressed: onPressedIcon1,
            icon: Icon(icon1, color: AppColors.secondaryColor),
            padding: EdgeInsets.zero,
          ),
          if (icon2 != null)
            IconButton(
              onPressed: onPressedIcon2,
              icon: Icon(icon2, color: AppColors.secondaryColor),
              padding: EdgeInsets.zero,
            ),
        ],
      ),

      actions: [
        IconButton(
          onPressed: onPressedIcon3,
          icon: Icon(
            icon3,
            color: AppColors.secondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],

      title: title == null
          ? Text("Title is null")
          : Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontFamily: "Nasrat",
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.w800,
              ),
            ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.thirdColor,
              AppColors.thirdColor,
              AppColors.thirdColor,
              AppColors.appBarBackground2,
            ],
          ),
        ),
      ),
    );
  }
}
