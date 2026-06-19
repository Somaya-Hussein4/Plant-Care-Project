import 'package:mocktail/mocktail.dart';
import 'package:graduation_project/features/auth/data/repo/auth_repository.dart'
    show AuthRepository;

class MockAuthRepository extends Mock implements AuthRepository {}
