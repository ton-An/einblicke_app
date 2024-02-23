import 'package:einblicke_app/features/authentication/data/data_sources/authentication_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures.dart';
import '../../../../mocks.dart';

void main() {
  late AuthenticationLocalDataSourceImpl authenticationLocalDataSourceImpl;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();
    authenticationLocalDataSourceImpl = AuthenticationLocalDataSourceImpl(
      secureStorage: mockSecureStorage,
    );
  });

  group("deleteTokens()", () {
    test("should delete all tokens from the secure storage", () async {
      // arrange
      when(() => mockSecureStorage.deleteAll())
          .thenAnswer((_) => Future.value());

      // act
      await authenticationLocalDataSourceImpl.deleteTokens();

      // assert
      verify(() => mockSecureStorage.deleteAll());
    });
  });

  group("getTokenBundle()", () {
    test("should return the [TokenBundle] from the secure storage", () async {
      // arrange
      when(() => mockSecureStorage.read(key: any(named: "key")))
          .thenAnswer((_) => Future.value(tTokenBundleJsonString));

      // act
      final result = await authenticationLocalDataSourceImpl.getTokenBundle();

      // assert
      expect(result, tTokenBundle);
    });

    test(
        "should return null when the [TokenBundle] is not present in the secure storage",
        () async {
      // arrange
      when(() => mockSecureStorage.read(key: any(named: "key")))
          .thenAnswer((_) => Future.value(null));

      // act
      final result = await authenticationLocalDataSourceImpl.getTokenBundle();

      // assert
      expect(result, null);
    });
  });

  group("isTokenBundlePresent()", () {
    test("should a [bool] indicating whether the [TokenBundle] is present",
        () async {
      // arrange
      when(() => mockSecureStorage.containsKey(key: any(named: "key")))
          .thenAnswer((_) => Future.value(true));

      // act
      final result =
          await authenticationLocalDataSourceImpl.isTokenBundlePresent();

      // assert
      expect(result, true);
    });
  });

  group("saveTokenBundle()", () {
    test("should save the [TokenBundle] to the secure storage", () async {
      // arrange
      when(() => mockSecureStorage.write(
            key: any(named: "key"),
            value: any(named: "value"),
          )).thenAnswer((_) => Future.value());

      // act
      await authenticationLocalDataSourceImpl.saveTokenBundle(
          tokenBundle: tTokenBundle);

      // assert
      verify(() => mockSecureStorage.write(
            key: any(named: "key"),
            value: tTokenBundleJsonString,
          ));
    });
  });
}
