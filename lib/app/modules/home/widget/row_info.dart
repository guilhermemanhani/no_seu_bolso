import 'package:dentro_do_bolso/app/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:dentro_do_bolso/app/core/ui/extensions/size_screen_extension.dart';

class RowInfo extends StatelessWidget {
  final String title;
  final String value;
  final Color colorText;
  const RowInfo({
    Key? key,
    required this.title,
    required this.value,
    this.colorText = Colors.black,
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
          Text(
            title,
            style: TextStyle(
              color: context.darkBlue,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: 100.w,
            ),
            child: Text(
              value,
              style: TextStyle(
                color: value.contains('-') ? Colors.red : colorText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
