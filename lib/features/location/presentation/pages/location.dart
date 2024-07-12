import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_text_styles.dart';

class LocationAccessScreen extends StatelessWidget {
  const LocationAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        toolbarHeight: 20.h,
      ),
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                child: Image.asset("assets/images/loc-bg.png"),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "What is Your Location ?",
                style: CustomTextStyles.headline3,
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                "we need to know your location in order ",
                style: CustomTextStyles.captiongrey,
              ),
              Text(
                "suggests nearby services",
                style: CustomTextStyles.captiongrey,
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                width: 300.h,
                decoration: BoxDecoration(
                    color: primary, borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(primary),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Allow Location Access",
                      style: CustomTextStyles.buttonlabeltext,
                    )),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: 300.h,
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(grey),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Enter Location Manually",
                      style: CustomTextStyles.buttonlabeltext,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
