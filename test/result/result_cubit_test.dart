import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graduation_project/features/result/data/repo/result_repo.dart';
import 'package:mocktail/mocktail.dart';
import 'package:graduation_project/features/result/data/models/scan_result_model.dart';
import 'package:graduation_project/features/result/logic/cubit/result_cubit.dart';
import 'package:graduation_project/features/result/logic/cubit/result_state.dart';
import 'mocks.dart';
import 'package:graduation_project/features/result/data/models/cloud_image_model.dart';

ScanResultModel fakeScanResult() => ScanResultModel(
      id: 'scan_001',
      userId: 'user_123',
      plant: 'Tomato',
      healthStatus: 'Diseased',
      disease: 'Early Blight',
      severity: 'Medium',
      confidence: 0.91,
      description:
          'Early Blight is a fungal disease caused by Alternaria solani.',
      cloudImage: const CloudImageModel(
        secureUrl: 'https://res.cloudinary.com/fake/image/upload/scan.jpg',
      ),
      createdAt: '2024-01-01T00:00:00.000Z',
    );

void main() {
  late MockResultRepository mockRepo;
  late ResultCubit cubit;

  setUp(() {
    mockRepo = MockResultRepository();
    cubit = ResultCubit(mockRepo);
  });

  tearDown(() => cubit.close());

  group('ScanResultModel', () {
    test('fromJson parses all fields correctly', () {
      final json = {
        'id': 'scan_001',
        'userId': 'user_123',
        'plant': 'Tomato',
        'healthStatus': 'Diseased',
        'disease': 'Early Blight',
        'severity': 'Medium',
        'confidence': 0.91,
        'description': 'Early Blight is a fungal disease.',
        'cloudImage': {
          'secure_url': 'https://res.cloudinary.com/fake/image/upload/scan.jpg',
        },
        'createdAt': '2024-01-01T00:00:00.000Z',
      };

      final model = ScanResultModel.fromJson(json);

      expect(model.id, 'scan_001');
      expect(model.userId, 'user_123');
      expect(model.plant, 'Tomato');
      expect(model.healthStatus, 'Diseased');
      expect(model.disease, 'Early Blight');
      expect(model.severity, 'Medium');
      expect(model.confidence, 0.91);
      expect(model.cloudImage.secureUrl,
          'https://res.cloudinary.com/fake/image/upload/scan.jpg');
    });

    test('fromJson handles null disease (healthy plant)', () {
      final json = {
        'id': 'scan_002',
        'userId': 'user_123',
        'plant': 'Tomato',
        'healthStatus': 'Healthy',
        'disease': null,
        'severity': 'None',
        'confidence': 0.98,
        'description': 'Plant looks healthy.',
        'cloudImage': {
          'secure_url':
              'https://res.cloudinary.com/fake/image/upload/healthy.jpg',
        },
        'createdAt': '2024-01-02T00:00:00.000Z',
      };

      final model = ScanResultModel.fromJson(json);

      expect(model.disease, isNull);
      expect(model.healthStatus, 'Healthy');
    });

    test('toJson serializes correctly', () {
      final model = fakeScanResult();
      final json = model.toJson();

      expect(json['id'], 'scan_001');
      expect(json['plant'], 'Tomato');
      expect(json['confidence'], 0.91);
    });
  });

  group('ResultCubit - scan()', () {
    blocTest<ResultCubit, ResultState>(
      'emits [loading, success] when uploadAndScan succeeds',
      build: () {
        when(() => mockRepo.uploadAndScan(any()))
            .thenAnswer((_) async => fakeScanResult());
        return cubit;
      },
      act: (cubit) => cubit.scan('/path/to/image.jpg'),
      expect: () => [
        const ResultState.loading(),
        isA<ResultState>().having(
          (s) =>
              s.maybeWhen(success: (scan) => scan.disease, orElse: () => null),
          'disease',
          'Early Blight',
        ),
      ],
    );

    blocTest<ResultCubit, ResultState>(
      'emits [loading, error] with correct type when ScanException thrown',
      build: () {
        when(() => mockRepo.uploadAndScan(any())).thenAnswer((_) async =>
            throw const ScanException(
                'NOT_A_PLANT', 'Image is not a tomato plant.'));
        return cubit;
      },
      act: (cubit) => cubit.scan('/path/to/invalid.jpg'),
      expect: () => [
        const ResultState.loading(),
        const ResultState.error('NOT_A_PLANT', 'Image is not a tomato plant.'),
      ],
    );

    blocTest<ResultCubit, ResultState>(
      'emits [loading, error UNKNOWN] when unexpected exception thrown',
      build: () {
        when(() => mockRepo.uploadAndScan(any()))
            .thenAnswer((_) async => throw Exception('Network error'));
        return cubit;
      },
      act: (cubit) => cubit.scan('/path/to/image.jpg'),
      expect: () => [
        const ResultState.loading(),
        const ResultState.error('UNKNOWN', 'An unknown error occurred.'),
      ],
    );
  });
}
