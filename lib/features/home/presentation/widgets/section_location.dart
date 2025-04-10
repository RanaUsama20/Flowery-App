import 'package:flutter/material.dart';

class SectionLocation extends StatelessWidget {
  const SectionLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context).textTheme;
    return Row(
              children: [
                Icon(Icons.location_on_outlined),
                const SizedBox(width: 8),
                Text(
                  'Deliver to 2XVP+XC - Sheikh Zayed',
                  style: theme.labelMedium,
                )
              ],
            );
  }
}