import 'package:async_button_builder/async_button_builder.dart';
import 'package:banking_app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class CustomAsyncBtn extends StatelessWidget {
  const CustomAsyncBtn({
    Key? key,
    this.icon,
    required this.btntxt,
    this.height = 48.0,
    this.btnColor,
    this.borderRadius = 50,
    required this.onPress,
  }) : super(key: key);

  final Icon? icon;
  final String btntxt;
  final double height;
  final Color? btnColor;
  final double borderRadius;
  final dynamic onPress;

  @override
  Widget build(BuildContext context) {
    return AsyncButtonBuilder(
      child: icon == null
          ? Text(
              btntxt,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                color: Colors.white,
              ),
            )
          : Row(
              children: [
                icon!,
                const SizedBox(width: 42.0),
                Text(btntxt, style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
      // ignore: unnecessary_null_comparison
      onPressed: onPress == null
          ? null
          : () async {
              await onPress();
            },
      showSuccess: false,
      errorWidget: const Text('error'),
      builder: (context, child, callback, _) {
        return SizedBox(
          width: double.infinity,
          height: height,
          child: ElevatedButton(
            child: child,
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(btnColor == null ? AppTheme.buttonColor : Colors.blue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            ),
            onPressed: callback,
          ),
        );
      },
    );
  }
}
