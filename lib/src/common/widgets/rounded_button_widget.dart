import 'package:flutter/material.dart';
import 'package:marketplace/src/common/constants/theme.dart';

class RoundedButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;
  final Color backgroundColor;
  final Color labelColor;

  const RoundedButtonWidget.light({
    Key? key,
    required this.onTap,
    required this.label,
  })  : backgroundColor = const Color(0xffb5dcda),
        labelColor = AppColors.black,
        super(key: key);

  const RoundedButtonWidget.dark({
    Key? key,
    required this.onTap,
    required this.label,
  })  : backgroundColor = AppColors.black,
        labelColor = const Color(0xffb5dcda),
        super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: TextStyle(
              color: labelColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
}
