import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:restaurant_app/api/model/restoran_model.dart';
import 'package:restaurant_app/service/sqlite_service.dart';
import 'package:restaurant_app/static/status.dart';

class DatabaseProvider extends ChangeNotifier {
  final SqliteService sqlite;

  DatabaseProvider({required this.sqlite});

  Status _status = StatusIdle();
  Status get status => _status;
  List<Restoran>? _restoran;
  List<Restoran>? get restoran => _restoran;
  Restoran? _itemrestoran;
  Restoran? get itemrestoran => _itemrestoran;

  bool isCheck(String id) {
    return _restoran?.any((element) => element.id == id) ?? false;
  }

  Future saveFavResto(Restoran resto) async {
    _status = Statusloading();
    try {
      final result = await sqlite.insertRestoran(resto);
      final iserror = result == 0;

      Logger().d(iserror);
      if (iserror) {
        _status = Statuserror(message: "gagal untuk menyimpan");
      } else {
        await loadAllFavoritRestoran();
        _status = StatussuksesloaDatabase("sukses menyimpan ke database");
      }
    } catch (e) {
      _status = Statuserror(
        message: "terjadi kesalahan dalam load database $e",
      );
    } finally {
      notifyListeners();
    }
  }

  Future deleteFavoritRestran(String id) async {
    try {
      final data = await sqlite.deleteItem(id);
      if (data == 0 || data == null) {
        _status = Statuserror(message: "terjadi kesalahan ketika menghapus");
      } else {
        await loadAllFavoritRestoran();
        _status = StatussuksesloaDatabase("berhasil mengapus");
      }
    } catch (e) {
      _status = Statuserror(message: "terjadi kesalahan $e");
    } finally {
      notifyListeners();
    }
  }

  Future loadAllFavoritRestoran() async {
    _status = Statusloading();
    try {
      _restoran = await sqlite.getAllFavrestoran();
      _status = StatussuksesloaDatabase("berhasil load database");
    } catch (e) {
      _status = Statuserror(message: e.toString());
    } finally {
      notifyListeners();
    }
  }
}
