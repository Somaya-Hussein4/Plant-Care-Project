import 'package:graduation_project/features/auth/data/models/auth_response_model.dart';
import 'package:graduation_project/features/auth/data/models/token_model.dart';
import 'package:graduation_project/features/auth/data/models/user_model.dart';
import 'package:graduation_project/features/auth/logic/cubit/auth_cubit.dart';
import 'package:graduation_project/features/auth/logic/cubit/auth_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../result/mocks.dart';
import 'mocks.dart';

void main() {
  late MockUserDeviceService mockDeviceService;
  late MockAuthRepository mockRepo;
  late AuthCubit cubit;

  setUp(() {
    mockRepo = MockAuthRepository();
    mockDeviceService = MockUserDeviceService();
    cubit = AuthCubit(mockRepo, deviceService: mockDeviceService);
  });

  tearDown(() => cubit.close());

  group('AuthCubit - login', () {
    blocTest<AuthCubit, AuthState>(
      'emits [loading, success] when login succeeds',
      build: () {
        when(() => mockRepo.login(any(), any()))
            .thenAnswer((_) async => AuthResponseModel(
                  success: true,
                  message: 'Login successful',
                  data: AuthData(
                    user: UserModel(
                      id: '123',
                      email: 'test@email.com',
                      emailVerified: true,
                    ),
                    tokens: TokenModel(
                      accessToken: 'fake_access_token',
                      refreshToken: 'fake_refresh_token',
                      expiresIn: 3600,
                    ),
                  ),
                ));
        return cubit;
      },
      act: (cubit) => cubit.login('test@email.com', 'password123'),
      expect: () => [
        const AuthState.loading(),
        const AuthState.success(
          UserModel(id: '123', email: 'test@email.com', emailVerified: true),
        ),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, failure] when login throws',
      build: () {
        when(() => mockRepo.login(any(), any()))
            .thenAnswer((_) async => throw Exception('Invalid credentials'));
        return cubit;
      },
      act: (cubit) => cubit.login('bad@email.com', 'wrong'),
      expect: () => [
        const AuthState.loading(),
        isA<AuthFailure>(),
      ],
    );
  });
}
