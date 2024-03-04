class GameComponentDao {
  static const tableName = 'game_components';
  static const _id = 'id';
  static const _component = 'component';
  static const _imagePath = 'image_path';
  static const _audioPath = 'audio_path';
  static const _section = 'section';

  static const componentsList = [
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

  static const groupList = [0, 0, 0, 0, 0, 0, 1, 1];

  static String get tableSql {
    return 'CREATE TABLE $tableName('
        '$_id INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$_component TEXT NOT NULL, '
        '$_imagePath TEXT NOT NULL, '
        '$_audioPath TEXT NOT NULL, '
        '$_section INTEGER NOT NULL);';
  }

  static String get tableData {
    return "INSERT INTO $tableName ($_component, $_imagePath, $_audioPath, $_section) VALUES "
        "('${componentsList[0]}', '${imagePathList[0]}', '${audioPathList[0]}', ${groupList[0]}), "
        "('${componentsList[1]}', '${imagePathList[1]}', '${audioPathList[1]}', ${groupList[1]}), "
        "('${componentsList[2]}', '${imagePathList[2]}', '${audioPathList[2]}', ${groupList[2]}), "
        "('${componentsList[3]}', '${imagePathList[3]}', '${audioPathList[3]}', ${groupList[3]}), "
        "('${componentsList[4]}', '${imagePathList[4]}', '${audioPathList[4]}', ${groupList[4]}), "
        "('${componentsList[5]}', '${imagePathList[5]}', '${audioPathList[5]}', ${groupList[5]}), "
        "('${componentsList[6]}', '${imagePathList[6]}', '${audioPathList[6]}', ${groupList[6]}), "
        "('${componentsList[7]}', '${imagePathList[7]}', '${audioPathList[7]}', ${groupList[7]}); ";
        
  }
}
