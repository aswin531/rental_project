import 'package:flutter/material.dart';
import 'package:rentit/utils/primary_text.dart';

class CarDetails extends StatelessWidget {
  //
  const CarDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color:const Color.fromARGB(255, 227, 231, 233),
            elevation: 10,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/civic-bg.png',
                ),
                const Positioned(
                  bottom: 8,
                  left: 8,
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 25,
                      ),
                      SizedBox(
                        width: 5,
                      ),
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
                  bottom: 5,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    color: Colors.black.withOpacity(0.5),
                    child: const PrimaryText(
                      text: '\$27.00 /hr',
                      size: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: PrimaryText(
              text: 'KIA',
              size: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}