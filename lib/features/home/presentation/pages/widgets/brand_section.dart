// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rentit/features/home/presentation/bloc/car/carbloc.dart';
// import 'package:rentit/features/home/presentation/bloc/car/carstates.dart';
// import 'package:rentit/features/home/presentation/pages/carlistscreen.dart';

// class BrandSection extends StatelessWidget {
//   const BrandSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CarBloc, CarState>(
//       builder: (context, state) {
//         if (state is BrandsLoaded) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Brands',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               const SizedBox(height: 16),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: state.brands.map((brand) => Padding(
//                     padding: const EdgeInsets.only(right: 16),
//                     child: BrandLogo(brand: brand),
//                   )).toList(),
//                 ),
//               ),
//             ],
//           );
//         } else {
//           // Trigger brands fetch if not loaded
//           //context.read<CarBloc>().add(const FetchBrands());
//           return const CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }