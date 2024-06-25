import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_state.dart';

class AccountScreenWidget extends StatelessWidget {
  const AccountScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 2.h,
        backgroundColor: RentItColors.background,
      ),
      body: BlocBuilder<AuthBloc, Authstate>(
        builder: (context, state) {
          return Center(
            child: Container(
             // child: Text("email : ${state.}"),
            ),
          );
        },
      ),
    );
  }
}
