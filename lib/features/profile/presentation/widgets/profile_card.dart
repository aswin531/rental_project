
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:rentit/features/profile/presentation/widgets/stat_column.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
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
        child: const Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/admin.jpg'),
            ),
            SizedBox(height: 10),
            Text(
              'Richard A. Bachmann',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'UI/UX Designer',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StatColumn(value: '75k', label: 'Followers'),
                StatColumn(value: '16k', label: 'Following'),
                StatColumn(value: '600', label: 'Projects'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
