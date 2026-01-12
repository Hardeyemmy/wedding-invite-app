import 'dart:async';
import 'package:flutter/material.dart';
import 'widgets.dart';

class GuestBook extends StatefulWidget {
  const GuestBook({required this.addMessages, super.key});

  final FutureOr<void> Function(String message) addMessages;

  @override
  State<GuestBook> createState() => _GuestBookState();
}

class _GuestBookState extends State<GuestBook> {
  final _formkey = GlobalKey<FormState>(debugLabel: '_GuestBookState');
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formkey,
        child: Row(
          children: [
            Expanded(
                child: TextFormField(
              controller: _messageController,
              decoration:
                  const InputDecoration(hintText: 'Send us your wishes'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Kindly Enter your wishes';
                }
                return null;
              },
            )),
            const SizedBox(width: 8.0),
            ElevatedButton(
              onPressed: () async {
                if (_formkey.currentState!.validate()) {
                  await widget.addMessages(_messageController.text);
                  _messageController.clear();
                }
              },
              child: const Row(
                children: [
                  Icon(Icons.send),
                  SizedBox(width: 4.0),
                  Text('Send Wishes')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
