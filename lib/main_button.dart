import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final Color? color;

  const MainButton({
    @required this.onPressed,
    @required this.text,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 20.0,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text!,
          ),
        ),
      ),
    );
  }
}
