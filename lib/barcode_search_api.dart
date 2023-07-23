import 'dart:convert';
import 'package:http/http.dart' as http;

typedef BarcodeInfo = (
  String? thumbnail,
  String name,
  String carb,
  String protein,
  String fat
);

class BarcodeSearchAPI {
  final url =
      'https://wvmkj55y87.execute-api.ap-northeast-2.amazonaws.com/items';

  Future<BarcodeInfo?> searchBarcode(String query) async {
    final uri = '$url/$query';
    final response = await http.get(Uri.parse(uri));

    Map<String, dynamic> jsonResponse = {};
    if (response.body.isNotEmpty) {
      jsonResponse = jsonDecode(response.body);
    }

    if (jsonResponse.isNotEmpty) {
      final thumbnail = jsonResponse['thumbnail'] as String?;
      final name = jsonResponse['name'] as String;
      final carb = jsonResponse['carb'] as String;
      final protein = jsonResponse['protein'] as String;
      final fat = jsonResponse['fat'] as String;

      return (thumbnail, name, carb, protein, fat);
    } else {
      return null;
    }
  }

  void addBarcodeData({
    required String barcodeId,
    String? thumbnail,
    required String name,
    required String carb,
    required String protein,
    required String fat,
  }) {
    http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'barcodeId': barcodeId,
        'thumbnail': thumbnail,
        'name': name,
        'carb': carb,
        'protein': protein,
        'fat': fat
      }),
    );
  }
}
