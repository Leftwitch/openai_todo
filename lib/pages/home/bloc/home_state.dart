part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeDataState extends HomeState {
  final String todoCreateValue;
  final List<TodoItem> todos;
  final List<String> tags;
  final TodoPrediction? prediction;

  HomeDataState({
    this.todoCreateValue = '',
    this.todos = const [],
    this.tags = const [],
    this.prediction,
  });
}
