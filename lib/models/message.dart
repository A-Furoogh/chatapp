
class Message {
  final String text;
  final DateTime date;
  final bool isSentByMe;
  final String imagePath;

  const Message({required this.text, required this.date, required this.isSentByMe, this.imagePath = ''});
}