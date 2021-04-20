import 'package:flutter/material.dart';
import 'package:flutter2_mysql/view/widget/common_button.dart';

class DialogUtils {
  static Future<void> okCancelDialog(
    BuildContext context, {
    @required String text,
    VoidCallback onCancel,
    VoidCallback onPressed,
  }) {
    return Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('$text'),
          actions: [
            onCancel != null
                ? MyButton(
                    'Cancel',
                    onPressed: () => Navigator.pop(context),
                    color: Colors.grey,
                  )
                : SizedBox.shrink(),
            MyButton(
              'Ok',
              onPressed: () {
                Navigator.pop(context);
                if (onPressed != null) onPressed.call();
              },
            ),
          ],
        ),
      );
    });
  }
}
