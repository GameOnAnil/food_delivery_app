import 'package:food_delivery_app/utils/firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreServideProvider =
    Provider<FirestoreService>((ref) => FirestoreService());
