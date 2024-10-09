import 'package:flutter/material.dart';
import './advise_card.dart';

class ButtonSimple extends StatefulWidget {
  final String text;
  final Future<void> Function()? onPressed;
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
  _ButtonSimpleState createState() => _ButtonSimpleState();
}

class _ButtonSimpleState extends State<ButtonSimple> {
  bool _isAdviseShown = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FilledButton.tonal(
              onPressed: widget.enabled
                  ? () async {
                      setState(() {
                        _isAdviseShown = false;
                      });

                      if (widget.onPressed != null) {
                        await widget.onPressed!();
                      }

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (!_isAdviseShown && widget.adviseContent != null) {
                          setState(() {
                            _isAdviseShown = true;
                          });

                          Advise(
                            content: widget.adviseContent!,
                            route: widget.adviseRoute,
                          ).show(context);
                        }
                      });
                    }
                  : null,
              child: Text(widget.text)),
        ],
      ),
    );
  }
}
