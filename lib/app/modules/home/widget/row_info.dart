import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class RowInfo extends StatelessWidget {
  final String title;
  final String value;
  const RowInfo({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Observer(builder: (_) {
            return Text(value);
          }),
        ],
      ),
    );
  }
}
