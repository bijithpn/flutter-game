import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_games/src/core/styles/app_colors.dart';

class SudokuCell extends StatelessWidget {
  SudokuCell({
    super.key,
    required this.controller,
    this.isPreFilled = false,
    this.updateCallback,
    required this.index,
  });

  final TextEditingController controller;
  final int index;
  final bool isPreFilled;
  final VoidCallback? updateCallback;

  int backspace = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus();
      },
      child: Container(
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
          textInputAction: TextInputAction.next,
          readOnly: !isPreFilled,
          enabled: isPreFilled,
          enableInteractiveSelection: false,
          onChanged: (value) {
            if (value.isNotEmpty) {
              backspace = 0;
              FocusScope.of(context).nextFocus();
              if (updateCallback != null) {
                updateCallback!();
              }
            }
            if (value.isEmpty) {
              backspace = backspace + 1;
            }
            if (backspace > 0 && index != 0) {
              FocusScope.of(context).previousFocus();
            }
          },
          cursorColor: AppColors.primaryColor,
          textAlign: TextAlign.center,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: !isPreFilled ? AppColors.primaryColor : null,
              fontWeight: FontWeight.bold),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
