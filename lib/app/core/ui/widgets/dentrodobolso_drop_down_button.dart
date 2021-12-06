import 'package:dentro_do_bolso/app/core/ui/extensions/size_screen_extension.dart';
import 'package:flutter/material.dart';

class DentrodobolsoDropDownButton extends StatelessWidget {
  final String selectValue;
  final Function onChange;
  final List<String> valueList;
  const DentrodobolsoDropDownButton({
    Key? key,
    required this.selectValue,
    required this.onChange,
    required this.valueList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 2),
      ),
      width: 160.w,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 4),
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectValue,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey[400],
          ),
          iconSize: 24,
          elevation: 16,
          style:
              TextStyle(color: Colors.grey[400], fontWeight: FontWeight.w600),
          underline: Container(
            width: double.infinity,
          ),
          onChanged: (String? newValue) => onChange(),
          items: valueList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
