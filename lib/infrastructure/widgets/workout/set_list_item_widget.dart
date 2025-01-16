import 'package:flutter/material.dart';
import 'package:overload/domain/workout/set/metric.dart';
import 'package:overload/domain/workout/set/set.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';

class SetListItemWidget extends StatelessWidget {
  final Set set;

  const SetListItemWidget({super.key, required this.set});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      color: AppColorScheme.lightBackground,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the set index
            Text(
              'Set ${set.index.value}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),
            // Iterate over the metrics
            for (Metric metric in set.metrics.value)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Enter value',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10.0,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      metric.unit.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
