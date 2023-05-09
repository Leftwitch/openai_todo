import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_bloc.dart';

class ListTagsWidget extends StatelessWidget {
  const ListTagsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is! HomeDataState) {
          return const SizedBox();
        }

        return Wrap(
          spacing: 5,
          children: [
            ...state.tags
                .map(
                  (tag) => Chip(
                    key: ValueKey(tag),
                    label: Text('#$tag'),
                    backgroundColor: colorFor(tag),
                  ),
                )
                .toList(),
            ActionChip(
              onPressed: () => _openAddTagDialog(context),
              label: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
              backgroundColor: Colors.black,
            )
          ],
        );
      },
    );
  }

  //Source: https://anoop4real.medium.com/flutter-generate-color-hash-uicolor-from-string-names-fb2ac75bde6b
  Color colorFor(String text) {
    var hash = 0;
    for (var i = 0; i < text.length; i++) {
      hash = text.codeUnitAt(i) + ((hash << 5) - hash);
    }
    final finalHash = hash.abs() % (256 * 256 * 256);
    final red = ((finalHash & 0xFF0000) >> 16);
    final blue = ((finalHash & 0xFF00) >> 8);
    final green = ((finalHash & 0xFF));
    final color = Color.fromRGBO(red, green, blue, 1);
    return color;
  }

  Future<void> _openAddTagDialog(BuildContext parentContext) {
    return showDialog<void>(
      context: parentContext,
      builder: (BuildContext context) {
        final controller = TextEditingController();

        return AlertDialog(
          title: const Text('Add a Label'),
          content: TextField(controller: controller),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Add Label'),
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  parentContext
                      .read<HomeBloc>()
                      .add(HomeEventAddTag(controller.text));
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
