import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawpal/core/assets/app_vectors.dart';
import 'package:pawpal/theme/theme.dart';

class ProfileAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(left: 56.0), // Adjust padding as needed
        child: SvgPicture.asset(AppVectors.appBarBranding),
      ),
      actions: <Widget>[
        SvgPicture.asset(
          AppVectors.profileIconActive,
        ),
      ],
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}