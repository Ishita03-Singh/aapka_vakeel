// import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:convert';

class ApiService {
//   final String code = ''; // Replace with your OpenAI API key

//   Future<String> fetchChatGPTResponse(String message) async {
//   try {
//     final url = Uri.parse('https://api.openai.com/v1/chat/completions');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $code',
//       },
//       body: jsonEncode({
//         'model': 'gpt-3.5-turbo',
//         'messages': [
//           {'role': 'user', 'content': message},
//         ],
//       }),
//     );

//     if (response.statusCode == 200) {
//       final jsonResponse = jsonDecode(response.body);
//       return jsonResponse['choices'][0]['message']['content'];
//     } else {
//       print('Error: ${response.statusCode}, Body: ${response.body}');
//       throw Exception('Failed to load response');
//     }
//   } catch (e) {
//     print('Caught an exception: $e');
//     rethrow; // or handle it accordingly
//   }

// }
}
