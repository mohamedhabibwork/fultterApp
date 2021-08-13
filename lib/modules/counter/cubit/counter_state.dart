abstract class CounterStates {}

class CounterInitStates extends CounterStates {}

class CounterPlusState extends CounterStates {
  final int counter;

  CounterPlusState(this.counter);
}

class CounterMinusStates extends CounterStates {
  final int counter;

  CounterMinusStates(this.counter);
}
