import 'package:equatable/equatable.dart';

class RentalFormState extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String address;
  final String license;
  final String comments;
  final String pickUPLocation;
  final String dropOffLocation;
  final bool isValid;

  const RentalFormState({
    this.name = '',
    this.phone = '',
    this.email = '',
    this.address = '',
    this.license = '',
    this.pickUPLocation = '',
    this.dropOffLocation = '',
    this.comments = 'Comments',
    this.isValid = false,
  });

  RentalFormState copyWith({
    String? name,
    String? phone,
    String? email,
    String? address,
    String? license,
    String? comments,
    String? pickUPLocation,
    String? dropOffLocation,
    bool? isValid,
  }) {
    return RentalFormState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      license: license ?? this.license,
      comments: comments ?? this.comments,
      pickUPLocation: pickUPLocation ?? this.pickUPLocation,
      dropOffLocation: dropOffLocation ?? this.dropOffLocation,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [
        name,
        phone,
        email,
        address,
        license,
        comments,
        pickUPLocation,
        dropOffLocation,
        isValid,
      ];
}
