import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool obscureText;
	//final TextInputType keyboardType;
	final Widget? suffixIcon;
	final VoidCallback? onTap;
	final Widget? prefixIcon;
	final String? Function(String?)? validator;
	final FocusNode? focusNode;
	final String? errorMsg;
	final String? Function(String?)? onChanged;

  const CustomFormField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.hintText,
    required this.obscureText,
		//required this.keyboardType,
		this.suffixIcon,
		this.onTap,
		this.prefixIcon,
		this.validator,
		this.focusNode,
		this.errorMsg,
		this.onChanged
  });

	@override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
			//keyboardType: keyboardType,
			focusNode: focusNode,
			onTap: onTap,
			textInputAction: TextInputAction.next,
			onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
			),
    );
  }
}