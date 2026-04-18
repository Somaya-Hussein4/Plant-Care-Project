import 'package:dio/dio.dart';

class ResultRemoteDataSource {
  ResultRemoteDataSource(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> uploadScan(String imagePath) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        imagePath,
        filename: 'scan.jpg',
      ),
    });

    final response = await _dio.post('/scan', data: formData);
    return response.data as Map<String, dynamic>;
  }
}
