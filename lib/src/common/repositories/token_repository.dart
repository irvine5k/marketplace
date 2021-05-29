abstract class TokenRepository {
  Future<String> getToken();
}

class MockTokenRepository implements TokenRepository {
  @override
  Future<String> getToken() async {
    final token = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.'
        'eyJzdWIiOiJhd2Vzb21lY3VzdG9tZXJAZ21haWwuY29tIn0.'
        'cGT2KqtmT8KNIJhyww3T8fAzUsCD5_vxuHl5WbXtp8c';

    return token;
  }
}
