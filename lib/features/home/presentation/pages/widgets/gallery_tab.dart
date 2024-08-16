import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selected_bloc.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selectedcar_state.dart';

class GalleryTabWidget extends StatelessWidget {
  const GalleryTabWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedCarBloc, SelectedCarState>(
      builder: (context, state) {
        if (state is CarSelected) {
          final car = state.car;
          debugPrint('Car updated: ${state.car.make} ${state.car.model}');
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: StaggeredGrid.count(
              crossAxisCount: 4, // Number of columns in the grid
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              children: car.imageUrls
                  .map((imageUrl) => _buildImageTile(imageUrl))
                  .toList(),
            ),
          );
        } else {
          return const Center(child: Text('No images available.'));
        }
      },
    );
  }

  Widget _buildImageTile(String imageUrl) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(value: downloadProgress.progress),
          ),
          errorWidget: (context, url, error) =>
              const Icon(Icons.error, color: Colors.red),
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}
