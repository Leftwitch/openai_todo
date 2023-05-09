import 'package:flutter/material.dart';
import 'package:todo_flutter/types/todo.dart';

import '../create/create_info.dart';

class ListItem extends StatelessWidget {
  final TodoItem item;
  const ListItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          Text(
            item.description,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(),
          _buildFooter()
        ],
      ),
    ));
  }

  /// This code is duplicated from create_info.dart
  /// Usually you would make a smart widget which can be used
  /// for both, however for demo purposes I decided to duplicate
  /// them to understand more easily what is happening
  Widget _buildFooter() {
    return Wrap(
      children: [
        if (item.dueDate != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFooterEntry(
                Icons.timer,
                dateFormat.format(item.dueDate!),
              ),
              _buildFooterDivider(),
            ],
          ),
        if (item.location != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFooterEntry(Icons.location_on, item.location!),
              _buildFooterDivider(),
            ],
          ),
        if (item.tag != null)
          _buildFooterEntry(
            Icons.tag,
            item.tag!,
          ),
      ],
    );
  }

  /// This code is duplicated from create_info.dart
  /// Usually you would make a smart widget which can be used
  /// for both, however for demo purposes I decided to duplicate
  /// them to understand more easily what is happening
  Widget _buildFooterDivider() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        SizedBox(
          width: 10,
        ),
        Text('|'),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  /// This code is duplicated from create_info.dart
  /// Usually you would make a smart widget which can be used
  /// for both, however for demo purposes I decided to duplicate
  /// them to understand more easily what is happening
  Widget _buildFooterEntry(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        const SizedBox(
          width: 5,
        ),
        Text(text),
      ],
    );
  }
}
