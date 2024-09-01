import 'package:flutter/material.dart';

class TeamItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> avatars;
  final IconData icon;

  const TeamItem({
    required this.title,
    required this.subtitle,
    required this.avatars,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            //backgroundColor: Colors,
            child: Icon(icon, size: 25, color: Colors.blueAccent),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                if (subtitle.isNotEmpty)
                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Row(
            children: avatars
                .map((url) => Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage(url),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
