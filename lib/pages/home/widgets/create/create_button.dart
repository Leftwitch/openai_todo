import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_bloc.dart';

class CreateButtonWidget extends StatelessWidget {
  const CreateButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state is! HomeDataState || state.prediction == null
              ? null
              : () => context.read<HomeBloc>().add(
                    HomeEventCreateTodo(),
                  ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.add),
              SizedBox(
                width: 5,
              ),
              Text('Create Todo')
            ],
          ),
        );
      },
    );
  }
}
