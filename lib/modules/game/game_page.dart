// ignore_for_file: use_build_context_synchronously

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
import 'package:fono_terapia/shared/widgets/my_text.dart';

import 'widgets/build_game_list_of_options.dart';
import 'widgets/game_configuration_dialog.dart';
import '../../shared/widgets/progress_indicator_with_text.dart';

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
  GameComponentDao gameComponentDao = GameComponentDao(); 
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
        rightAnswer = gameComponentDao.getRightAnswer(gameComponents);
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
    return await gameComponentDao.findRandomComponents(
      database,
      _subCategory.section,
      configuration.numberOfOptions,
    );
  }

  Future<void> _openConfigurationDialog(int subCategoryId) async {
    configuration.questionsAnswered = questionsAnswered;
    final GameConfiguration? result = await showDialog<GameConfiguration>(
      context: context,
      builder: (context) {
        return GameConfigurationDialog(
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
        rightAnswer = gameComponentDao.getRightAnswer(gameComponents);
        _isLoading = false; // Desativando o indicador de carregamento
      });
    }
  }

  Future<void> _openGameResultDialog() async {
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
      rightAnswer = gameComponentDao.getRightAnswer(gameComponents);
      _isLoading = false; // Desativando o indicador de carregamento
    });
  }

  void _optionSelected(GameComponent? selectedOption) {
    if (selectedOption == rightAnswer) {
      player.play(AssetSource(AppAssets.correctSound), volume: 0.1);
      answeredCorrectly++;
      percentage =
          (answeredCorrectly / configuration.totalNumberOfQuestions) * 100;
    } else {
      player.play(AssetSource(AppAssets.wrongSound), volume: 0.1);
    }
    questionsAnswered++;
    if (questionsAnswered == configuration.totalNumberOfQuestions) {
      _openGameResultDialog();
    } else {
    _buildNextQuestionPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (questionsAnswered >= configuration.totalNumberOfQuestions) {
      _openGameResultDialog();
      return SizedBox.shrink();
    } else {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: responsiveSize.scaleSize(20),
              ),
              child: CustomHeader(
                text: _subCategory.name,
              ),
            ),
            _buildTopBar(),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.only(
                        top: responsiveSize.scaleSize(30),
                        left: responsiveSize.scaleSize(20),
                        right: responsiveSize.scaleSize(20),
                        bottom: responsiveSize.scaleSize(20),
                      ),
                      child: _buildContent(),
                    ),
            ),
            _buildBottomBar(context),
          ],
        ),
      );
    }
  }

  Widget _buildContent() {
    if ([2, 8, 11, 12, 13, 14, 15, 16, 17].contains(_subCategory.id)) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: responsiveSize.scaleSize(50),
              ),
              child: BuildGameQuestion(
                player: player,
                subCategoryId: _subCategory.id,
                rightAnswer: rightAnswer,
              ),
            ),
            if ([15, 16, 17].contains(_subCategory.id))
              MyText(
                _buildHintText(),
                style: TextStyles.textLargeRegular,
              ),
            BuildGameListOfOptions(
              gameComponents: gameComponents,
              subCategoryId: _subCategory.id,
              rightAnswer: rightAnswer,
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
            padding: EdgeInsets.only(
              bottom: responsiveSize.scaleSize(20),
            ),
            child: BuildGameQuestion(
              player: player,
              subCategoryId: _subCategory.id,
              rightAnswer: rightAnswer,
            ),
          ),
          Expanded(
            child: BuildGameListOfOptions(
              gameComponents: gameComponents,
              subCategoryId: _subCategory.id,
              rightAnswer: rightAnswer,
              onTap: _optionSelected,
            ),
          ),
        ],
      );
    }
  }

  Padding _buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsiveSize.scaleSize(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: responsiveSize.scaleSize(20),
            ),
            child: ElevatedTextButton(
              widthRatio: responsiveSize.scaleSize(250),
              textStyle: TextStyles.buttonMediumText.copyWith(
                fontSize: responsiveSize
                    .scaleSize(TextStyles.buttonMediumText.fontSize!),
              ),
              text: "Configuração",
              onPressed: () {
                _openConfigurationDialog(_subCategory.id);
              },
            ),
          ),
          Expanded(
            child: ProgressIndicatorWithText(
              answeredCorrectly: answeredCorrectly,
              totalNumberOfQuestions: configuration.totalNumberOfQuestions,
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildBottomBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: responsiveSize.scaleSize(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (![2, 8, 11, 12, 13, 14].contains(_subCategory.id))
            ElevatedTextButton(
              widthRatio: responsiveSize.scaleSize(130),
              textStyle: TextStyles.buttonMediumText.copyWith(
                fontSize: responsiveSize
                    .scaleSize(TextStyles.buttonMediumText.fontSize!),
              ),
              text: "Ajuda",
              onPressed: () {
                if ([15, 16, 17].contains(_subCategory.id)) {
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
            widthRatio: responsiveSize.scaleSize(160),
            textStyle: TextStyles.buttonMediumText.copyWith(
              fontSize: responsiveSize
                  .scaleSize(TextStyles.buttonMediumText.fontSize!),
            ),
            text: "Próximo",
            onPressed: () {
              questionsAnswered++;
              if (questionsAnswered >= configuration.totalNumberOfQuestions) {
                _openGameResultDialog();
              } else {
                _buildNextQuestionPage();
              }
            },
          ),
          ElevatedTextButton(
            widthRatio: responsiveSize.scaleSize(160),
            textStyle: TextStyles.buttonMediumText.copyWith(
              fontSize: responsiveSize
                  .scaleSize(TextStyles.buttonMediumText.fontSize!),
            ),
            text: "Finalizar",
            onPressed: () {
              if (questionsAnswered == 0) {
                Navigator.pop(context);
              } else {
                _openGameResultDialog();
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
