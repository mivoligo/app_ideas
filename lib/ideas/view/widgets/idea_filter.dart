import 'package:flutter/material.dart';

class IdeaFilter extends StatelessWidget {
  const IdeaFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ActionChip(
          label: const Text('FIRST ONE'),
          onPressed: () {},
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FilterChip(
            label: const Text('label'),
            selected: true,
            onSelected: (_) {},
          ),
        ),
        FilterChip(
          label: const Text('label'),
          onSelected: (_) {},
        ),
        FilterChip(
          label: const Text('label'),
          onSelected: (_) {},
        ),
        FilterChip(
          label: const Text('label'),
          onSelected: (_) {},
        ),
        FilterChip(
          label: const Text('label'),
          onSelected: (_) {},
        ),
        FilterChip(
          label: const Text('label'),
          onSelected: (_) {},
        ),
        FilterChip(
          label: const Text('label'),
          onSelected: (_) {},
        ),
        FilterChip(
          label: const Text('label'),
          onSelected: (_) {},
        ),
      ],
    );
  }
}
