
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rentit/features/authentication/presentation/bloc/authentication_bloc.dart';
// import 'package:rentit/features/profile/domain/usecases/profile_setup_saveuser_usecase.dart';
// import 'package:rentit/features/profile/presentation/bloc/profile_setup/profile_setup_bloc.dart';
// import 'package:rentit/features/profile/presentation/bloc/profile_setup/profile_setup_state.dart';

// class ProfileSetupPage extends StatelessWidget {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   final TextEditingController cityStateController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController licenseController = TextEditingController();
//   final TextEditingController dobController = TextEditingController();
//   final TextEditingController homeLocationController = TextEditingController();

//   ProfileSetupPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProfileSetupBloc(
//         saveUserProfileUsecase: context.read<SaveUserProfileUsecase>(),
//         userId: context.read<AuthBloc>().getCurrentUser()!.uid,
//       ),
//       child: BlocConsumer<ProfileSetupBloc, ProfileSetupState>(
//         listener: (context, state) {
//           if (state is ProfileSetupSuccess) {
//             context.read<AuthBloc>().add(CompleteProfileSetupEvent({}));
//             Navigator.of(context).pushReplacementNamed('/navBarBottom');
//           } else if (state is ProfileSetupError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.message)),
//             );
//           }
//         },
//         builder: (context, state) {
//           return Scaffold(
//             appBar: AppBar(title: Text('Profile Setup')),
//             body: SingleChildScrollView(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // Add image picker widget here
//                   TextFormField(
//                     controller: nameController,
//                     decoration: InputDecoration(labelText: 'Name'),
//                   ),
//                   TextFormField(
//                     controller: locationController,
//                     decoration: InputDecoration(labelText: 'Location'),
//                   ),
//                   TextFormField(
//                     controller: cityStateController,
//                     decoration: InputDecoration(labelText: 'City/State'),
//                   ),
//                   TextFormField(
//                     controller: phoneController,
//                     decoration: InputDecoration(labelText: 'Phone'),
//                   ),
//                   TextFormField(
//                     controller: licenseController,
//                     decoration: InputDecoration(labelText: 'License'),
//                   ),
//                   TextFormField(
//                     controller: dobController,
//                     decoration: InputDecoration(labelText: 'Date of Birth'),
//                     onTap: () async {
//                       final pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(1900),
//                         lastDate: DateTime.now(),
//                       );
//                       if (pickedDate != null) {
//                         dobController.text = pickedDate.toIso8601String().split('T')[0];
//                       }
//                     },
//                   ),
//                   TextFormField(
//                     controller: homeLocationController,
//                     decoration: InputDecoration(labelText: 'Home Location'),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: state is ProfileSetupLoading
//                         ? null
//                         : () {
//                             context.read<ProfileSetupBloc>().add(
//                                   SubmitProfileSetup(
//                                     name: nameController.text,
//                                     location: locationController.text,
//                                     cityState: cityStateController.text,
//                                     phone: phoneController.text,
//                                     license: licenseController.text,
//                                     dob: DateTime.parse(dobController.text),
//                                     homeLocation: homeLocationController.text,
//                                     // Add imageUrl here if implemented
//                                   ),
//                                 );
//                           },
//                     child: state is ProfileSetupLoading
//                         ? CircularProgressIndicator()
//                         : Text('Complete Setup'),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }