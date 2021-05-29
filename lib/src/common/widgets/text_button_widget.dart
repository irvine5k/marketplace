import 'package:flutter/material.dart';
import 'package:marketplace/src/common/constants/theme.dart';

class TextButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;

  const TextButtonWidget({
    Key? key,
    required this.onTap,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return AppColors.grey;
              }

              return AppColors.purple;
            },
          ),
        ),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
}
