import 'package:dentro_do_bolso/app/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:dentro_do_bolso/app/core/ui/extensions/size_screen_extension.dart';

class HeadHome extends StatelessWidget {
  final String value;
  const HeadHome({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            context.darkBlue,
            Colors.blueGrey,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.statusBarHeight + 40.h,
          ),
          Observer(
            builder: (_) {
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'R\$: $value',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
          const Text(
            'Valor total em conta',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
        ],
      ),
    );
  }
}
