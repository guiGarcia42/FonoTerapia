import 'package:fono_terapia/shared/model/game_component.dart';
import 'package:sqflite/sqflite.dart';

class GameComponentDao {
  static const _tableName = 'game_components';
  static const _id = 'id';
  static const _name = 'name';
  static const _imagePath = 'image_path';
  static const _audioPath = 'audio_path';
  static const _section = 'section';

  static const nameList = [
    'Café',
    'Pão',
    'Leite',
    'Carro',
    'Pato',
    'Gato',
    'O homem está comendo',
    'O homem está dormindo',
  ];

  static const imagePathList = [
    'assets/db_images/cafe.jpg',
    'assets/db_images/pao.jpg',
    'assets/db_images/leite.jpg',
    'assets/db_images/carro.jpg',
    'assets/db_images/pato.jpg',
    'assets/db_images/gato.jpg',
    'assets/db_images/o_homem_esta_comendo.jpg',
    'assets/db_images/o_homem_esta_dormindo.jpg',
  ];

  static const audioPathList = [
    'assets/db_audios/cafe.mp3',
    'assets/db_audios/pao.mp3',
    'assets/db_audios/leite.mp3',
    'assets/db_audios/carro.mp3',
    'assets/db_audios/pato.mp3',
    'assets/db_audios/gato.mp3',
    'assets/db_audios/o_homem_esta_comendo.mp3',
    'assets/db_audios/o_homem_esta_dormindo.mp3',
  ];

  static const sectionList = [1, 1, 1, 1, 2, 2, 3, 3];

  static String get tableSql {
    return 'CREATE TABLE $_tableName('
        '$_id INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$_name TEXT NOT NULL, '
        '$_imagePath TEXT NOT NULL, '
        '$_audioPath TEXT NOT NULL, '
        '$_section INTEGER NOT NULL);';
  }

  static String get tableData {
    return "INSERT INTO $_tableName ($_name, $_imagePath, $_audioPath, $_section) VALUES "
        "('${nameList[0]}', '${imagePathList[0]}', '${audioPathList[0]}', ${sectionList[0]}), "
        "('${nameList[1]}', '${imagePathList[1]}', '${audioPathList[1]}', ${sectionList[1]}), "
        "('${nameList[2]}', '${imagePathList[2]}', '${audioPathList[2]}', ${sectionList[2]}), "
        "('${nameList[3]}', '${imagePathList[3]}', '${audioPathList[3]}', ${sectionList[3]}), "
        "('${nameList[4]}', '${imagePathList[4]}', '${audioPathList[4]}', ${sectionList[4]}), "
        "('${nameList[5]}', '${imagePathList[5]}', '${audioPathList[5]}', ${sectionList[5]}), "
        "('${nameList[6]}', '${imagePathList[6]}', '${audioPathList[6]}', ${sectionList[6]}), "
        "('${nameList[7]}', '${imagePathList[7]}', '${audioPathList[7]}', ${sectionList[7]}); ";
  }

  Future<List<GameComponent>> findRandomComponents(
      Database db, int section, int numberOfOptions) async {
    final List<Map<String, dynamic>> result =
        await db.query(_tableName, where: '$_section = $section');
    List<GameComponent> components = _toList(result);

    // Embaralhar a lista de componentes
    components.shuffle();
    // Criar uma nova lista para armazenar os componentes selecionados
    List<GameComponent> selectedComponents = [];

    // Percorrer a lista embaralhada e adicionar componentes únicos até atingir o número desejado
    for (var component in components) {
      if (selectedComponents.length < numberOfOptions &&
          !selectedComponents.contains(component)) {
        selectedComponents.add(component);
      }
    }

    return selectedComponents;
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
