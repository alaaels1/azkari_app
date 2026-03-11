import 'package:azkari_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/always_on_top/always_on_top_cubit.dart';
import '../../features/always_on_top/always_on_top_states.dart';
import '../../features/theme/theme_cubit.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.icon2,
    required this.icon3,
    required this.onPressedIcon3,
    required this.title,
    this.actions,
  });
  final bool icon2;
  final IconData icon3;
  final VoidCallback onPressedIcon3;
  final String title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 150.w,
      elevation: 10,
      automaticallyImplyLeading: false,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<PinCubit, PinState>(
            builder: (context, state) {
              final isPinned = context.read<PinCubit>().isPinned;
              return SizedBox(
                width: 48.r,
                height: 48.r,
                child: IconButton(
                  onPressed: () {
                    context.read<PinCubit>().togglePin();
                  },
                  icon: Icon(
                    isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                  ),
                  color: isPinned
                      ? Theme.of(context).iconTheme.color
                      : Theme.of(context).iconTheme.color,
                  iconSize: 20.r,
                  padding: EdgeInsets.zero,
                ),
              );
            },
          ),
          if (icon2)
            SizedBox(
              width: 48.r,
              height: 48.r,
              child: IconButton(
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
                icon: Icon(
                  Theme.of(context).brightness == Brightness.dark
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                ),
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.accentYellow
                    : AppColors.secondaryColor,
                iconSize: 20.r,
                padding: EdgeInsets.zero,
              ),
            ),
        ],
      ),

      actions: [
        if (actions != null) ...actions!,
        IconButton(
          onPressed: onPressedIcon3,
          icon: Icon(icon3, color: Theme.of(context).iconTheme.color, size: 24.r),
        ),
      ],

      title: Text(
        title,
        textAlign: TextAlign.center,
        style:  TextStyle(
          fontFamily:"Alyamama",
          fontSize: 32.sp,
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
                ? [AppColors.darkAppBarBottom, AppColors.darkAppBarTop]
                : [AppColors.thirdColor, AppColors.appBarBackground2],
          ),
        ),
      ),
    );
  }
}
