import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/riverpod/notifier/cart_change_notifier.dart';
import 'package:food_delivery_app/riverpod/notifier/cart_item_count_notifier.dart';
import 'package:food_delivery_app/utils/token_auth_service.dart';

final tokenAuthProvider = Provider<TokenAuthService>((ref) {
  return TokenAuthService(Dio());
});

final cartChangeNotifierProvider =
    ChangeNotifierProvider.autoDispose<CartChangeNotifier>(((ref) {
  return CartChangeNotifier(
      authenticationService: ref.watch(tokenAuthProvider));
}));

final cartItemCountProvider =
    ChangeNotifierProvider.autoDispose<CartItemCountNotifier>((ref) {
  return CartItemCountNotifier();
});
