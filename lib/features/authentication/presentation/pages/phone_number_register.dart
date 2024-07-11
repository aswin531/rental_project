import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_state.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_text_styles.dart';
import 'package:rentit/features/authentication/presentation/widgets/social_label_mobile.dart';

class MobileNumberRegScreen extends StatelessWidget {
  const MobileNumberRegScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumberController = TextEditingController();

    return BlocListener<AuthBloc, Authstate>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              closeIconColor: primary,
              content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  "Let's Ride",
                  style: CustomTextStyles.headline2,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Enter your mobile number",
                  style: CustomTextStyles.mobilescreentext,
                ),
                SizedBox(
                  height: 40.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IntlPhoneField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.call,
                        color: primary,
                      ),
                      suffixIcon: const Icon(Icons.backspace),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      labelText: 'Phone Number',
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      //print(phone.completeNumber);
                    },
                    onCountryChanged: (country) {
                      //print('Country changed to: ${country.name}');
                    },
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 235.h,
                    height: 40.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                                  context.push('/otpconfirm');

                        String phoneNumber = phoneNumberController.text.trim();
                        context
                            .read<AuthBloc>()
                            .add(SendPhoneCodeEvent(phoneNumber: phoneNumber));
                        //print("clicked number");
                      },
                      child: Text(
                        "Verify",
                        style: CustomTextStyles.buttonlabeltext,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 150.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 170,
                        child: Divider(
                          thickness: 2,
                          color: grey,
                        ),
                      ),
                      Text(
                        " Or ",
                        style: TextStyle(
                          color: grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: Divider(
                          thickness: 2,
                          color: grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Center(child: SocialLabelMobileScreen())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
