import 'package:flutter/material.dart';

class SectionEstimate extends StatelessWidget {
 final  String  estimateTime;
  const SectionEstimate({required this.estimateTime,super.key});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Estimated arrival',
                      style: theme.textTheme.bodySmall!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      estimateTime,
                      style: theme.textTheme.titleSmall,
                    ),
                  ],
                );
  }
}