import 'package:flutter/material.dart';


class SearchBarWidget extends StatefulWidget {
  final void Function([String? searchInput]) fetch;

  const SearchBarWidget(this.fetch, {super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final searchInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Flexible(
          child: SizedBox(
            width: 400,
            child: TextField(
              decoration: const InputDecoration(hintText: 'Введите запрос'),
              key: Key('search_field'),
              controller: searchInput,
              onSubmitted: (_) => widget.fetch(searchInput.text),
            ),
          ),
        ),
        ElevatedButton(
          key: Key('search_button'),
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {
            widget.fetch(searchInput.text);
          },
          child: const Text('ПОИСК'),
        ),
      ],
    );
  }
}
