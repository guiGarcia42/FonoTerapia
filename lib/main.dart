import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fono_terapia/modules/about/about_page.dart';
import 'package:fono_terapia/modules/game/game_page.dart';
import 'package:fono_terapia/modules/history/history_page.dart';
import 'package:fono_terapia/modules/home/home_page.dart';
import 'package:fono_terapia/modules/menu/menu_page.dart';
import 'package:fono_terapia/modules/option/option_page.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/model/category.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';
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
        primarySwatch: Colors.orange,
        primaryColor: AppColors.lightOrange,
      ),
      initialRoute: "/start",
      onGenerateRoute: (settings) {
        final args = settings.arguments;

        switch (settings.name) {
          case '/start':
            return MaterialPageRoute(builder: (_) => AppStartup());
          case '/home':
            return MaterialPageRoute(builder: (_) => HomePage());
          case '/about':
            return MaterialPageRoute(builder: (_) => AboutPage());
          case '/menu':
            return MaterialPageRoute(builder: (_) => MenuPage());
          case '/option':
            if (args is Category) {
              return MaterialPageRoute(
                builder: (_) => OptionPage(category: args),
              );
            }
            return null;
          case '/game':
            if (args is SubCategory) {
              return MaterialPageRoute(
                builder: (_) => GamePage(subCategory: args),
              );
            }
            return null;
          case '/history':
            if (args is Category) {
              return MaterialPageRoute(
                builder: (_) => HistoryPage(category: args),
              );
            }
            return null;
          default:
            return null;
        }
      },
    );
  }
}
