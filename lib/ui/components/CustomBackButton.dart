import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final BuildContext context;
  const CustomBackButton({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context), 
      icon: Icon(
        Icons.arrow_back_ios
      )
    );
  }
}