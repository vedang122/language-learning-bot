class AIMessage {
  final String message;
  final String possibleReply;

  const AIMessage({
    required this.message,
    required this.possibleReply,
  });

  factory AIMessage.fromJson(Map<String, dynamic> json) {
    return AIMessage(
      message: json['response'],
      possibleReply: json['possible_reply'],
    );
  }
}
