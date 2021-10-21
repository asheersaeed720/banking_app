import 'package:async_button_builder/async_button_builder.dart';
import 'package:banking_app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class CustomAsyncBtn extends StatelessWidget {
  const CustomAsyncBtn({
    Key? key,
    this.icon,
    required this.btntxt,
    this.btnColor,
    required this.onPress,
  }) : super(key: key);

  final Icon? icon;
  final String btntxt;
  final Color? btnColor;
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
              await Future.delayed(const Duration(seconds: 1));
            },
      showSuccess: false,
      errorWidget: const Text('error'),
      builder: (context, child, callback, _) {
        return SizedBox(
          width: double.infinity,
          height: 50.0,
          child: ElevatedButton(
            child: child,
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(btnColor == null ? AppTheme.buttonColor : Colors.blue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
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
