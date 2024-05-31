import 'dart:convert';
import 'package:http/http.dart' as http;

// ApiService.saveToken('device_token_value', 'user_id_value');
class ApiService {
  static Future<void> saveToken(String deviceToken, String userId) async {
    final String apiUrl = 'https://doclive.info/api/save-token';
    final Map<String, String> body = {
      'device_token': deviceToken,
      'user_id': userId,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // Successful API call, handle response if needed
        print('API call successful savetoken');
      } else {
        // API call failed, handle error
        print('savetoken API call failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Error occurred during API call, handle exception
      print('savetoken Error occurred: $e');
    }
  }
}
