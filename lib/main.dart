import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fono_terapia/modules/about/about_page.dart';
import 'package:fono_terapia/modules/game/game_page.dart';
import 'package:fono_terapia/modules/goPremium/go_premium_view.dart';
import 'package:fono_terapia/modules/history/history_page.dart';
import 'package:fono_terapia/modules/menu/menu_page.dart';
import 'package:fono_terapia/modules/option/option_page.dart';
import 'package:fono_terapia/modules/register/register_view.dart';
import 'package:fono_terapia/modules/startup/loading_view.dart';
import 'package:fono_terapia/modules/startup/startup_view.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/model/category.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
        primaryColor: AppColors.background,
      ),
      locale: Locale('pt', 'BR'),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: <Locale>[
        Locale('pt', 'BR')
      ],
      initialRoute: "/load",
      onGenerateRoute: (settings) {
        final args = settings.arguments;

        switch (settings.name) {
          case '/load':
            return MaterialPageRoute(builder: (_) => LoadingView());
          case '/startup':
            return MaterialPageRoute(builder: (_) => StartupView());
          case '/goPremium':
            return MaterialPageRoute(builder: (_) => GoPremiumView());
          case '/register':
            return MaterialPageRoute(builder: (_) => RegisterView());
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
