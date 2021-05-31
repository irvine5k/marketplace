import 'package:flutter/material.dart';
import 'package:marketplace/src/common/constants/theme.dart';
import 'package:marketplace/src/common/resources/messages.dart';
import 'package:marketplace/src/common/widgets/rounded_button_widget.dart';

class CustomErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const CustomErrorWidget({Key? key, required this.onRetry}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppMessages.somethingWrong,
            style: TextStyle(
              color: AppColors.white,
              fontSize: DesignTokens.fontLG,
            ),
          ),
          const SizedBox(height: 20),
          RoundedButtonWidget.light(
            onTap: onRetry,
            label: AppMessages.tryAgain,
          )
        ],
      ),
    );
  }
}
