import 'package:fono_terapia/shared/model/game_component.dart';
import 'package:fono_terapia/shared/utils/data.dart';
import 'package:sqflite/sqflite.dart';

class GameComponentDao {
  static const _tableName = 'game_components';
  static const _id = 'id';
  static const _name = 'name';
  static const _imagePath = 'image_path';
  static const _audioPath = 'audio_path';
  static const _section = 'section';

  static String get tableSql {
    return 'CREATE TABLE $_tableName('
        '$_id INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$_name TEXT NOT NULL, '
        '$_imagePath TEXT NOT NULL, '
        '$_audioPath TEXT NOT NULL, '
        '$_section INTEGER NOT NULL);';
  }

  static String get tableData {
    if (nameList.length != imagePathList.length ||
        nameList.length != audioPathList.length ||
        nameList.length != sectionList.length) {
      throw Exception('Arrays têm tamanhos diferentes');
    }
    String insertQuery =
        "INSERT INTO $_tableName ($_name, $_imagePath, $_audioPath, $_section) VALUES ";

    for (int i = 0; i < nameList.length; i++) {
      insertQuery +=
          "('${nameList[i]}', '${imagePathList[i]}', '${audioPathList[i]}', ${sectionList[i]}), ";
    }

    // Remover a vírgula extra no final
    insertQuery = insertQuery.substring(0, insertQuery.length - 2);
    return insertQuery;
  }

  Future<List<GameComponent>> findRandomComponents(
      Database db, int section, int numberOfOptions) async {
    final List<Map<String, dynamic>> result =
        await db.query(_tableName, where: '$_section = $section');

    List<GameComponent> components = _toList(result);
    List<GameComponent> selectedComponents = [];

    if (section == 3) {
      List<List<GameComponent>> componentsInPair = [];

      for (int i = 0; i < components.length; i += 2) {
        componentsInPair.add([components[i], components[i + 1]]);
      }

      componentsInPair.shuffle();

      for (int i = 0; i < numberOfOptions / 2; i++) {
        selectedComponents.addAll(componentsInPair[i]);
      }
    } else {
      components.shuffle();

      for (var component in components) {
        if (selectedComponents.length < numberOfOptions &&
            !selectedComponents.contains(component)) {
          selectedComponents.add(component);
        }
      }
    }

    return selectedComponents;
  }

  GameComponent getRightAnswer(List<GameComponent> gameComponents) {
    List<GameComponent> temporaryList = List.from(gameComponents);
    temporaryList.shuffle();

    return temporaryList.first;
  }

  List<GameComponent> _toList(List<Map<String, dynamic>> result) {
    final List<GameComponent> components = [];

    for (Map<String, dynamic> row in result) {
      final GameComponent component = GameComponent(
        row[_id],
        row[_name],
        row[_imagePath],
        row[_audioPath],
        row[_section],
      );
      components.add(component);
    }
    return components;
  }
}
