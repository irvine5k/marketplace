import 'package:flutter/material.dart';
import 'package:marketplace/src/common/constants/theme.dart';

class RoundedButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;

  const RoundedButtonWidget({
    Key? key,
    required this.onTap,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xffb5dcda),
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
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
}
