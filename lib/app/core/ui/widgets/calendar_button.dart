import 'package:dentro_do_bolso/app/core/ui/extensions/size_screen_extension.dart';
import 'package:dentro_do_bolso/app/modules/home/expense/expense_entry_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class CalendarButton extends StatelessWidget {
  final DateTime? selectdDate;
  final dateFormat = DateFormat('dd/MM/y');
  final void Function(DateTime) onChanged;

  CalendarButton({
    Key? key,
    this.selectdDate,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var lastDate = DateTime.now();
        lastDate.add(
          const Duration(days: 10 * 365),
        );
        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2025),
        ).then((value) {
          if (value != null) {
            onChanged(value);
          }
        });
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        height: 64.h,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.today,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            Observer(builder: (_) {
              return Text(
                selectdDate != null
                    ? dateFormat.format(selectdDate!)
                    : 'SELECIONE UMA DATA',
              );
            }),
          ],
        ),
      ),
    );
  }
}
