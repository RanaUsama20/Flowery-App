import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;

  const CustomRadioButton({
    Key? key,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.pink ,
                width: 1,
              ),
            ),
            child: selected
                ? Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.pink ,
              ),
            )
                : SizedBox.shrink(),
          ),
          const SizedBox(width: 10),

        ],
      ),
    );
  }
}
