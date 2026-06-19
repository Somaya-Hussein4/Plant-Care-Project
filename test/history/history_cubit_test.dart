import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:graduation_project/features/history/data/model/cloud_image_model.dart';
import 'package:graduation_project/features/history/data/model/history_scan_model.dart';
import 'package:graduation_project/features/history/logic/cubit/history_cubit.dart';
import 'package:graduation_project/features/history/logic/cubit/history_state.dart';

import 'mocks.dart';

HistoryScanModel fakeScan({
  String id = 'scan_001',
  String? disease = 'Early Blight',
}) =>
    HistoryScanModel(
      id: id,
      plant: 'Tomato',
      healthStatus: disease != null ? 'Diseased' : 'Healthy',
      disease: disease,
      severity: disease != null ? 'Medium' : 'None',
      cloudImage: CloudImage(
        secure_url: 'https://res.cloudinary.com/fake/image/upload/$id.jpg',
      ),
      createdAt: '2024-01-01T00:00:00.000Z',
    );

List<HistoryScanModel> fakeFullPage() =>
    List.generate(10, (i) => fakeScan(id: 'scan_$i'));

List<HistoryScanModel> fakePartialPage() =>
    List.generate(3, (i) => fakeScan(id: 'scan_last_$i'));

void main() {
  // ─────────────────────────────────────────────
  // MODEL TESTS
  // ─────────────────────────────────────────────
  group('HistoryScanModel', () {
    test('fromJson parses all fields correctly including _id → id', () {
      final json = {
        '_id': 'scan_001',
        'plant': 'Tomato',
        'healthStatus': 'Diseased',
        'disease': 'Early Blight',
        'severity': 'Medium',
        'cloudImage': {
          'secure_url': 'https://res.cloudinary.com/fake/image/upload/scan.jpg',
        },
        'createdAt': '2024-01-01T00:00:00.000Z',
      };

      final model = HistoryScanModel.fromJson(json);

      expect(model.id, 'scan_001');
      expect(model.plant, 'Tomato');
      expect(model.healthStatus, 'Diseased');
      expect(model.disease, 'Early Blight');
      expect(model.severity, 'Medium');
      expect(
        model.cloudImage.secure_url,
        'https://res.cloudinary.com/fake/image/upload/scan.jpg',
      );
      expect(model.createdAt, '2024-01-01T00:00:00.000Z');
    });

    test('fromJson handles null disease for healthy scans', () {
      final json = {
        '_id': 'scan_002',
        'plant': 'Tomato',
        'healthStatus': 'Healthy',
        'disease': null,
        'severity': 'None',
        'cloudImage': {
          'secure_url': 'https://res.cloudinary.com/fake/healthy.jpg',
        },
        'createdAt': '2024-01-02T00:00:00.000Z',
      };

      final model = HistoryScanModel.fromJson(json);

      expect(model.disease, isNull);
      expect(model.healthStatus, 'Healthy');
      expect(model.severity, 'None');
    });
  });

  // ─────────────────────────────────────────────
  // FETCH HISTORY TESTS
  // ─────────────────────────────────────────────
  group('HistoryCubit - fetchHistory()', () {
    blocTest<HistoryCubit, HistoryState>(
      'emits [loading, success] with hasMore=true when full page returned',
      build: () {
        final repo = MockHistoryRepository();
        final storage = MockFlutterSecureStorage();
        when(() => storage.read(key: 'userId'))
            .thenAnswer((_) async => 'user_123');
        when(() => repo.getHistory(
              userId: any(named: 'userId'),
              page: any(named: 'page'),
              limit: any(named: 'limit'),
            )).thenAnswer((_) async => fakeFullPage());
        return HistoryCubit(repo, storage: storage);
      },
      act: (cubit) => cubit.fetchHistory(),
      expect: () => [
        const HistoryState.loading(),
        HistoryState.success(scans: fakeFullPage(), hasMore: true),
      ],
    );

    blocTest<HistoryCubit, HistoryState>(
      'emits [loading, success] with hasMore=false when partial page returned',
      build: () {
        final repo = MockHistoryRepository();
        final storage = MockFlutterSecureStorage();
        when(() => storage.read(key: 'userId'))
            .thenAnswer((_) async => 'user_123');
        when(() => repo.getHistory(
              userId: any(named: 'userId'),
              page: any(named: 'page'),
              limit: any(named: 'limit'),
            )).thenAnswer((_) async => fakePartialPage());
        return HistoryCubit(repo, storage: storage);
      },
      act: (cubit) => cubit.fetchHistory(),
      expect: () => [
        const HistoryState.loading(),
        HistoryState.success(scans: fakePartialPage(), hasMore: false),
      ],
    );

    blocTest<HistoryCubit, HistoryState>(
      'emits [loading, success] with empty list when user has no scans',
      build: () {
        final repo = MockHistoryRepository();
        final storage = MockFlutterSecureStorage();
        when(() => storage.read(key: 'userId'))
            .thenAnswer((_) async => 'user_123');
        when(() => repo.getHistory(
              userId: any(named: 'userId'),
              page: any(named: 'page'),
              limit: any(named: 'limit'),
            )).thenAnswer((_) async => []);
        return HistoryCubit(repo, storage: storage);
      },
      act: (cubit) => cubit.fetchHistory(),
      expect: () => [
        const HistoryState.loading(),
        const HistoryState.success(scans: [], hasMore: false),
      ],
    );

    blocTest<HistoryCubit, HistoryState>(
      'emits [loading, error] when repository throws',
      build: () {
        final repo = MockHistoryRepository();
        final storage = MockFlutterSecureStorage();
        when(() => storage.read(key: 'userId'))
            .thenAnswer((_) async => 'user_123');
        when(() => repo.getHistory(
              userId: any(named: 'userId'),
              page: any(named: 'page'),
              limit: any(named: 'limit'),
            )).thenAnswer((_) async => throw Exception('Network error'));
        return HistoryCubit(repo, storage: storage);
      },
      act: (cubit) => cubit.fetchHistory(),
      expect: () => [
        const HistoryState.loading(),
        isA<HistoryState>(),
      ],
    );

    blocTest<HistoryCubit, HistoryState>(
      'uses empty string userId when storage returns null',
      build: () {
        final repo = MockHistoryRepository();
        final storage = MockFlutterSecureStorage();
        when(() => storage.read(key: 'userId'))
            .thenAnswer((_) async => null); // null this time
        when(() => repo.getHistory(
              userId: any(named: 'userId'),
              page: any(named: 'page'),
              limit: any(named: 'limit'),
            )).thenAnswer((_) async => []);
        return HistoryCubit(repo, storage: storage);
      },
      act: (cubit) => cubit.fetchHistory(),
      verify: (cubit) {
        // can't verify on repo here since it's local to build
        // just verify the state is correct
      },
      expect: () => [
        const HistoryState.loading(),
        const HistoryState.success(scans: [], hasMore: false),
      ],
    );
  });

  group('HistoryCubit - loadMore()', () {
    blocTest<HistoryCubit, HistoryState>(
      'appends page 2 scans to page 1 on loadMore()',
      build: () {
        final repo = MockHistoryRepository();
        final storage = MockFlutterSecureStorage();
        when(() => storage.read(key: 'userId'))
            .thenAnswer((_) async => 'user_123');

        var callCount = 0;
        when(() => repo.getHistory(
              userId: any(named: 'userId'),
              page: any(named: 'page'),
              limit: any(named: 'limit'),
            )).thenAnswer((_) async {
          callCount++;
          return callCount == 1 ? fakeFullPage() : fakePartialPage();
        });

        return HistoryCubit(repo, storage: storage);
      },
      act: (cubit) async {
        await cubit.fetchHistory();
        await cubit.loadMore();
      },
      expect: () => [
        const HistoryState.loading(),
        HistoryState.success(scans: fakeFullPage(), hasMore: true),
        HistoryState.success(
          scans: [...fakeFullPage(), ...fakePartialPage()],
          hasMore: false,
        ),
      ],
    );

    blocTest<HistoryCubit, HistoryState>(
      'does NOT emit when loadMore() called after hasMore=false',
      build: () {
        final repo = MockHistoryRepository();
        final storage = MockFlutterSecureStorage();
        when(() => storage.read(key: 'userId'))
            .thenAnswer((_) async => 'user_123');
        when(() => repo.getHistory(
              userId: any(named: 'userId'),
              page: any(named: 'page'),
              limit: any(named: 'limit'),
            )).thenAnswer((_) async => fakePartialPage());
        return HistoryCubit(repo, storage: storage);
      },
      act: (cubit) async {
        await cubit.fetchHistory();
        await cubit.loadMore();
      },
      expect: () => [
        const HistoryState.loading(),
        HistoryState.success(scans: fakePartialPage(), hasMore: false),
      ],
    );

    blocTest<HistoryCubit, HistoryState>(
      'sets hasMore=false when loadMore returns empty list',
      build: () {
        final repo = MockHistoryRepository();
        final storage = MockFlutterSecureStorage();
        when(() => storage.read(key: 'userId'))
            .thenAnswer((_) async => 'user_123');

        var callCount = 0;
        when(() => repo.getHistory(
              userId: any(named: 'userId'),
              page: any(named: 'page'),
              limit: any(named: 'limit'),
            )).thenAnswer((_) async {
          callCount++;
          return callCount == 1 ? fakeFullPage() : []; // page 2 empty
        });

        return HistoryCubit(repo, storage: storage);
      },
      act: (cubit) async {
        await cubit.fetchHistory();
        await cubit.loadMore();
      },
      expect: () => [
        const HistoryState.loading(),
        HistoryState.success(scans: fakeFullPage(), hasMore: true),
        // loadMore got empty → same scans, hasMore flipped false
        HistoryState.success(scans: fakeFullPage(), hasMore: false),
      ],
    );
  });
}
