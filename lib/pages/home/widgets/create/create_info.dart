import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/home_bloc.dart';

DateFormat dateFormat = DateFormat('EEE, M/d/y hh:mm a');

class CreateInfoWidget extends StatelessWidget {
  const CreateInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is! HomeDataState) {
          return const SizedBox();
        }

        if (state.prediction == null && state.todoCreateValue.isNotEmpty) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            width: 20,
            height: 20,
            child: const CircularProgressIndicator(),
          );
        }

        return AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: state.prediction == null ? 0 : 1,
          child: SizedBox(
            height: 30,
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                if (state.prediction?.predictedTime != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildEntry(
                        Icons.timer,
                        dateFormat.format(
                          state.prediction!.predictedTime!,
                        ),
                      ),
                      _buildDivider(),
                    ],
                  ),
                if (state.prediction?.predictedLocation != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildEntry(
                        Icons.location_on,
                        state.prediction!.predictedLocation!,
                      ),
                      _buildDivider(),
                    ],
                  ),
                if (state.prediction?.predictedTag != null)
                  _buildEntry(
                    Icons.tag,
                    state.prediction!.predictedTag!,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDivider() {
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

  Widget _buildEntry(IconData icon, String text) {
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
