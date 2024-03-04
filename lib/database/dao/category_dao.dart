class CategoryDao {
  static const tableName = 'categories';
  static const _id = 'id';
  static const _name = 'name';

  static const tableSql = 'CREATE TABLE $tableName('
      '$_id INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_name TEXT NOT NULL);';

  static const categoryNames = [
    'Compreensão Auditiva',
    'Compreensão Escrita',
    'Nomeação Oral',
    'Nomeação Escrita'
  ];

  static String get tableData =>
      "INSERT INTO $tableName ($_name) VALUES ('${categoryNames[0]}')";
}
