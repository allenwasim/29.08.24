import 'package:flutter/material.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TRoundedTextButton extends StatelessWidget {
  const TRoundedTextButton({
    super.key,
    required this.text,
    this.backgroundColor = Colors.transparent,
    required this.onPressed,
  });

  final String text;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
      child: SizedBox(
        width: 400,
        height: 60,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(70.0),
              side: BorderSide(
                color: dark
                    ? const Color.fromARGB(59, 255, 255, 255)
                    : const Color.fromARGB(59, 0, 0, 0),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
