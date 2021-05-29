import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/src/common/repositories/token_repository.dart';

void main() {
  test(
    'When get token from repository '
    'should return the correct value',
    () async {
      final repository = MockTokenRepository();
      final token = await repository.getToken();
      final expectedToken = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.'
          'eyJzdWIiOiJhd2Vzb21lY3VzdG9tZXJAZ21haWwuY29tIn0.'
          'cGT2KqtmT8KNIJhyww3T8fAzUsCD5_vxuHl5WbXtp8c';

      expect(token, expectedToken);
    },
  );
}
