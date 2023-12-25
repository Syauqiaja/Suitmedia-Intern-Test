import 'package:flutter/material.dart';

class PalindromeCheckDialog extends StatefulWidget {
  final String palindromeText;
  const PalindromeCheckDialog({super.key, required this.palindromeText});

  @override
  State<PalindromeCheckDialog> createState() => _PalindromeCheckDialogState();
}

class _PalindromeCheckDialogState extends State<PalindromeCheckDialog> {
  bool CheckPal(String text){
    text = text.toLowerCase().replaceAll(" ", "");
    int i = 0;
    bool result = true;
    while(i< text.length - i){
      if (text[i] != text[text.length - i - 1]) {
        result = false;
        break;
      }
      i++;
    }
    return result;
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Check Result"),
      content: Text(CheckPal(widget.palindromeText) ? "isPalindrome" : "not palindrome"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, "Cancel"), 
          child: const Text("Cancel")
        )
      ],
    );
  }
}