import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fono_terapia/modules/about/about_page.dart';
import 'package:fono_terapia/modules/game/game_page.dart';
import 'package:fono_terapia/modules/history/history_page.dart';
import 'package:fono_terapia/modules/home/home_page.dart';
import 'package:fono_terapia/modules/menu/menu_page.dart';
import 'package:fono_terapia/modules/option/option_page.dart';
import 'package:fono_terapia/shared/themes/app_colors.dart';
import 'app_startup.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(FonoTerapiaApp());
  });
}

class FonoTerapiaApp extends StatelessWidget {
  FonoTerapiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FonoTerapia',
      theme: ThemeData(
        primarySwatch: Colors.orange, primaryColor: AppColors.lightOrange),
        initialRoute: "/start",
      routes: {
        "/start": (context) => AppStartup(),
        "/home": (context) => HomePage(),
        "/about": (context) => AboutPage(),
        "/menu": (context) => MenuPage(),
        "/option": (context) => OptionPage(),
        "/game": (context) => GamePage(),
        "/history": (context) => HistoryPage(),
      },
    );
  }
}

