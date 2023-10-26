class User {

  final String userId;
  final List<int>? chatIds;

  User({required this.userId, this.chatIds});

  factory User.fromJson(Map<String, dynamic> json) {

    var chatIdsList = json['chatIds'] as List;
    List<int> parsedChatIds = chatIdsList.map((id) => id as int,).toList();

    return User(
      userId: json['userId'], 
      chatIds: parsedChatIds,
      );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'chatIds': chatIds
  };
}