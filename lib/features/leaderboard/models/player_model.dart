class PlayerModel {
  final String id;
  final String name;
  final String avatar;
  final int totalStars;
  final int level;
  final bool isCurrentUser;

  PlayerModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.totalStars,
    required this.level,
    required this.isCurrentUser,
  });

  @override
  String toString() {
    return 'PlayerModel(id: $id, name: $name, avatar: $avatar, totalStars: $totalStars, level: $level, isCurrentUser: $isCurrentUser)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PlayerModel &&
        other.id == id &&
        other.name == name &&
        other.avatar == avatar &&
        other.totalStars == totalStars &&
        other.level == level &&
        other.isCurrentUser == isCurrentUser;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        avatar.hashCode ^
        totalStars.hashCode ^
        level.hashCode ^
        isCurrentUser.hashCode;
  }
}


