import 'package:bloc_example/blocs/internet_bloc/internet_bloc.dart';
import 'package:bloc_example/blocs/internet_bloc/internet_event.dart';
import 'package:bloc_example/blocs/internet_bloc/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<InternetBloc, InternetState>(
          listener: (context, state) {
            if (state is InternetBackOnlineState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Internet Connected"),
                  backgroundColor: Colors.green,
                ),
              );
            }else if (state is InternetLostState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Internet Not Connected"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is InternetBackOnlineState) {
              return Text("Connected");
            } else if (state is InternetLostState) {
              return Text("Not Connected");
            } else {
              return Text("Loading...");
            }
          },
        ),
      ),
    );
  }
}
