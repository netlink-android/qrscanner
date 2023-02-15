import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class StorageProvider with ChangeNotifier {
  List<dynamic> _data = [];
  final _storage = GetStorage();
  addData(String datatest) async {
    if (_storage.read('data') != null) {
      _data = _storage.read('data');
      _data.insert(0, datatest);
      _storage.write('data', _data);
    } else {
      _data.insert(0, datatest);
      _storage.write('data', _data);
    }
    notifyListeners();
  }

  addDataScanner(String datatest) async {
    if (_storage.read('dataScanner') != null) {
      _data = _storage.read('dataScanner');
      _data.insert(0, datatest);
      _storage.write('dataScanner', _data);
    } else {
      _data.insert(0, datatest);
      _storage.write('dataScanner', _data);
    }
    notifyListeners();
  }

  remoceItem(int id) async {
    _data = _storage.read('data');
    await _data.removeAt(id);
    if (_data.length >= 1) {
      _storage.write('data', _data);
    } else {
      _storage.remove('data');
    }
    notifyListeners();
  }

  remoceScan(int id) async {
    _data = _storage.read('dataScanner');
    await _data.removeAt(id);
    if (_data.length >= 1) {
      _storage.write('dataScanner', _data);
    } else {
      _storage.remove('dataScanner');
    }
    notifyListeners();
  }

  //favorite
  addDataFavorite(String datatest) async {
    if (_storage.read('dataFavorite') != null) {
      _data = _storage.read('dataFavorite');
      _data.insert(0, datatest);
      _storage.write('dataFavorite', _data);
    } else {
      _data.insert(0, datatest);
      _storage.write('dataFavorite', _data);
    }
    notifyListeners();
  }

  remoceFavorite(int id) async {
    _data = _storage.read('dataFavorite');
    await _data.removeAt(id);
    if (_data.length >= 1) {
      _storage.write('dataFavorite', _data);
    } else {
      _storage.remove('dataFavorite');
    }
    notifyListeners();
  }

  addDFavorite(int id, String datatest) async {
    _data = _storage.read('dataScanner');
    if (_data.length >= 1) {
      _data[id] = datatest;
      _storage.write('dataScanner', _data);
    } else {
      _storage.remove('dataScanner');
    }
    notifyListeners();
  }
}
