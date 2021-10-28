import 'package:flutter_test/flutter_test.dart';
import 'package:key_wallet/shared/hash_functions.dart';

void main() {
  HashFunctions hash = HashFunctions();

  test('test Is Sha512 Encode Correctly', () {
    //Given
    String password = 'password';
    String pepper = 'pepper';
    String salt = 'salt';
    String correctlyEncoded =
        '39d15ce841ae28da33487e4297f2eb7adbb0a4550b89af737aa4a3f132ac7fada1fd43bc20b1cc3eb16e11e23fd68b7cd75c620dd0672749f59d0625c7dd8a84';
    //When
    String encoded = hash.calcSHA512(password, pepper, salt);
    //Then
    expect(encoded, correctlyEncoded);
  });
  test('test Is MD5 Encode Correctly', () {
    //Given
    String text = 'text';
    String correctlyEncoded = '1cb251ec0d568de6a929b520c4aed8d1';
    //When
    String encoded = hash.calcMD5(text);
    //Then
    expect(encoded, correctlyEncoded);
  });

  test('test Is Random pepper Correctly', () {
    //Given

    //When
    String pepper = hash.getRandomPepper();
    //Then
    expect(pepper != '', true);
  });
  test('test Is aes Encode Correctly', () {
    //Given
    String password = 'password';
    String key = 'key';
    String pepper = 'pepper';
    String correct = 'f6ad606df3e0c0f825c4d37b736a5fa4';
    //When
    String encoded = hash.calcEnryptAes(password, key, pepper);

    //Then
    expect(encoded, correct);
  });
  test('test Is aes dEncode Correctly', () {
    //Given
    String password = 'f6ad606df3e0c0f825c4d37b736a5fa4';
    String key = 'key';
    String pepper = 'pepper';
    String correct = 'password';
    //When
    String encoded = hash.calcDecryAes(password, key, pepper);
    //Then
    expect(encoded, correct);
  });
}
