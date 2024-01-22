import 'package:fono_terapia/shared/model/game_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryController {

  List<GameResult> _gameList = [];

  Future<void> loadHistory() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final jsonList = instance.getStringList('history') ?? [];
      _gameList = GameResult.convertJsonToList(jsonList);
    } catch (error) {
      print("Erro ao carregar histórico: $error");
    }
  }

  Future<void> saveHistory(GameResult match) async {
    try {
      final instance = await SharedPreferences.getInstance();
      _gameList.add(match);
      final jsonList = GameResult.convertListToJson(_gameList);
      await instance.setStringList('history', jsonList);
    } catch (error) {
      print("Erro ao salvar histórico: $error");
    }
  }

}