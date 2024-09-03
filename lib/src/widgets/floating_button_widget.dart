// floating_action_button_widget.dart
import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const FloatingActionButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: MediaQuery.of(context).size.width / 2 - 30,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 60,
          height: 80,
          decoration: const BoxDecoration(
            color: Color(0xFFCA771A),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
