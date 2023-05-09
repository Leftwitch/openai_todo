import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_flutter/types/todo.dart';
import 'package:todo_flutter/types/todo_prediction.dart';

import '../../../openai/openai_api.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // Debounce logic source: https://stackoverflow.com/questions/51791501/how-to-debounce-textfield-onchange-in-dart
  Timer? _debounce;

  HomeBloc() : super(HomeDataState()) {
    /// When we change our input we wan't to
    /// change our state accordingly
    on<HomeEventTodoCreateValueChanged>((event, emit) {
      var currentState = state;
      if (currentState is! HomeDataState) return;
      triggerPrediction(event.value, currentState.tags);

      emit(
        HomeDataState(
          prediction: null,
          todoCreateValue: event.value,
          todos: currentState.todos,
          tags: currentState.tags,
        ),
      );
    });

    /// This is called when our prediction is ready
    /// so we add our predictions to the current state
    on<HomeEventPredicted>((event, emit) {
      var currentState = state;
      if (currentState is! HomeDataState) return;
      emit(
        HomeDataState(
          todoCreateValue: currentState.todoCreateValue,
          todos: currentState.todos,
          prediction: event.prediction,
          tags: currentState.tags,
        ),
      );
    });

    /// This is called when an Todo is created, before we do that we also
    /// cancel the current debounce so we don't get our prediction after the
    /// user has already added the todo
    on<HomeEventCreateTodo>((event, emit) {
      var currentState = state;
      if (currentState is! HomeDataState) return;

      final item = TodoItem(
        title: 'Todo #${currentState.todos.length + 1}',
        description: currentState.todoCreateValue,
        dueDate: currentState.prediction?.predictedTime,
        location: currentState.prediction?.predictedLocation,
        tag: currentState.prediction?.predictedTag,
      );
      // Cancel prediction if added early and its still running
      if (_debounce?.isActive ?? false) _debounce?.cancel();

      emit(
        HomeDataState(
            prediction: null,
            todos: [
              ...currentState.todos,
              item,
            ],
            todoCreateValue: '',
            tags: currentState.tags),
      );
    });

    /// This is called as soon a Tag is added, we just add it to the list
    on<HomeEventAddTag>(
      (event, emit) {
        var currentState = state;
        if (currentState is! HomeDataState) return;

        emit(
          HomeDataState(
            tags: [...currentState.tags, event.label],
            prediction: currentState.prediction,
            todoCreateValue: currentState.todoCreateValue,
            todos: currentState.todos,
          ),
        );
      },
    );
  }

  triggerPrediction(String value, List<String> tags) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final prediction = await predictTodo(value, tags);
        add(HomeEventPredicted(prediction));
      } catch (e) {
        add(
          HomeEventPredicted(
            TodoPrediction(),
          ),
        );
      }
    });
  }
}
