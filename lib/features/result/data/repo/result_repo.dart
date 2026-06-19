import 'package:dio/dio.dart';
import 'package:graduation_project/features/result/data/models/scan_result_model.dart';

class ResultRepository {
  final Dio _dio;

  ResultRepository(this._dio);

  Future<ScanResultModel> uploadAndScan(String imagePath) async {
    // Step 1: Check image quality first
    try {
      final qualityResponse = await _dio.post<Map<String, dynamic>>(
        '/check-image-quality',
        data: FormData.fromMap({
          'image': await MultipartFile.fromFile(
            imagePath,
            filename: 'scan.jpg',
          ),
        }),
      );

      final qualityBody = qualityResponse.data!;
      if (qualityBody['success'] == false) {
        throw ScanException(
          qualityBody['error']?['type'] ?? 'UNKNOWN',
          qualityBody['error']?['message'] ?? 'Something went wrong',
        );
      }
    } on DioException catch (e) {
      final body = e.response?.data;
      if (body != null && body['error'] != null) {
        throw ScanException(
          body['error']['type'] ?? 'UNKNOWN',
          body['error']['message'] ?? 'Something went wrong',
        );
      }
      rethrow;
    }

    // Step 2: Proceed with scan
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imagePath,
        filename: 'scan.jpg',
      ),
    });

    try {
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
    } on DioException catch (e) {
      final body = e.response?.data;
      if (body != null && body['error'] != null) {
        throw ScanException(
          body['error']['type'] ?? 'UNKNOWN',
          body['error']['message'] ?? 'Something went wrong',
        );
      }
      rethrow;
    }
  }
}

class ScanException implements Exception {
  final String type;
  final String message;

  const ScanException(this.type, this.message);

  @override
  String toString() => 'ScanException($type): $message';
}
