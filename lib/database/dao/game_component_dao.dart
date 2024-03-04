class GameComponentDao {
  static const tableName = 'game_components';
  static const _id = 'id';
  static const _component = 'component';
  static const _imagePath = 'image_path';
  static const _audioPath = 'audio_path';
  static const _isSentence = 'is_sentence';

  static const tableSql = 'CREATE TABLE $tableName('
      '$_id INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_component TEXT NOT NULL, '
      '$_imagePath TEXT NOT NULL, '
      '$_audioPath TEXT NOT NULL, '
      '$_isSentence INTEGER NOT NULL);';
}