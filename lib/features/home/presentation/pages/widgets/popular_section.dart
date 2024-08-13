import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/home/presentation/bloc/car/carbloc.dart';
import 'package:rentit/features/home/presentation/bloc/car/carevent.dart';
import 'package:rentit/features/home/presentation/bloc/car/carstates.dart';
import 'package:rentit/features/home/presentation/pages/widgets/car_cards_home.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class PopularCarSection extends StatelessWidget {
  const PopularCarSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarBloc, CarState>(
      builder: (context, state) {
        if (state is CarLoaded) {
          final cars = state.cars;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    text: "Popular Cars",
                    color: ExternalAppColors.black,
                    fontWeight: FontWeight.w700,
                    size: 25,
                  ),
                  TextButton(
                    onPressed: () => context.read<CarBloc>().add(FetchCars()),
                    child: const Text('View All',
                        style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  //final car = cars[index];
                  return CarCard(
                   
                    car: cars[index],
                  );
                },
              ),
            ],
          );
        } else if (state is CarLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CarError) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }
}
