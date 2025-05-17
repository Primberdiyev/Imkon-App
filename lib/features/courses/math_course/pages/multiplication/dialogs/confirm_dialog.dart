import 'package:flutter/material.dart';

class ConfirmExitDialog extends StatelessWidget {
  const ConfirmExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Chiqishni tasdiqlang'),
      content: Text('Bosh sahifaga qaytishni xohlaysizmi?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('Bekor qilish'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: Text('Ha, chiqish'),
        ),
      ],
    );
  }
}
