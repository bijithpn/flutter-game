import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_games/src/core/styles/app_colors.dart';

class SudokuCell extends StatelessWidget {
  const SudokuCell(
      {super.key,
      required this.controller,
      this.isPreFilled = false,
      required this.index});

  final TextEditingController controller;
  final int index;
  final bool isPreFilled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: (index ~/ 9) % 3 == 0 ? 4 : 1,
            color: AppColors.darkGray,
          ),
          left: BorderSide(
            width: (index % 9) % 3 == 0 ? 4 : 1,
            color: AppColors.darkGray,
          ),
          right: BorderSide(
            width: (index % 9 == 8) ? 2 : 1,
            color: AppColors.darkGray,
          ),
          bottom: BorderSide(
            width: (index ~/ 9 == 8) ? 2 : 1,
            color: AppColors.darkGray,
          ),
        ),
      ),
      child: TextFormField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        maxLength: 1,
        enabled: !isPreFilled,
        textAlign: TextAlign.center,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: isPreFilled ? AppColors.primaryColor : null,
            fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
