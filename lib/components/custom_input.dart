import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final String labelText;
  final String? defaultValue;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? padding;
  final Widget? labelTextUpperField;
  final Color borderColor;
  final Color focusedBorderColor;
  final double borderRadius;
  final double borderWidth;
  final bool obscureTitle;
  final bool readOnly;
  final bool enabled;
  final int maxLines;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? textFieldValidator;
  final VoidCallback? onTap;
  final TextStyle? selectedTextColor;

  const CustomInput(
      {super.key,
      this.hintText = 'hint Text',
      this.onTap,
      this.labelText = '',
      this.controller,
      this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      this.borderColor = const Color.fromARGB(255, 221, 220, 220),
      this.focusedBorderColor = Colors.grey,
      this.borderRadius = 30.0,
      this.borderWidth = 2.0,
      this.obscureTitle = false,
      this.readOnly = false,
      this.suffixIcon,
      this.enabled = true,
      this.textFieldValidator,
      this.labelTextUpperField,
      this.maxLines = 1,
      this.defaultValue,
      this.selectedTextColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelTextUpperField != null || labelText.isNotEmpty) ...[
            labelTextUpperField ??
                Text(
                  labelText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            const SizedBox(height: 8),
          ],
          TextFormField(
            maxLines: maxLines,
            minLines: 1,
            onTap: onTap,
            style: selectedTextColor,
            validator: textFieldValidator,
            initialValue: defaultValue,
            obscureText: obscureTitle,
            controller: controller,
            readOnly: readOnly,
            enabled: enabled,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: hintText,
              hintStyle: TextStyle(color: borderColor),
              contentPadding: padding,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: focusedBorderColor, width: borderWidth),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
