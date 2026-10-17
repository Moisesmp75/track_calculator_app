import 'dart:convert';

class JwtUtils {
  const JwtUtils._();

  static String? subject(String? token) {
    if (token == null || token.isEmpty) return null;
    final parts = token.split('.');
    if (parts.length < 2) return null;

    try {
      final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      final data = jsonDecode(payload);
      if (data is! Map<String, dynamic>) return null;
      final subject = data['sub'];
      if (subject is String && subject.isNotEmpty) return subject;
      return null;
    } catch (_) {
      return null;
    }
  }
}
