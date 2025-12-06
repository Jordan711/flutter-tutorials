// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'counter_cubit.dart';

class CounterState extends Equatable {
  final int counterValue;
  final bool wasIncremented;

  const CounterState({
    required this.counterValue,
    this.wasIncremented = false,
  });

  @override
  List<Object?> get props => [counterValue, wasIncremented];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'counterValue': counterValue,
      'wasIncremented': wasIncremented,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(
      counterValue: map['counterValue'] as int,
      wasIncremented: map['wasIncremented'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) => CounterState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CounterState(counterValue: $counterValue, wasIncremented: $wasIncremented)';
  }
}

/**
 * onEvent (BLOC)
 * a method that is called before a new event gets dispatched to the stream of Events
 * CounterEvent.increment
 * 
 * onChange
 * a method that is called before a new state gets dispatched to the stream of States
 * Change {currentState: 0, nextState: 1}
 * 
 * onTransition (BLOC)
 * a method that gets called before a new State gets dispatched 
 * contains both current State, the next State, and the Even that triggered them 
 * Transition {currentState: 0, event: CounterEvent.increment, nextState: 1}
 * 
 * Bloc Observer contains all of those methods
 * onCreate
 * onClose
 */