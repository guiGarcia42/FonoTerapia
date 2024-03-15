import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/database/dao/category_dao.dart';
import 'package:fono_terapia/database/dao/game_component_dao.dart';
import 'package:fono_terapia/database/dao/game_result_dao.dart';
import 'package:fono_terapia/modules/game/game_result_dialog.dart';
import 'package:fono_terapia/modules/game/widgets/build_game_question.dart';
import 'package:fono_terapia/shared/assets/app_assets.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/game_component.dart';
import 'package:fono_terapia/shared/model/game_configuration.dart';
import 'package:fono_terapia/shared/model/game_result.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';
import 'package:fono_terapia/shared/widgets/custom_header.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';

import 'widgets/build_game_list_of_options.dart';
import 'widgets/game_configuration_dialog.dart';
import '../../shared/widgets/progress_indicator_with_percentage_text.dart';

class GamePage extends StatefulWidget {
  const GamePage({
    super.key,
    required this.subCategory,
  });

  final SubCategory subCategory;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  AudioPlayer player = AudioPlayer();
  String _hintText = "";
  int questionsAnswered = 0;
  int answeredCorrectly = 0;
  bool _isLoading = true; // Estado de carregamento
  late GameConfiguration configuration;
  late double percentage;
  late List<GameComponent> gameComponents;
  late GameComponent rightAnswer;
  late SubCategory _subCategory;

  @override
  void initState() {
    super.initState();
    configuration = GameConfiguration(2, questionsAnswered, 10);
    percentage =
        (answeredCorrectly / configuration.totalNumberOfQuestions) * 100;
    _subCategory = widget.subCategory;

    _getGameComponents().then((components) {
      setState(() {
        gameComponents = components;
        rightAnswer = GameComponentDao().getRightAnswer(gameComponents);
        _isLoading = false; // Aqui desativamos o estado de carregamento
      });
    });
  }

  String _buildHintText() {
    if (_hintText.isEmpty) {
      _hintText = '_' * rightAnswer.name.length;
    }
    return _hintText;
  }

  void _updateHintText() {
    int index = _hintText.indexOf('_');
    if (index != -1) {
      _hintText = _hintText.replaceFirst(
        '_',
        rightAnswer.name.characters.elementAt(index),
      );
    }
  }

  Future<List<GameComponent>> _getGameComponents() async {
    return await GameComponentDao().findRandomComponents(
      database,
      _subCategory.section,
      configuration.numberOfOptions,
    );
  }

  Future<void> _openConfigurationDialog(Size size, int subCategoryId) async {
    configuration.questionsAnswered = questionsAnswered;
    final GameConfiguration? result = await showDialog<GameConfiguration>(
      context: context,
      builder: (context) {
        return GameConfigurationDialog(
          size: size,
          configurations: configuration,
          subCategoryId: subCategoryId,
        );
      },
    );

    if (result != null) {
      configuration = result;
      percentage =
          (answeredCorrectly / configuration.totalNumberOfQuestions) * 100;
      List<GameComponent> components = await _getGameComponents();
      setState(() {
        gameComponents = components;
        rightAnswer = GameComponentDao().getRightAnswer(gameComponents);
        _isLoading = false; // Desativando o indicador de carregamento
      });
    }
  }

  Future<void> _openGameResultDialog(Size size) async {
    configuration.questionsAnswered = questionsAnswered;
    final gameResult = await _registerGameResult();

    showDialog<GameResult>(
      context: context,
      builder: (context) {
        return GameResultDialog(
          gameResult: gameResult,
          subCategory: _subCategory,
        );
      },
    );
  }

  Future<GameResult> _registerGameResult() async {
    GameResult gameResult = GameResult(
        0,
        DateTime.now().toString().split(' ')[0], // Formato "YYYY-MM-DD"
        questionsAnswered,
        answeredCorrectly,
        _subCategory,
        await CategoryDao().findCategory(database, _subCategory.category!.id));

    await GameResultDao().insert(gameResult, database);

    return gameResult;
  }

  void _buildNextQuestionPage() async {
    setState(() {
      _isLoading = true;
      _hintText = "";
    });

    List<GameComponent> components = await _getGameComponents();
    setState(() {
      gameComponents = components;
      rightAnswer = GameComponentDao().getRightAnswer(gameComponents);
      _isLoading = false; // Desativando o indicador de carregamento
    });
  }

