class UserData {
  String name;
  bool isPremium;

  UserData({
    required this.name,
    this.isPremium = false,
  });

  // Convert a UserData object into a Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isPremium': isPremium,
    };
  }

  // Convert a Map into a UserData object
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      isPremium: json['isPremium'],
    );
  }
}