// floating_action_button_widget.dart
import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const FloatingActionButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: MediaQuery.of(context).size.width / 2 - 25,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 55,
          height: 75,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Color(0xFFCA771A),
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
