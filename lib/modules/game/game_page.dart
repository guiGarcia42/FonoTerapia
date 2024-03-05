import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fono_terapia/database/dao/sub_category_dao.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/game_configuration.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';

import '../../shared/widgets/game_configuration_dialog.dart';
import '../../shared/widgets/progress_indicator_with_percentage_text.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GameConfiguration configuration;
  late int answeredCorrectly;
  late double percentage;

  @override
  void initState() {
    super.initState();
    configuration = GameConfiguration(2, 10);
    answeredCorrectly = 2;
    percentage = (answeredCorrectly / configuration.numberOfQuestions) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final subCategoryId = ModalRoute.of(context)?.settings.arguments as int;

    Future<void> openConfigurationDialog() async {
      final GameConfiguration? result = await showDialog<GameConfiguration>(
        context: context,
        builder: (context) {
          return GameConfigurationDialog(
            size: size,
            configurations: configuration,
          );
        },
      );

      if (result != null) {
        configuration = result;
        percentage =
            (answeredCorrectly / configuration.numberOfQuestions) * 100;
      }
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: size.height * 0.01),
            child: Container(
              width: size.width,
              height: size.height * 0.20,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [AppColors.lightOrange, AppColors.darkOrange],
                  center: Alignment.center,
                  radius: 0.7,
                ),
              ),
              child: SafeArea(
                child: Center(
                  child: Text(
                    SubCategoryDao.subCategoryNames[subCategoryId - 1],
                    style: TextStyles.titleOption,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: size.width * 0.02),
                  child: ElevatedTextButton(
                    widthRatio: size.width * 0.5,
                    textStyle: TextStyles.buttonMediumText,
                    text: "Configuração",
                    onPressed: () {
                      openConfigurationDialog();
                    },
                  ),
                ),
                ProgressIndicatorWithPercentageText(percentage: percentage),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.02,
                horizontal: size.height * 0.02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.lightOrange,
                    ),
                      child: Icon(
                    Icons.volume_up_rounded,
                    size: size.height * 0.25,
                  ))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: size.height * 0.02,
              left: size.width * 0.02,
              right: size.width * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedTextButton(
                  widthRatio: size.width * 0.240,
                  textStyle: TextStyles.buttonMediumText,
                  text: "Ajuda",
                  onPressed: () {},
                ),
                ElevatedTextButton(
                  widthRatio: size.width * 0.340,
                  textStyle: TextStyles.buttonMediumText,
                  text: "Próximo",
                  onPressed: () {},
                ),
                ElevatedTextButton(
                  widthRatio: size.width * 0.340,
                  textStyle: TextStyles.buttonMediumText,
                  text: "Finalizar",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
