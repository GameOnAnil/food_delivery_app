import 'package:flutter/material.dart';

class TextWithIcon extends StatelessWidget {
  final Icon icon;
  final String text;
  const TextWithIcon({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
