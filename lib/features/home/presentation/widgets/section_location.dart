import 'package:flowery_app/core/app/app_cubit/app_cubit_cubit.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/enum/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SectionLocation extends StatelessWidget {
  const SectionLocation({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return BlocBuilder<AppCubit, AppCubitState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.location == Status.loading,
          child: Row(
            children: [
              Icon(Icons.location_on_outlined),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Live in ${state.location == Status.loading ? '...' : state.location == Status.success ? state.locationAddress.street : 'open location pleas...'}',
                  style: theme.labelMedium!
                      .copyWith(color: AppColors.gray, fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
