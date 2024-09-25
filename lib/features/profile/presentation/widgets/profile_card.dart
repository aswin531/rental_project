import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String username;
  final String imageUrl;
  final String? job;
  const ProfileCard(
      {super.key, required this.username, required this.imageUrl, this.job});

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
              backgroundColor: Colors.grey[300],
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) =>
                      Image.asset('assets/images/placeholder-image.jpg'),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              username,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              job ?? 'UI/UX Designer',
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // StatColumn(value: '75k', label: 'Rented Cars'),
                // StatColumn(value: '16k', label: 'Total Rentals'),
                // StatColumn(value: '600', label: 'Reviews'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
