import 'package:localstore/localstore.dart';

class LocalStoreManager {
  final _db = Localstore.instance;

  void saveToStorage(String key, Map<String, dynamic> data) {
    var id = _db.collection('board').doc().id;

    _db.collection('board').doc(id).set(data);
  }

  Future<Map<String, dynamic>?> loadFromStorage(String key) async {
    var id = _db.collection('todos').doc().id;

    return await _db.collection('todos').doc(id).get();
  }
}
