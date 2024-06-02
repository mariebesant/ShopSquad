import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shopsquad/pages/login_page.dart';
import 'package:shopsquad/pages/main_pages.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

  // ignore: avoid_print
  print(localStorage.getItem('accessBearer'));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.light().copyWith(
          // background: AppColors.white,
          primary: AppColors.background,
          secondary: AppColors.lightGray,
          surface: AppColors.lightGray,
          surfaceTint: AppColors.lightGray,
        ),
        appBarTheme: AppThemes.appBar,
        cardTheme: AppThemes.card,
        datePickerTheme: AppThemes.datePicker,
        outlinedButtonTheme: AppThemes.outlinedButton,
        fontFamily: 'BoehringerForwardText',
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Home',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return localStorage.getItem('accessBearer') == null
        ? const LoginPage()
        : const MainPages();
    // return LoginPage();
  }
}
