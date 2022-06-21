import 'package:json_annotation/json_annotation.dart';
import 'package:jwt_decode/jwt_decode.dart';

part 'user_auth.g.dart';

@JsonSerializable()
class UserAuth {
  final String token;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  UserAuth(this.token, this.refreshToken);

  factory UserAuth.fromJson(Map<String, dynamic> json) => _$UserAuthFromJson(json);

  Map<String, dynamic> toJson() => _$UserAuthToJson(this);

  @override
  String toString() {
    return 'UserAuth{token: $token, refreshToken: $refreshToken}';
  }

  String getEmail() {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return payload['username'];
  }

  List<String> getRoles() {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return payload['roles'];
  }

  bool isSessionExpired() {
    return Jwt.isExpired(token);
  }

  DateTime getIat() {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return DateTime.fromMillisecondsSinceEpoch(payload['iat']);
  }
}
