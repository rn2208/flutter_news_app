import 'package:flutter/material.dart';

class NotFoundNews extends StatelessWidget {
  const NotFoundNews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        SizedBox(width: 300, height: 300, child: Image.asset('assets/images/quad.gif', fit: BoxFit.cover)),
        Text('Новости не найдены', style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
