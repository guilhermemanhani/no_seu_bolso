import 'package:dentro_do_bolso/app/core/ui/extensions/size_screen_extension.dart';
import 'package:flutter/material.dart';

class DentrodobolsoDropDownButton extends StatelessWidget {
  final Widget widget;
  const DentrodobolsoDropDownButton({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 1),
      ),
      width: 200.w,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 4),
        child: widget,
      ),
    );
  }
}
