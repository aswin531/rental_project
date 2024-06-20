import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/features/profile/widgets/profile_text_styles.dart';

class ProfileContainers extends StatelessWidget {
  const ProfileContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              // color: myLightGray,
              elevation: 10.dg, // Set the elevation
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 73.w,
                  height: 73.h,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.bookmark,
                            color: primary,
                          )),
                      Text(
                        "Saved",
                        style: CustomProfileTextStyles.bioStyle,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.h,
            ),
            Card(
              elevation: 10, // Set the elevation
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 73.w,
                  height: 73.h,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          FontAwesomeIcons.chartPie,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        "Activity",
                        style: CustomProfileTextStyles.bioStyle,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.h,
            ),
            Card(
              elevation: 10, // Set the elevation
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 69.w,
                  height: 73.h,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          FontAwesomeIcons.ccVisa,
                          color: Colors.deepOrange,
                        ),
                      ),
                      Text(
                        "Payment",
                        style: CustomProfileTextStyles.bioStyle,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
