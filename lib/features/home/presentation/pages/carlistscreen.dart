import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/home/presentation/bloc/brand/brand_bloc.dart';
import 'package:rentit/features/home/presentation/bloc/brand/brand_event.dart';
import 'package:rentit/features/home/presentation/bloc/brand/brand_states.dart';
import 'package:rentit/features/home/presentation/bloc/car/carbloc.dart';
import 'package:rentit/features/home/presentation/bloc/car/carevent.dart';
import 'package:rentit/features/home/presentation/bloc/car/carstates.dart';
import 'package:rentit/features/home/presentation/pages/widgets/all_brands_page.dart';
import 'package:rentit/features/home/presentation/pages/widgets/brand_section.dart';
import 'package:rentit/features/home/presentation/pages/widgets/location_widget.dart';
import 'package:rentit/features/home/presentation/pages/widgets/popular_section.dart';
import 'package:rentit/features/home/presentation/pages/widgets/searchbar.dart';
import 'package:rentit/features/location/presentation/bloc/location_bloc.dart';
import 'package:rentit/features/location/presentation/bloc/location_event.dart';
import 'package:rentit/features/location/presentation/bloc/location_state.dart';
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
      body: MultiBlocListener(listeners: [
         BlocListener<LocationMapBloc, LocationMapState>(
            listener: (context, state) {
if (state.currentAddress == null) {
      context.read<LocationMapBloc>().add(MoveToCurrentLocation());
    }                        },
          ),
          BlocListener<CarBloc, CarState>(
            listener: (context, state) {
              if (state is CarInitial) {
                context.read<CarBloc>().add(FetchCars());
              }
            },
          ),
      ],
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
              context.read<BrandsBloc>().add(const FetchBrands());
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
                  BlocBuilder<BrandsBloc, BrandsState>(
                    builder: (context, state) {
                      if (state is BrandsLoading) {
                        return const SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (state is BrandsLoaded) {
                        debugPrint('CarListScreen: Brands loaded successfully');
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BrandListWidget(
                              brands: state.brands,
                              onViewAll: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AllBrandsPage(),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      } else if (state is BrandsError) {
                        debugPrint(
                            'CarListScreen: Failed to load brands - ${state.message}');
                        return SliverToBoxAdapter(
                          child: Center(child: Text(state.message)),
                        );
                      }
                      return const SliverToBoxAdapter();
                    },
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
              debugPrint('CarListScreen: Failed to load cars - ${state.message}');
        
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
