import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/utils/token_auth_service.dart';

final tokenAuthProvider = Provider<TokenAuthService>((ref) {
  return TokenAuthService(Dio());
});
