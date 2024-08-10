import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/home/presentation/bloc/car/carbloc.dart';
import 'package:rentit/features/home/presentation/bloc/car/carevent.dart';
import 'package:rentit/features/home/presentation/bloc/car/carstates.dart';
import 'package:rentit/features/home/presentation/pages/widgets/location_widget.dart';
import 'package:rentit/features/home/presentation/pages/widgets/popular_section.dart';
import 'package:rentit/features/home/presentation/pages/widgets/searchbar.dart';
import 'package:rentit/utils/shimmer_effects.dart';
import 'package:shimmer/shimmer.dart';

class CarListScreen extends StatelessWidget {
  const CarListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CarBloc, CarState>(
          builder: (context, state) {
            if (state is CarInitial) {
              context.read<CarBloc>().add(FetchCars());
              return const Center(child: CircularProgressIndicator());
            } else if (state is CarLoading) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: ShimmerCarCard(),
                  ),
                ),
              );
            } else if (state is CarLoaded) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: false,
                    floating: true,
                    backgroundColor: Colors.blue,
                    expandedHeight: 170.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LocationWidget(),
                            SizedBox(height: 8),
                            SearchBarWidget(),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 24),
                            PopularCarSection(),
                          ],
                        ),
                      ),
                      childCount: 1,
                    ),
                  ),
                ],
              );
            } else if (state is CarError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
    );
  }
}

class BrandLogo extends StatelessWidget {
  final String brand;
  const BrandLogo({super.key, required this.brand});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<CarBloc>().add(FilterCars(brand)),
      child: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Center(child: Text(brand[0])),
      ),
    );
  }
}
