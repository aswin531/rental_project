import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpForm extends StatelessWidget {
  final Color otpColor;

  const OtpForm({super.key, required this.otpColor});

  Widget buildOtpField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: otpColor,
        borderRadius: BorderRadius.circular(20),
      ),
      width: 55.h,
      height: 55.h,
      child: TextFormField(
        decoration:
            const InputDecoration(hintText: "0", border: InputBorder.none),
        style: Theme.of(context).textTheme.headlineSmall,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(4, (index) => buildOtpField(context)),
      ),
    );
  }
}
