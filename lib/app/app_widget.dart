import 'package:dentro_do_bolso/app/core/ui/uiconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: () => MaterialApp(
        builder: asuka.builder,
        navigatorObservers: [
          asuka.asukaHeroController,
        ],
        // initialRoute: '/',
        title: UiConfig.title,
        theme: UiConfig.theme,
      ).modular(),
    );
  }
}
