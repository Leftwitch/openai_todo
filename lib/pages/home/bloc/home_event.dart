part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeEventTodoCreateValueChanged extends HomeEvent {
  final String value;

  HomeEventTodoCreateValueChanged(this.value);
}

class HomeEventPredicted extends HomeEvent {
  final TodoPrediction prediction;

  HomeEventPredicted(this.prediction);
}

class HomeEventCreateTodo extends HomeEvent {}

class HomeEventAddTag extends HomeEvent {
  final String label;

  HomeEventAddTag(this.label);
}
