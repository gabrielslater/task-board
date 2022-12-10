import 'package:localstore/localstore.dart';

class LocalStoreManager {
  final _db = Localstore.instance;
  final path = 'board';

  void saveToStorage(String key, dynamic data) {
    _db.collection(path).doc(key).set(data);
  }

  Future<dynamic> loadFromStorage(String key) async {
    return await _db.collection(path).doc(key).get();
  }

  void delete(String key) {
    _db.collection(path).doc(key).delete();
  }
}
