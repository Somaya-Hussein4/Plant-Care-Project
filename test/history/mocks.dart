import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/features/history/data/repo/history_repo.dart';

import 'package:mocktail/mocktail.dart';

class MockHistoryRepository extends Mock implements HistoryRepository {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}
