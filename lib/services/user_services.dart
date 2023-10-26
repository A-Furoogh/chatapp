import 'dart:convert';
import 'dart:io';

import 'package:chatapp/models/user.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart';

class UserService {
  
  String endpoint = 'https://65364268c620ba9358ed349f.mockapi.io/users';

  Future<List<User>> getUsers() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map(((e) => User.fromJson(e))).toList();
    }else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<User> getUser(String id) async {
    Response response = await get(Uri.parse('$endpoint/$id'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return User.fromJson(result);
    }else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> addUser(User user) async {
    Response response = await post(Uri.parse(endpoint), body: jsonEncode(user.toJson()));
    if (response.statusCode != 201) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> deleteUser(String id) async {
    Response response = await delete(Uri.parse('$endpoint/$id'));
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> updateUser(User user) async {
    Response response = await put(Uri.parse('$endpoint/${user.userId}'), body: jsonEncode(user.toJson()));
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> addChatToUser(String userId, int chatId) async {
    Response response = await put(Uri.parse('$endpoint/$userId'), body: jsonEncode({'chatIds': [chatId]}));
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> removeChatFromUser(String userId, int chatId) async {
    Response response = await put(Uri.parse('$endpoint/$userId'), body: jsonEncode({'chatIds': [chatId]}));
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<int>> getUserChatIds(String userId) async {
    Response response = await get(Uri.parse('$endpoint/$userId'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['chatIds'].map<int>((id) => id as int).toList();
    }else {
      throw Exception(response.reasonPhrase);
    }
  }

  // Generate a userId for a new user from the devic ID and check if it already exists
  Future<String> generateUserId() async {
    // Get the device ID with the device_info_plus package

    // Check if the device is wheder an Android or iOS device
    String? deviceId;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await DeviceInfoPlugin().iosInfo;
      deviceId = iosInfo.identifierForVendor.toString();
    }

    deviceId ??= generateRandomDeviceId();

    // Check if the device ID already exists in the database
    Response response = await get(Uri.parse('$endpoint?search=$deviceId'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result.length > 0) {
        return result[0]['userId'];
      } else {
        return deviceId;
      }
    }else {
      throw Exception(response.reasonPhrase);
    }
  }

  // Generate a random device ID
  String generateRandomDeviceId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}