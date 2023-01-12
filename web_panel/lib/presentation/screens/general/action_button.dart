import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../config/colors/colors.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width,
    this.height,
    this.icon,
    this.isLoading = false,
    this.padding,
  });

  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  final double? width;
  final double? height;
  final Icon? icon;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(padding),
        ),
        onPressed: onPressed,
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: AppColors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null) icon!,
                  SizedBox(width: 10),
                  AutoSizeText(
                    text,
                    style: Theme.of(context).textTheme.button?.copyWith(
                          color: AppColors.white,
                          fontSize: 16,
                        ),
                    maxLines: 1,
                  ),
                ],
              ),
      ),
    );
  }
}
