abstract class ISecureService {
  Future<void> saveAccessToken(String value);
  Future<void> saveRefreshToken(String value);

  Future<String?> get getAccessToken;
  Future<String?> get getRefreshToken;

  Future<void> clearAccessToken();
  Future<void> clearRefreshToken();
}

class SecureService implements ISecureService {
  String? _inMemoryAccessToken;
  String? _inMemoryRefreshToken;

  @override
  Future<void> saveAccessToken(String value) async {
    _inMemoryAccessToken = value;
  }

  @override
  Future<void> saveRefreshToken(String value) async {
    _inMemoryRefreshToken = value;
  }

  @override
  Future<String?> get getAccessToken async {
    return _inMemoryAccessToken;
  }

  @override
  Future<String?> get getRefreshToken async {
    return _inMemoryRefreshToken;
  }

  @override
  Future<void> clearAccessToken() async {
    _inMemoryAccessToken = null;
  }

  @override
  Future<void> clearRefreshToken() async {
    _inMemoryRefreshToken = null;
  }
}
