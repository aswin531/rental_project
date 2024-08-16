import 'package:flutter/material.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
       backgroundColor: ExternalAppColors.bg,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: ExternalAppColors.white),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              title: PrimaryText(
                text: "Car Details",
                color: ExternalAppColors.black,
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ExternalAppColors.white),
                      child: IconButton(
                          icon: const Icon(Icons.share), onPressed: () {})),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ExternalAppColors.white),
                      child: IconButton(
                          icon: const Icon(Icons.favorite_outline),
                          onPressed: () {})),
                ),
              ],
    );
  }
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}