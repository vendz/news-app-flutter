import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_app/provider/theme_provider.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDirectory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDirectory.path);

  final settings = await Hive.openBox('settings');
  bool isLightTheme = settings.get('isLightTheme') ?? false;
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(isLightTheme: isLightTheme),
      child: AppStart(),
    ),
  );
}

class AppStart extends StatelessWidget {
  const AppStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MyApp(themeProvider: themeProvider);
  }
}

class MyApp extends StatelessWidget with WidgetsBindingObserver {
  final ThemeProvider themeProvider;
  const MyApp({Key? key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeProvider.themeData(),
      home: HomeScreen(category: 'all'),
    );
  }
}
