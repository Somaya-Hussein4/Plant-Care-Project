import 'package:graduation_project/features/result/data/models/scan_result_model.dart';

import 'package:dio/dio.dart';

class ResultRepository {
  final Dio _dio;

  ResultRepository(this._dio);

  Future<ScanResultModel> uploadAndScan(String imagePath) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        imagePath,
        filename: 'scan.jpg',
      ),
    });

    final response = await _dio.post<Map<String, dynamic>>(
      '/upload-leaf',
      data: formData,
    );

    final body = response.data!;

    if (body['success'] == true) {
      return ScanResultModel.fromJson(body['data']['scan']);
    }

    throw ScanException(
      body['error']?['type'] ?? 'UNKNOWN',
      body['error']?['message'] ?? 'Something went wrong',
    );
  }
}

class ScanException implements Exception {
  final String type;
  final String message;

  const ScanException(this.type, this.message);

  @override
  String toString() => 'ScanException($type): $message';
}
