import 'package:equatable/equatable.dart';
import 'package:restaurant_app/api/model/detail_restoran.dart';
import 'package:restaurant_app/api/model/restoran_model.dart';

sealed class Status extends Equatable {
  const Status();
  @override
  List<Object?> get props => [];
}

class Statusloading extends Status {
  const Statusloading();
}

class StatusIdle extends Status {
  const StatusIdle();
}

class Statuserror extends Status {
  final String message;
  const Statuserror({required this.message});

  @override
  List<Object?> get props => [message];
}

class Statussukses extends Status {
  final Restoranlist datarestoran;
  const Statussukses({required this.datarestoran});
  @override
  List<Object?> get props => [datarestoran];
}

class StatussuksesSearch extends Status {
  final SearchRestoran datarestoran;
  const StatussuksesSearch({required this.datarestoran});
  @override
  List<Object?> get props => [datarestoran];
}

class Statussuksesdetail extends Status {
  final DetailRestoran data;
  const Statussuksesdetail({required this.data});
  @override
  List<Object?> get props => [data];
}

class StatussuksesPostreview extends Status {
  final ReviewPostResponse response;
  const StatussuksesPostreview({required this.response});
  @override
  List<Object?> get props => [response];
}

class StatussuksesloaDatabase extends Status {
  final String message;
  const StatussuksesloaDatabase(this.message);
  @override
  List<Object?> get props => [message];
}
