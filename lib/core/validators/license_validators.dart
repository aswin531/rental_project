
class Validator {
 static String? requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? driverLicenseValidator(String? value) {
    final RegExp regex = RegExp(r"^(([A-Z]{2}[0-9]{2})( )|([A-Z]{2}-[0-9]{2}))((19|20)[0-9][0-9])[0-9]{7}$");
    if (value == null || value.isEmpty) {
      return 'Please enter a driver\'s license number';
    } else if (!regex.hasMatch(value)) {
      return 'Invalid driver\'s license format';
    }
    return null;
  }
}

