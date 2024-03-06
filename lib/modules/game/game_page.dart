import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/database/dao/game_component_dao.dart';
import 'package:fono_terapia/database/dao/sub_category_dao.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/game_component.dart';
import 'package:fono_terapia/shared/model/game_configuration.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';
import 'package:fono_terapia/shared/widgets/picture_button_with_description.dart';

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
    final aspectRatioFactor = size.width / 400;
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
      body: FutureBuilder<SubCategory>(
        future: SubCategoryDao().findSubCategory(database, subCategoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados'));
          } else {
            SubCategory subCategory = snapshot.data!;

            return Column(
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
                          subCategory.name,
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
                      ProgressIndicatorWithPercentageText(
                          percentage: percentage),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.05,
                      horizontal: size.height * 0.02,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightOrange,
                              border: Border.all(
                                color: AppColors.darkGray,
                                width: 2,
                              )),
                          child: Icon(
                            Icons.volume_up_rounded,
                            size: size.height * 0.2,
                            color: AppColors.darkGray,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.005,
                              horizontal: size.height * 0.005,
                            ),
                            child: FutureBuilder<List<GameComponent>>(
                              future: GameComponentDao().findRandomComponents(
                                database,
                                subCategory.section,
                                configuration.numberOfOptions,
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Erro ao carregar dados'));
                                } else {
                                  final gameComponents = snapshot.data!;

                                  return Center(
                                    child: GridView.builder(
                                      itemCount: gameComponents.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio:
                                            0.975 * aspectRatioFactor,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5,
                                      ),
                                      itemBuilder: (_, index) {
                                        final component = gameComponents[index];
                                        print('Seção: ${component.section}'); // APAGAR

                                        return PictureButtonWithDescription(
                                          description: component.name,
                                          imagePath: component.imagePath,
                                          size: size,
                                          onTap: () {},
                                        );
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
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
            );
          }
        },
      ),
    );
  }
}
