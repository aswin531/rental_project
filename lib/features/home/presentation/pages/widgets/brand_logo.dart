// import 'package:dartz/dartz_streaming.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rentit/features/home/presentation/bloc/car/carbloc.dart';
// import 'package:rentit/features/home/presentation/bloc/car/carevent.dart';

// class BrandLogo extends StatelessWidget {
//   final String brand;

//   const BrandLogo({super.key, required this.brand});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => context.read<CarBloc>().add(FilterCars(brand)),
//       child: Container(
//         width: 60,
//         height: 60,
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//         ),
//         child: Center(child: Text(brand[0])),
//       ),
//     );
//   }
// }