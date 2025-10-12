import 'package:flutter/material.dart';

class TopSearchBar extends StatelessWidget {
  final dynamic searchInput;
  final dynamic fetchNews;

  const TopSearchBar(this.searchInput, this.fetchNews, {super.key});

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
              onSubmitted: (_) {
                fetchNews();
              },
            ),
          ),
        ),
        ElevatedButton(
          key: Key('search_button'),
          style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
          onPressed: () {
            fetchNews();
          },
          child: const Text('ПОИСК'),
        ),
      ],
    );
  }
}
