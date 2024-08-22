import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:rentit/features/rental/domain/entity/rental_entity.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_state.dart';

class RequestStatusCard extends StatefulWidget {
  @override
  _RequestStatusCardState createState() => _RequestStatusCardState();
}

class _RequestStatusCardState extends State<RequestStatusCard> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser!.uid;
    context
        .read<RentalRequestBloc>()
        .add(FetchUserRentalRequestsWithCarDetailsEvent(user));
  }

  @override
  Widget build(BuildContext context) {
    return _isVisible
        ? BlocBuilder<RentalRequestBloc, RentalRequestState>(
            builder: (BuildContext context, RentalRequestState state) {
              debugPrint('Current state: $state');
              if (state is UserRentalRequestsWithCarDetailsLoaded) {
                final rentalRequestWithCarDetails =
                    state.requestsWithCarDetails.last;
                final isAccepted =
                    rentalRequestWithCarDetails.rentalRequest.status ==
                        RentalRequestStatus.accepted;
                final isRejected =
                    rentalRequestWithCarDetails.rentalRequest.status ==
                        RentalRequestStatus.rejected;

                debugPrint('Is accepted: $isAccepted');
                debugPrint(
                    'Request details: ${rentalRequestWithCarDetails.toString()}');

                return Stack(
                  children: [
                    ModalBarrier(
                        color: Colors.black.withOpacity(0.5),
                        dismissible: false),
                    Positioned(
                      top: 50,
                      right: 20,
                      left: 20,
                      child: Container(
                        width: double.infinity,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 5,
                          color: isAccepted
                              ? Colors.green[100]
                              : isRejected
                                  ? Colors.red[100]
                                  : Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Lottie.asset(
                                  isAccepted
                                      ? 'assets/animation/success.json'
                                      : isRejected
                                          ? 'assets/animation/error.json'
                                          : 'assets/animation/pending.json',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    isAccepted
                                        ? 'Your request has been accepted!'
                                        : isRejected
                                            ? 'Your request has been rejected.'
                                            : 'Your request is pending.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isAccepted
                                          ? Colors.green[800]
                                          : isRejected
                                              ? Colors.red[800]
                                              : Colors.grey[800],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isVisible = false;
                                    });
                                  },
                                  child: Icon(Icons.close,
                                      color: Colors.grey[800]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is RentalRequestLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is RentalRequestError) {
                debugPrint(state.message);
                return Center(
                    child: Text(
                        'Failed to load rental requests.: ${state.message}'));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )
        : SizedBox.shrink();
  }
}
