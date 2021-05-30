import 'package:flutter/material.dart';
import 'package:marketplace/src/common/constants/theme.dart';
import 'package:marketplace/src/common/widgets/rounded_card_widget.dart';

class RoundedTileWidget extends StatelessWidget {
  final String title;
  final String description;
  final Widget? trailing;
  final VoidCallback? onTap;

  const RoundedTileWidget({
    Key? key,
    required this.title,
    required this.description,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedCardWidget.withGradient(
      gradient: LinearGradient(
        stops: [0, 0.8],
        colors: [
          AppColors.darkGrey.withOpacity(0.5),
          AppColors.black,
        ],
      ),
      padding: EdgeInsets.zero,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          title,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            color: AppColors.grey.withOpacity(0.6),
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
