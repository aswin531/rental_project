import 'package:flutter/material.dart';

class BookNowButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const BookNowButton({
    super.key,
    required this.onPressed,
    this.text = "Book Now",
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        elevation: 5,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        shadowColor: Colors.blueAccent, 
      ),
      child: Text(text),
    );
  }
}
