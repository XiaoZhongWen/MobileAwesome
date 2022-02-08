class Account {
  String? userId;
  String? password;
  String? nickname;
  String? headUrl;
  String? accessToken;
  String? refreshToken;
  int? expire;

  Account(
      this.userId,
      this.password,
      this.nickname,
      this.headUrl,
      this.accessToken,
      this.refreshToken,
      this.expire);

  factory Account.fromJson(Map<String, Object?> json) {
    String? userId = json['userId'] as String?;
    String? password = json['password'] as String?;
    String? nickname = json['nickname'] as String?;
    String? headUrl = json['headUrl'] as String?;
    String? accessToken = json['accessToken'] as String?;
    String? refreshToken = json['refreshToken'] as String?;
    int? expire = json['expire'] as int?;
    return Account(userId, password, nickname, headUrl, accessToken, refreshToken, expire);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (userId != null && userId!.isNotEmpty) {
      json['userId'] = userId;
    }
    if (password != null && password!.isNotEmpty) {
      json['password'] = password;
    }
    if (nickname != null && nickname!.isNotEmpty) {
      json['nickname'] = nickname;
    }
    if (headUrl != null && headUrl!.isNotEmpty) {
      json['headUrl'] = headUrl;
    }
    if (accessToken != null && accessToken!.isNotEmpty) {
      json['accessToken'] = accessToken;
    }
    if (refreshToken != null && refreshToken!.isNotEmpty) {
      json['refreshToken'] = refreshToken;
    }
    if (expire != null) {
      json['expire'] = expire;
    }
    return json;
  }
}