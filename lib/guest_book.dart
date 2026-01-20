import 'dart:async';
import 'guest_book_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class GuestBook extends StatefulWidget {
  const GuestBook(
      {required this.addMessages, required this.messages, super.key});

  final FutureOr<void> Function(String message) addMessages;
  final List<GuestBookMessage> messages;

  @override
  State<GuestBook> createState() => _GuestBookState();
}

class _GuestBookState extends State<GuestBook> {
  final _formkey = GlobalKey<FormState>(debugLabel: '_GuestBookState');
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
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
        ),
        const SizedBox(height: 8.0),
        Consumer<AppState>(
          builder: (context, appState, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final message in appState.guestBookMessages)
                  Text('${message.name}: ${message.message}'),
              ],
            );
          },
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
