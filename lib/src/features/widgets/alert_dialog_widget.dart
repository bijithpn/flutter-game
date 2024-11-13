import 'package:flutter/material.dart';
import 'package:flutter_games/src/core/styles/app_colors.dart';

class DialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final String buttonTitle;
  final VoidCallback? onTap;
  final Widget buttonIcon;
  const DialogWidget({
    super.key,
    this.title = 'Opps!',
    this.buttonIcon = const Icon(Icons.refresh),
    this.onTap,
    this.buttonTitle = "Try Again",
    this.message =
        "Oops! It seems that some columns are missing, or the Sudoku data is incorrect. Please check the puzzle and try again.",
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton.icon(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor, elevation: 3),
          icon: buttonIcon,
          label: Text(
            buttonTitle,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
