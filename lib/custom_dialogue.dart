import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogue extends StatelessWidget {
  // const CustomDialogue({Key? key}) : super(key: key);
  
  final title;
  final content;
  final VoidCallback callback;
  final actionText;
  
  CustomDialogue(
      this.title,
      this.content,
      this.callback,
      [this.actionText = "Reset"]
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        ElevatedButton(onPressed: callback, child: Text(actionText))
      ],
    );
  }
}
