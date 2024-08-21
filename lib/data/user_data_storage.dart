import 'dart:convert';
import 'package:fono_terapia/shared/model/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataStorage {
  static const String _userDataKey = 'user_data';

  // Save UserData to SharedPreferences
  Future<void> saveUserData(UserData userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(userData.toJson());
    await prefs.setString(_userDataKey, jsonString);
    print('UserData saved: $jsonString'); // Debugging log
  }

  // Load UserData from SharedPreferences
  Future<UserData?> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_userDataKey);

    if (jsonString == null) {
      print('No UserData found in SharedPreferences'); // Debugging log
      return null;
    }

    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    print('UserData loaded: $jsonString'); // Debugging log
    return UserData.fromJson(jsonMap);
  }

  // Update only the premium status in SharedPreferences
  Future<void> updatePremiumStatus(bool isPremium) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_userDataKey);

    if (jsonString != null) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      UserData userData = UserData.fromJson(jsonMap);
      userData.isPremium = isPremium;

      await saveUserData(userData);  // Reuse saveUserData to update the SharedPreferences
      print('Premium status updated: $isPremium'); // Debugging log
    } else {
      print('No UserData found to update premium status'); // Debugging log
    }
  }

  // Clear UserData from SharedPreferences
  Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userDataKey);
    print('UserData cleared from SharedPreferences'); // Debugging log
  }
}