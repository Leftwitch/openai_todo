import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/pages/home/widgets/list/list_item.dart';

import '../../bloc/home_bloc.dart';

class ListContainer extends StatelessWidget {
  const ListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is! HomeDataState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: state.todos
              .map(
                (todo) => ListItem(
                  item: todo,
                ),
              )
              .toList(),
        );
      },
    );
  }
}
