import 'dart:async';

import 'package:bloc_example/blocs/internet_bloc/internet_event.dart';
import 'package:bloc_example/blocs/internet_bloc/internet_state.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetBloc extends Bloc<InternetEvent,InternetState>{
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;
  InternetBloc() : super(InternetInitialState()){
    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
    on<InternetBackOnlineEvent>((event, emit) => emit(InternetBackOnlineState()));

    connectivitySubscription =  _connectivity.onConnectivityChanged.listen((event) {
      if(event == ConnectivityResult.mobile|| event == ConnectivityResult.wifi){
        add(InternetBackOnlineEvent());
      }else{
        add(InternetLostEvent());
      }
    });
  }
@override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }

}