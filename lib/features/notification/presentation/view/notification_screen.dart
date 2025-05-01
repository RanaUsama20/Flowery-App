import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/base_state/base_state.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/di/service_locator.dart';
import 'package:flowery_app/features/notification/domain/entity/all_notification_entity.dart';
import 'package:flowery_app/features/notification/presentation/view_model/cubit/notification_cubit.dart';
import 'package:flowery_app/features/notification/presentation/widget/custom_body_notification.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final NotificationCubit _notificationCubit;
  @override
  initState() {
    super.initState();
    _notificationCubit = serviceLocator.get<NotificationCubit>()
      ..getAllNotification();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.profile_Notification.tr()),
        ),
        body: BlocBuilder<NotificationCubit, NotificationState>(
          bloc: _notificationCubit,
          builder: (context, state) {
            if (state.getAllNotificationState is BaseLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state.getAllNotificationState is BaseErrorState) {
              final result = state.getAllNotificationState as BaseErrorState;
              Navigator.of(context).pop();
              return Center(child: Text(result.errorMessage));
            } else if (state.getAllNotificationState is BaseSuccessState) {
              final ans = state.getAllNotificationState
                  as BaseSuccessState<List<AllNotificationEntity>?>;
              return ListView.separated(
                  itemCount: ans.data!.length,
                  separatorBuilder: (context, index) {
                    return Divider(
                        color: AppColors.white[AppColors.colorCode70]);
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: CustomBodyNotification(item: ans.data![index]));
                  });
            } else {
              return SizedBox();
            }
          },
        ));
  }
}
