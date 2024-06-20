import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_text_styles.dart';

class LocationAccessScreen extends StatelessWidget {
  const LocationAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                child: Image.asset("assets/images/location.jpg"),
              ),
              Text(
                "What is Your Location ?",
                style: CustomTextStyles.headline3,
              ),
              SizedBox(
                height: 15.h,
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
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primary),
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
                    color: greyLight, borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(greyLight!),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Allow Location Manually",
                      style: TextStyle(
                        color: primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
