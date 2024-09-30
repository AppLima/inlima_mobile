import 'package:flutter/material.dart';
import './advise_card.dart';

class ButtonSimple extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final String? adviseContent;
  final String? adviseRoute;
  final bool enabled;

  const ButtonSimple({
    Key? key,
    required this.text,
    this.onPressed,
    this.adviseContent,
    this.adviseRoute,
    required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FilledButton.tonal(
              onPressed: enabled ? () {
                if (onPressed != null) {
                  onPressed!();
                }
                if (adviseContent != null) {
                  Advise(
                    content: adviseContent!,
                    route: adviseRoute,
                  ).show(context); 
                }
              } : null,
              child: Text(text)),
        ],
      ),
    );
  }
}
