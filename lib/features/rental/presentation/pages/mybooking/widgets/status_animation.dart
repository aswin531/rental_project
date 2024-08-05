import 'package:flutter/material.dart';

class AnimatedStatus extends StatelessWidget {
  final bool isVisible;
  final String status;

  const AnimatedStatus({
    required this.isVisible,
    required this.status,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(seconds: 1),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: getStatusColor(status),
        ),
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
