
import 'package:flutter/material.dart';

class FolderItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const FolderItem({
    required this.icon,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 10),
            Text(label),
          ],
        ),
      ),
    );
  }
}
