import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/pages/home/widgets/create/create_button.dart';
import 'package:todo_flutter/pages/home/widgets/create/create_info.dart';
import 'package:todo_flutter/pages/home/widgets/create/create_textfield.dart';
import 'package:todo_flutter/pages/home/widgets/list/list_container.dart';
import 'package:todo_flutter/pages/home/widgets/list/list_tags.dart';

import 'bloc/home_bloc.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeBloc(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                'Create Todo',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 30,
              ),
              const CreateTextFieldWidget(),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: CreateInfoWidget(),
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: CreateButtonWidget(),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'My Todos',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 15),
              const ListTagsWidget(),
              const SizedBox(height: 15),
              const ListContainer()
            ],
          ),
        ),
      ),
    );
  }
}
