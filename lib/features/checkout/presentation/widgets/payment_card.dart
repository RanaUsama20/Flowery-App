
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import 'custom_radio_button.dart';

class PaymentCard extends StatefulWidget{
  String title;
  final bool selected;
  final VoidCallback onTap;
  PaymentCard({super.key, required this.title,required this.selected,required this.onTap});

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: AppColors.white,
        elevation: 1,
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),

                      CustomRadioButton(
                        selected: widget.selected,
                        onTap: widget.onTap
                      ),
                    ]),
              ),
            ]),
      ),
    );

  }
}