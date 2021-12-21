import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:dentro_do_bolso/app/core/ui/extensions/size_screen_extension.dart';

class HeadHome extends StatelessWidget {
  final String value;
  const HeadHome({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.blueGrey,
          ],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 1.statusBarHeight + 30,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 16,
            ),
            height: 80.h,
            child: Observer(
              builder: (_) {
                return Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
