import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/core/di/dependency_injection.dart';
import 'package:rentit/features/rental/presentation/bloc/tab_blloc/bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/tab_blloc/event.dart';
import 'package:rentit/features/rental/presentation/bloc/tab_blloc/state.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/widgets/booking_components.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/widgets/completed_booking_rental.dart';
import 'package:rentit/features/returncar/presentation/pages/return_screen.dart';
import 'package:rentit/utils/appcolors.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, TabState>(
      builder: (context, state) {
        _tabController.index = state.currentIndex;

        return Scaffold(
          backgroundColor: ExternalAppColors.bg,
          appBar: AppBar(
            title: const Text('My Booking'),
            bottom: TabBar(
              dividerColor: Colors.transparent,
              indicatorColor: Colors.blue,
              labelColor: Colors.blue,
              controller: _tabController,
              onTap: (index) =>
                  context.read<TabBloc>().add(BookingTabChanged(index)),
              tabs: const [
                Tab(text: 'My requests'),
                Tab(text: 'Completed'),
                Tab(text: 'Cancelled'),
              ],
            ),
          ),
          body: IndexedStack(
            index: state.currentIndex,
            children: [
              const BookingContent(),
              const CompletedBookingsContent(),
              // const ReviewSummaryScreen(),
              //ConfirmCarReturnForm(),
              InitiateCarReturnButton(firebaseAuthInstance.currentUser!.uid)
              // Center(child: Text('Cancelled Bookings')),
            ],
          ),
        );
      },
    );
  }
}
