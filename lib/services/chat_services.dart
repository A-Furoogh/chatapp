import 'dart:convert';
import 'dart:io';

import 'package:chatapp/models/chat.dart';
import 'package:chatapp/models/message.dart';
import 'package:http/http.dart';

class ChatService {
  String endpoint = 'https://65364268c620ba9358ed349f.mockapi.io/chats';

  Future<Chat> getChat(int id) async {
    Response response = await get(Uri.parse('$endpoint/$id'));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return Chat.fromJson(result);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Chat>> getChats() async {
    Response response = await get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      print("result.body");
      return result.map<Chat>((json) => Chat.fromJson(json)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> addChat(Chat chat) async {
    Response response =
        await post(Uri.parse(endpoint), body: jsonEncode(chat.toJson()));

    if (response.statusCode != 201) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> deleteChat(int id) async {
    Response response = await delete(Uri.parse('$endpoint/$id'));

    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> updateChat(Chat chat) async {
    Response response = await put(Uri.parse('$endpoint/${chat.chatId}'),
        body: jsonEncode(chat.toJson()));

    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Message>> getChatMessages(int chatId) async {
    Response response = await get(Uri.parse('$endpoint/$chatId/messages'));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result.map<Message>((json) => Message.fromJson(json)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> addMessage(Message message, int chatId) async {
    // check if the image string is not null and convert it to base64 string if it is not null
    if (message.imagePath != '') {
      message.imagePath = await imageToBase64(message.imagePath);
    }

    Response response = await post(Uri.parse('$endpoint/$chatId/messages'),
        body: jsonEncode(message.toJson()));

    if (response.statusCode != 201) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> deleteMessage(int chatId, int messageId) async {
    Response response =
        await delete(Uri.parse('$endpoint/$chatId/messages/$messageId'));

    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> updateMessage(Message message) async {
    Response response = await put(
        Uri.parse(
            '$endpoint/${message.messageId}/messages/${message.messageId}'),
        body: jsonEncode(message.toJson()));

    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> markMessageAsSeen(int chatId, int messageId) async {
    // Change the isSeen property of the message to true
    Response response =
        await put(Uri.parse('$endpoint/$chatId/messages/$messageId/seen'));

    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> markMessagesAsSeen(int chatId) async {
    Response response = await put(Uri.parse('$endpoint/$chatId/messages/seen'));

    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> clearChatMessages(int chatId) async {
    Response response = await delete(Uri.parse('$endpoint/$chatId/messages'));

    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> clearMessages() async {
    Response response = await delete(Uri.parse('$endpoint/messages'));

    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
  }

  // Generate a new chatId
  Future<int> generateChatId() async {
    Response response = await get(Uri.parse('$endpoint/generateChatId'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['chatId'];
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  // Generate a new messageId
  Future<int> generateMessageId(int chatId) async {
    Response response =
        await get(Uri.parse('$endpoint/$chatId/generateMessageId'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['messageId'];
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  // convert image to base64 string
  Future<String> imageToBase64(String filePath) async {
    try {
      // Read the image file as bytes
      File imageFile = File(filePath);
      List<int> imageBytes = await imageFile.readAsBytes();

      // Encode the image bytes to Base64
      String base64String = base64Encode(imageBytes);

      return base64String;
    } catch (e) {
      return "Error: $e";
    }
  }

  // convert base64 string to image
  Future<File> base64ToImage(String base64String) async {
    try {
      // Decode the base64 string to bytes
      List<int> imageBytes = base64Decode(base64String);

      // Write the bytes to a file
      String dir = (await getApplicationDocumentsDirectory()).path;
      File imageFile = File('$dir/image.png');
      await imageFile.writeAsBytes(imageBytes);

      return imageFile;
    } catch (e) {
      return File("Error: $e");
    }
  }

  // methode getApplicationDocumentsDirectory
  Future<Directory> getApplicationDocumentsDirectory() async {
    return Directory.current;
  }
}
