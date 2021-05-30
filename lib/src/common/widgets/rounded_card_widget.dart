import 'package:flutter/material.dart';

class RoundedCardWidget extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Gradient? gradient;
  final EdgeInsets? padding;

  const RoundedCardWidget.withSolidColor({
    Key? key,
    required this.child,
    required this.color,
    this.padding,
  })  : gradient = null,
        super(key: key);

  const RoundedCardWidget.withGradient({
    Key? key,
    required this.child,
    required this.gradient,
    this.padding,
  })  : color = null,
        super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        padding: padding ?? EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          gradient: gradient,
        ),
        child: child,
      );
}
