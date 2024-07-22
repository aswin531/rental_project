import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/home/presentation/bloc/carbloc.dart';
import 'package:rentit/features/home/presentation/bloc/carevent.dart';
import 'package:rentit/features/home/presentation/bloc/carstates.dart';
class CarListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cars')),
      body: BlocBuilder<CarBloc, CarState>(
        builder: (context, state) {
          if (state is CarInitial) {
            // Fetch cars when the state is initial
            context.read<CarBloc>().add(FetchCars());
            return const Center(child: CircularProgressIndicator());
          } else if (state is CarLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CarLoaded) {
            return ListView.builder(
              itemCount: state.cars.length,
              itemBuilder: (context, index) {
                final car = state.cars[index];
                return ListTile(
                  title: Text(car.model),
                  subtitle: Text(car.make),
                );
              },
            );
          } else if (state is CarError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CarBloc>().add(FetchCars()),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}