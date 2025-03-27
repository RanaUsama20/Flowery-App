import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/features/auth/presentation/view_model/cubit/register_cubit.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class SectionOfGenderWidget extends StatefulWidget {
  final RegisterCubit registerCubit;
  const SectionOfGenderWidget({required this.registerCubit, super.key});

  @override
  State<SectionOfGenderWidget> createState() => _SectionOfGenderWidgetState();
}

class _SectionOfGenderWidgetState extends State<SectionOfGenderWidget> {
  int selectGender = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
      children: [
        Text(
          LocaleKeys.Authentication_Gender.tr(),
          style: theme.titleMedium!
              .copyWith(color: AppColors.white[AppColors.colorCode90]),
        ),
        SizedBox(width: 5),
        Expanded(
            child: Row(
          children: [
            Expanded(
                child: _CustomListTile(
                    groupValue: selectGender,
                    onSelect: (value) {
                      setState(() {
                        selectGender = value;
                        widget.registerCubit.gender = 'femail';
                      });
                    },
                    title: LocaleKeys.Authentication_Female.tr(),
                    value: 1)),
            Expanded(
                child: _CustomListTile(
                    groupValue: selectGender,
                    onSelect: (value) {
                      setState(() {
                        selectGender = value;
                        widget.registerCubit.gender = 'male';
                      });
                    },
                    title: LocaleKeys.Authentication_Male.tr(),
                    value: 2))
          ],
        ))
      ],
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final int value;
  final int groupValue;
  final Function onSelect;
  final String title;
  const _CustomListTile(
      {required this.groupValue,
      required this.onSelect,
      required this.title,
      required this.value,
      super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return ListTile(
      title: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(title, style: theme.labelMedium),
      ),
      leading: Radio(
          value: value,
          groupValue: groupValue,
          onChanged: (value) => onSelect(value)),
    );
  }
}
