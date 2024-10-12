import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fono_terapia/database/dao/game_component_dao.dart';
import 'package:fono_terapia/modules/game/widgets/game_configuration_dialog.dart';
import 'package:fono_terapia/shared/model/game_configuration.dart';
import 'package:fono_terapia/shared/model/game_component.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';
import 'package:sqflite/sqflite.dart';

class GameViewModel extends ChangeNotifier {
  final SubCategory subCategory;
  final GameComponentDao gameComponentDao = GameComponentDao(); // Use Dao directly
  AudioPlayer player = AudioPlayer();
  final Database database; // Use global database
  late GameConfiguration configuration;
  String hintText = "";
  int questionsAnswered = 0;
  int answeredCorrectly = 0;
  bool isLoading = true;
  late double percentage;
  late List<GameComponent> gameComponents;
  late GameComponent rightAnswer;

  GameViewModel({
    required this.subCategory,
    required this.database,
  }) {
    _init();
  }

  Future<void> _init() async {
    configuration = GameConfiguration(2, questionsAnswered, 10); // Example initial config
    percentage = 0;
    await _getGameComponents();
    isLoading = false;
    notifyListeners();
  }

  Future<void> _getGameComponents() async {
    gameComponents = await gameComponentDao.findRandomComponents(
      database,
      subCategory.section,
      configuration.numberOfOptions,
    );
    rightAnswer = gameComponentDao.getRightAnswer(gameComponents);
    hintText = '_' * rightAnswer.name.length;
    isLoading = false;
    notifyListeners();
  }

  Future<void> openConfigurationDialog(BuildContext context, int subCategoryId) async {
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
      percentage = (answeredCorrectly / configuration.totalNumberOfQuestions) * 100;
      await _getGameComponents(); // Reload game components based on the new configuration
    }
  }

  String buildHintText() {
    return hintText;
  }

  void updateHintText() {
    int index = hintText.indexOf('_');
    if (index != -1) {
      hintText = hintText.replaceFirst(
        '_',
        rightAnswer.name.characters.elementAt(index),
      );
      notifyListeners();
    }
  }

  void optionSelected(GameComponent? selectedOption) {
    if (selectedOption == rightAnswer) {
      player.play(AssetSource('assets/sounds/correct_sound.mp3'), volume: 0.1);
      answeredCorrectly++;
    } else {
      player.play(AssetSource('assets/sounds/wrong_sound.mp3'), volume: 0.1);
    }
    questionsAnswered++;
    percentage = (answeredCorrectly / configuration.totalNumberOfQuestions) * 100;
    if (questionsAnswered >= configuration.totalNumberOfQuestions) {
      // Handle the end of the game logic here (e.g., show results dialog)
    } else {
      _buildNextQuestion();
    }
    notifyListeners();
  }

  Future<void> _buildNextQuestion() async {
    isLoading = true;
    hintText = "";
    await _getGameComponents();
    isLoading = false;
    notifyListeners();
  }
}