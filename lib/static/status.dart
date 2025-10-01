import 'package:restaurant_app/api/model/detail_restoran.dart';
import 'package:restaurant_app/api/model/restoran_model.dart';

sealed class Status {}

class Statusloading extends Status {}

class StatusIdle extends Status {}

class Statuserror extends Status {
  final String message;
  Statuserror({required this.message});
}

class Statussukses extends Status {
  final Restoranlist datarestoran;
  Statussukses({required this.datarestoran});
}

class StatussuksesSearch extends Status {
  final SearchRestoran datarestoran;
  StatussuksesSearch({required this.datarestoran});
}

class Statussuksesdetail extends Status {
  final DetailRestoran data;
  Statussuksesdetail({required this.data});
}

class StatussuksesPostreview extends Status {
  final ReviewPostResponse response;
  StatussuksesPostreview({required this.response});
}

class StatussuksesloaDatabase extends Status {
  final String message;
  StatussuksesloaDatabase(this.message);
}
