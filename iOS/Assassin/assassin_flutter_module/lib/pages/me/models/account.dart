class Account {
  String username;
  String nickname;
  String headUrl;

  Account({this.username, this.nickname, this.headUrl});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      username: json['username'],
      nickname: json['cnname'],
      headUrl: json['headUrl']
    );
  }
}