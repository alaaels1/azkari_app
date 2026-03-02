import 'package:azkari_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme/theme_cubit.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.icon1,
    required this.onPressedIcon1,
    required this.icon2,
    required this.icon3,
    required this.onPressedIcon3,
    required this.title,
  });
  final IconData icon1;
  final VoidCallback onPressedIcon1;
  final bool icon2 ;
  final IconData icon3;
  final VoidCallback onPressedIcon3;
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 100,
      elevation: 10,
      automaticallyImplyLeading: false,
      leading: Row(
        children: [
          IconButton(
            onPressed: onPressedIcon1,
            icon: Icon(icon1, color:  Theme.of(context).iconTheme.color,),
            padding: EdgeInsets.zero,
          ),
          if (icon2 )
            IconButton(
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
               icon: Icon( Theme.of(context).brightness == Brightness.dark
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,),
                color:Theme.of(context).brightness == Brightness.dark
                    ?AppColors.accentYellow:AppColors.secondaryColor,

            ),
        ],
      ),

      actions: [
        IconButton(
          onPressed: onPressedIcon3,
          icon: Icon(
            icon3,
            color:Theme.of(context).iconTheme.color,
          ),
        ),
      ],

      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          fontFamily: "Nasrat",
          color: Theme.of(context).iconTheme.color,
          fontWeight: FontWeight.w800,
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: Theme.of(context).brightness == Brightness.dark
                ? [
              AppColors.darkAppBarBottom,
              AppColors.darkAppBarTop,
            ]
                : [
              AppColors.thirdColor,
              AppColors.appBarBackground2,
            ],

          ),
        ),
      ),
    );
  }
}
