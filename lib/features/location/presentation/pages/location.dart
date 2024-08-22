import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:rentit/features/rental/domain/entity/rental_entity.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_state.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class RequestStatusCard extends StatefulWidget {
  const RequestStatusCard({super.key});

  @override
  _RequestStatusCardState createState() => _RequestStatusCardState();
}

class _RequestStatusCardState extends State<RequestStatusCard>
    with SingleTickerProviderStateMixin {
  bool _isVisible = true;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 20.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    final user = FirebaseAuth.instance.currentUser!.uid;
    context
        .read<RentalRequestBloc>()
        .add(FetchUserRentalRequestsWithCarDetailsEvent(user));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ExternalAppColors.bg,
      statusBarIconBrightness: Brightness.light,
    ));

    return _isVisible
        ? BlocBuilder<RentalRequestBloc, RentalRequestState>(
            builder: (BuildContext context, RentalRequestState state) {
              if (state is UserRentalRequestsWithCarDetailsLoaded) {
                final rentalRequestWithCarDetails =
                    state.requestsWithCarDetails.last;
                final isAccepted =
                    rentalRequestWithCarDetails.rentalRequest.status ==
                        RentalRequestStatus.accepted;
                final isRejected =
                    rentalRequestWithCarDetails.rentalRequest.status ==
                        RentalRequestStatus.rejected;

                return Stack(
                  children: [
                    ModalBarrier(
                      color: Colors.black.withOpacity(0.5),
                      dismissible: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Container(
                          width: double.infinity,
                          height: 550,
                          decoration: BoxDecoration(
                            color: isAccepted
                                ? const Color.fromARGB(255, 80, 123, 82)
                                    .withOpacity(0.8)
                                : const Color.fromARGB(255, 213, 130, 124),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SlideTransition(
                                position: _animation.drive(
                                  Tween<Offset>(
                                      begin: const Offset(0, 0.02),
                                      end: const Offset(0, 0)),
                                ),
                                child: SizedBox(
                                  width: 200,
                                  height: 40,
                                  child: Lottie.asset(
                                    isAccepted
                                        ? 'assets/animation/success.json'
                                        : isRejected
                                            ? 'assets/animation/ani2.json'
                                            : 'assets/animation/404.json',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 100),
                              Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Text(
                                  isAccepted ? 'Yayy!!' : 'Oops!!',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 46,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  isAccepted
                                      ? 'Your request is accepted!\nContinue to go to the next step.'
                                      : 'Your request was rejected.\nContinue.',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                height: 50,
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isVisible = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: isAccepted
                                        ? Colors.white
                                        : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: PrimaryText(
                                    text: isAccepted ? 'Continue' : 'Continue',
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is RentalRequestLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is RentalRequestError) {
                return Center(
                    child: Text(
                        'Failed to load rental requests: ${state.message}'));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
        : const SizedBox.shrink();
  }
}