  void _optionSelected(Size size, GameComponent? selectedOption) {
    if (selectedOption == rightAnswer) {
      player.play(AssetSource(AppAssets.correctSound));
      answeredCorrectly++;
      percentage =
          (answeredCorrectly / configuration.totalNumberOfQuestions) * 100;
    } else {
      player.play(AssetSource(AppAssets.wrongSound));
    }
    questionsAnswered++;
    Timer(Duration(seconds: 2), () {
      if (questionsAnswered == configuration.totalNumberOfQuestions) {
        _openGameResultDialog(size);
      } else {
        _buildNextQuestionPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (questionsAnswered >= configuration.totalNumberOfQuestions) {
      _openGameResultDialog(size);
      return SizedBox.shrink();
    } else {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.01),
              child: CustomHeader(
                text: _subCategory.name,
              ),
            ),
            _buildTopBar(size, _subCategory.id),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.03,
                        left: size.width * 0.02,
                        right: size.width * 0.02,
                        bottom: size.height * 0.02,
                      ),
                      child: _buildContent(size, _subCategory.id),
                    ),
            ),
            _buildBottomBar(size, context),
          ],
        ),
      );
    }
  }

  Widget _buildContent(Size size, int subCategoryId) {
    if ([2, 7, 9, 10, 11, 12, 13, 14].contains(subCategoryId)) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
              child: BuildGameQuestion(
                size: size,
                player: player,
                subCategoryId: subCategoryId,
                rightAnswer: rightAnswer,
              ),
            ),
            if ([12, 13, 14].contains(_subCategory.id))
              Text(
                _buildHintText(),
                style: TextStyles.textLargeRegular,
              ),
            BuildGameListOfOptions(
              gameComponents: gameComponents,
              subCategoryId: subCategoryId,
              rightAnswer: rightAnswer,
              size: size,
              onTap: _optionSelected,
            ),
          ],
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: size.height * 0.02),
            child: BuildGameQuestion(
              size: size,
              player: player,
              subCategoryId: subCategoryId,
              rightAnswer: rightAnswer,
            ),
          ),
          Expanded(
            child: BuildGameListOfOptions(
              gameComponents: gameComponents,
              subCategoryId: subCategoryId,
              rightAnswer: rightAnswer,
              size: size,
              onTap: _optionSelected,
            ),
          ),
        ],
      );
    }
  }

  Padding _buildTopBar(Size size, int subCategoryId) {
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
                _openConfigurationDialog(size, subCategoryId);
              },
            ),
          ),
          Expanded(
            child: ProgressIndicatorWithPercentageText(percentage: percentage),
          ),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (![2, 7, 9, 10, 11].contains(_subCategory.id))
            ElevatedTextButton(
              widthRatio: size.width * 0.240,
              textStyle: TextStyles.buttonMediumText,
              text: "Ajuda",
              onPressed: () {
                if ([12, 13, 14].contains(_subCategory.id)) {
                  setState(() {
                    if (_hintText.contains('_')) {
                      _updateHintText();
                    }
                  });
                } else {
                  setState(() {
                    _removeRandomComponent();
                  });
                }
              },
            ),
          ElevatedTextButton(
            widthRatio: size.width * 0.340,
            textStyle: TextStyles.buttonMediumText,
            text: "Próximo",
            onPressed: () {
              questionsAnswered++;
              if (questionsAnswered >= configuration.totalNumberOfQuestions) {
                _openGameResultDialog(size);
              } else {
                _buildNextQuestionPage();
              }
            },
          ),
          ElevatedTextButton(
            widthRatio: size.width * 0.340,
            textStyle: TextStyles.buttonMediumText,
            text: "Finalizar",
            onPressed: () {
              if (questionsAnswered == 0) {
                Navigator.pop(context);
              } else {
                _openGameResultDialog(size);
              }
            },
          ),
        ],
      ),
    );
  }

  void _removeRandomComponent() {
    List<int> indices = List.generate(gameComponents.length, (index) => index)
        .where((index) => gameComponents[index] != rightAnswer)
        .toList();

    if (indices.isNotEmpty) {
      int randomIndex = Random().nextInt(indices.length);
      gameComponents.removeAt(indices[randomIndex]);
    }
  }
}
