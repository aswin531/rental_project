import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:rentit/features/profile/presentation/widgets/stat_column.dart';

class ProfileCard extends StatelessWidget {
  final String username;
  final String? imageUrl;
  const ProfileCard(
      {super.key, required this.username, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    debugPrint("Image URl +===================$imageUrl");
    return AvatarGlow(
      glowColor: const Color.fromARGB(255, 3, 147, 243),
      glowShape: BoxShape.circle,
      animate: true,
      glowRadiusFactor: 5.0,
      glowCount: 10,
      curve: Easing.emphasizedAccelerate,
      duration: const Duration(milliseconds: 2000),
      repeat: false,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[800],
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: imageUrl?.isNotEmpty == true
                  ? NetworkImage(imageUrl!)
                  : const AssetImage("assets/images/admin.jpg") as ImageProvider,
            ),
            const SizedBox(height: 10),
            Text(
              username,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'UI/UX Designer',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StatColumn(value: '75k', label: 'Rented Cars'),
                StatColumn(value: '16k', label: 'Total Rentals'),
                StatColumn(value: '600', label: 'Reviews'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
