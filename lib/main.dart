import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tureeslii/binding.dart';
import 'package:tureeslii/di.dart';
import 'package:tureeslii/routes.dart';
import 'package:tureeslii/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DenpendencyInjection.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tureeslii',
      theme: MyTheme.light,
      darkTheme: MyTheme.dark,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      initialRoute: Routes.splash,
      getPages: Routes.routes,
      builder: (context, child) {
        return LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 640) {
            return TabletLayout(child: child!);
          } else {
            return child!;
          }
        });
      },
    );
  }
}

class TabletLayout extends StatelessWidget {
  TabletLayout({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints:
              BoxConstraints(maxWidth: 640), // Set your desired max width
          child: child,
        ),
      ),
    );
  }
}
