import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';
class CustomAppbar extends StatelessWidget {
  final String? title;
  final VoidCallback? onBackPressed;
  final VoidCallback? onSharePressed;
  final VoidCallback? onFavoritePressed;

  const CustomAppbar({
    super.key,
     this.title,
    this.onBackPressed,
    this.onSharePressed,
    this.onFavoritePressed,
  });

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
            onPressed: onBackPressed ?? () => context.pop(),
          ),
        ),
      ),
      title: PrimaryText(
        text: title ?? "",
        color: ExternalAppColors.black,
      ),
      centerTitle: true,
      actions: [
        if (onSharePressed != null)
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ExternalAppColors.white,
              ),
              child: IconButton(
                icon: const Icon(Icons.share),
                onPressed: onSharePressed,
              ),
            ),
          ),
        if (onFavoritePressed != null)
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ExternalAppColors.white,
              ),
              child: IconButton(
                icon: const Icon(Icons.favorite_outline),
                onPressed: onFavoritePressed,
              ),
            ),
          ),
      ],
    );
  }
}
