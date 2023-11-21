import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;

  const CustomElevatedButton(
      {super.key, required this.onPressed, required this.label});

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: SizedBox(
        width: w,
        height: 60.0,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[600],
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          child: Text(
            widget.label,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
