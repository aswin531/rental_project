import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumberField extends StatelessWidget {
  final ValueNotifier<String> phoneNumber = ValueNotifier('');
  final String labelText;

  PhoneNumberField({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: IntlPhoneField(
        initialValue: phoneNumber.value,
        onChanged: (phone) {
          phoneNumber.value = phone.completeNumber;
        },
        decoration: InputDecoration(
          labelText: labelText,
        ),
        initialCountryCode: 'IN',
        onCountryChanged: (country) {},
      ),
    );
  }
}
