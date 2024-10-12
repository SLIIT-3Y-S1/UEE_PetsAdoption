import 'package:flutter/material.dart';
import 'package:pawpal/core/constants/colors.dart';
import 'package:pawpal/theme/theme.dart';

class SmallButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const SmallButton({
    Key? key,
    required this.color,
    required this.text,
    required this.onPressed,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(100, 40), // Set the size here
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, size: 20.0, color:AppColors.iconBlack),
          if (icon != null) const SizedBox(width: 8.0),
          Text(
            text,
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}