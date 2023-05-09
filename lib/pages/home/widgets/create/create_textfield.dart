import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_bloc.dart';

class CreateTextFieldWidget extends StatefulWidget {
  const CreateTextFieldWidget({super.key});

  @override
  State<CreateTextFieldWidget> createState() => _CreateTextFieldWidgetState();
}

class _CreateTextFieldWidgetState extends State<CreateTextFieldWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) {
        if (previous is! HomeDataState || current is! HomeDataState) {
          return false;
        }

        return current.todoCreateValue.trim().isEmpty;
      },
      listener: (context, state) {
        if (state is! HomeDataState) return;
        _controller.text = '';
      },
      child: SizedBox(
        height: 150,
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is! HomeDataState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return TextField(
              controller: _controller,
              maxLines: null,
              expands: true,
              keyboardType: TextInputType.multiline,
              textAlignVertical: TextAlignVertical.top,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Doctors Appointment tomorrow at 5:30...',
                border: InputBorder.none,
                fillColor: Colors.white,
              ),
              onChanged: (e) => {
                context.read<HomeBloc>().add(
                      HomeEventTodoCreateValueChanged(e),
                    )
              },
            );
          },
        ),
      ),
    );
  }
}
