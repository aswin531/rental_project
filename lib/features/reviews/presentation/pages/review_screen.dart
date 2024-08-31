import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rentit/features/reviews/presentation/bloc/review_bloc.dart';
import 'package:rentit/features/reviews/presentation/bloc/review_event.dart';
import 'package:rentit/features/reviews/presentation/bloc/review_state.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title:
              const Text('Leave Review', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: const ReviewForm(),
      ),
    );
  }
}

class ReviewForm extends StatelessWidget {
  const ReviewForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              'assets/toyota_fortuner.png', // Replace with your image path
              height: 120,
              width: 200,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Toyota Fortuner Legender',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 4),
                Text('4.5', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'How is Your Rental Experience?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text('Your overall rating'),
          const SizedBox(height: 8),
          BlocBuilder<ReviewBloc, ReviewState>(
            builder: (context, state) {
              return Center(
                child: RatingBar.builder(
                  initialRating: state.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 40,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    context.read<ReviewBloc>().add(RatingChanged(rating));
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          BlocBuilder<ReviewBloc, ReviewState>(
            builder: (context, state) {
              return TextField(
                decoration: const InputDecoration(
                  hintText: 'Add detailed review',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                onChanged: (value) {
                  context.read<ReviewBloc>().add(ReviewTextChanged(value));
                },
              );
            },
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {
              // Handle adding photo
            },
            icon: const Icon(Icons.add_a_photo),
            label: const Text('Add photo'),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.blue),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Handle continue action
                // You can access the final state here if needed
                final state = context.read<ReviewBloc>().state;
                debugPrint(
                    'Rating: ${state.rating}, Review: ${state.reviewText}');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}
