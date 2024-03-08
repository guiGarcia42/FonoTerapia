import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/database/dao/game_component_dao.dart';
import 'package:fono_terapia/database/dao/sub_category_dao.dart';
import 'package:fono_terapia/modules/game/widgets/build_game_question.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/game_component.dart';
import 'package:fono_terapia/shared/model/game_configuration.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';

import 'widgets/build_game_list_of_options.dart';
import 'widgets/game_configuration_dialog.dart';
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
  List<GameComponent>? gameComponents;
  late GameComponent rightAnswer;

  @override
  void initState() {
    super.initState();
    configuration = GameConfiguration(2, 10);
    answeredCorrectly = 0;
    percentage = (answeredCorrectly / configuration.numberOfQuestions) * 100;
  }

  Future<void> openConfigurationDialog(Size size) async {
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
      setState(() {
        gameComponents = null;
        configuration = result;
        percentage =
            (answeredCorrectly / configuration.numberOfQuestions) * 100;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final aspectRatioFactor = size.width / 400;
    final subCategoryId = ModalRoute.of(context)?.settings.arguments as int;
    final AudioPlayer player = AudioPlayer();

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

            if (gameComponents == null) {
              return _buildContent(
                  subCategory, size, aspectRatioFactor, player);
            } else {
              return _buildContentWithGameComponents(
                  subCategory, size, aspectRatioFactor, player);
            }
          }
        },
      ),
    );
  }

  Column _buildContent(SubCategory subCategory, Size size,
      double aspectRatioFactor, AudioPlayer player) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildCustomAppBar(size, subCategory),
        _buildTopBar(size),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.03,
              left: size.width * 0.02,
              right: size.width * 0.02,
              bottom: size.height * 0.02,
            ),
            child: FutureBuilder<List<GameComponent>>(
              future: GameComponentDao().findRandomComponents(
                database,
                subCategory.section,
                configuration.numberOfOptions,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro ao carregar dados'));
                } else {
                  gameComponents = snapshot.data!;
                  rightAnswer =
                      GameComponentDao().getRightAnswer(gameComponents!);

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: size.height * 0.02),
                          child: BuildGameQuestion(
                            size: size,
                            player: player,
                            subCategoryId: subCategory.id,
                            rightAnswer: rightAnswer,
                          ),
                        ),
                        Expanded(
                          child: BuildGameListOfOptions(
                            gameComponents: gameComponents!,
                            subCategoryId: subCategory.id,
                            size: size,
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
        _buildBottomBar(size, context),
      ],
    );
  }

  Column _buildContentWithGameComponents(SubCategory subCategory, Size size,
      double aspectRatioFactor, AudioPlayer player) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildCustomAppBar(size, subCategory),
        _buildTopBar(size),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.03,
              left: size.width * 0.02,
              right: size.width * 0.02,
              bottom: size.height * 0.02,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.02),
                    child: BuildGameQuestion(
                      size: size,
                      player: player,
                      subCategoryId: subCategory.id,
                      rightAnswer: rightAnswer,
                    ),
                  ),
                  Expanded(
                    child: BuildGameListOfOptions(
                      gameComponents: gameComponents!,
                      subCategoryId: subCategory.id,
                      size: size,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        _buildBottomBar(size, context),
      ],
    );
  }

  Padding _buildCustomAppBar(Size size, SubCategory subCategory) {
    return Padding(
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Text(
                subCategory.name,
                style: TextStyles.titleOption,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildTopBar(Size size) {
    return Padding(
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
                openConfigurationDialog(size);
              },
            ),
          ),
          ProgressIndicatorWithPercentageText(percentage: percentage),
        ],
      ),
    );
  }

  Padding _buildBottomBar(Size size, BuildContext context) {
    return Padding(
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
    );
  }
}
