import 'package:flutter/material.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';
import 'package:rentit/widgets/custom_container.dart';

class CarDetails extends StatelessWidget {
  final String brand;
  final String model;
  final String rentalPrice;
  final String body;
  final String imageUrl;

  const CarDetails(
      {super.key,
      required this.brand,
      required this.model,
      required this.rentalPrice,
      required this.body,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: ExternalAppColors.bg,
                  borderRadius: BorderRadius.circular(15)),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                          fit: BoxFit.cover,
                          height: 220,
                          width: double.infinity,
                          imageUrl
                          //rentalRequestWithCarDetails.car.imageUrls.last
                          ),
                    ),
                  ),
                  const Positioned(
                    top: 15,
                    left: 10,
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 25),
                        SizedBox(width: 5),
                        PrimaryText(
                          text: '4.9',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 15,
                      right: 15,
                      child: CustomContainer(text: body)),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomContainer(text: brand),
                  const SizedBox(
                    height: 8,
                  ),
                  PrimaryText(
                    text: model,
                    size: 20,
                    color: ExternalAppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: rentalPrice,
                      //'\$${rentalRequestWithCarDetails.car.rentalPriceRange.start.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: ExternalAppColors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '/hr',
                      style: TextStyle(
                          color: ExternalAppColors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            height: 20,
            color: ExternalAppColors.bg,
            thickness: 2,
          )
        ],
      ),
    );
  }
}



// Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Align(
                //     alignment: Alignment.bottomLeft,
                //     child: Container(
                //       color: Colors.amber,
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: PrimaryText(
                //             text: rentalRequestWithCarDetails
                //                 .rentalRequest.status
                //                 .toString()
                //                 .toUpperCase()
                //                 .split('.')
                //                 .last,
                //             size: 20,
                //             fontWeight: FontWeight.bold,
                //             color: getStatusColor(rentalRequestWithCarDetails
                //                 .rentalRequest.status)),
                //       ),
                //     ),
                //   ),
                // ),