import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/bindings/general_bindings.dart';
import 'package:le_petit_davinci/core/themes/theme.dart';
import 'package:le_petit_davinci/routes/app_pages.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return GetMaterialApp(
          title: 'Le Petit Davinci',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: CustomAppTheme.lightTheme,
          darkTheme: CustomAppTheme.darkTheme,
          initialBinding: GeneralBindings(),
          getPages: AppPages.routes,
          initialRoute: AppRoutes.splash,
        );
      },
    );
  }
}
