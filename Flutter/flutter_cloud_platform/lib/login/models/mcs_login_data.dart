class MCSLoginData {
  MCSLoginData({
    required this.username,
    required this.password
  });

  final String username;
  final String password;

  @override
  String toString() {
    return '$runtimeType($username, $password)';
  }

  @override
  bool operator ==(Object other) {
    if (other is MCSLoginData) {
      return username == other.username && password == other.password;
    }
    return false;
  }

  @override
  int get hashCode => username.hashCode + password.hashCode;
}