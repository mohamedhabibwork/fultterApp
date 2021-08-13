import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_state.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CounterInitStates());

  static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 0;

  void incrementCounter() {
    counter++;
    emit(CounterPlusState(counter));
  }
}
