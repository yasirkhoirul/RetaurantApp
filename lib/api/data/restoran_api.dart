import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/api/data/baseurl.dart';
import 'package:restaurant_app/api/model/detail_restoran.dart';
import 'package:restaurant_app/api/model/restoran_model.dart';

class Apiservice {
  Future<Restoranlist> getRestoranlist() async {
    final data = await http.get(Uri.parse("${Baseurl.url}/list"));
    if (data.statusCode == 200) {
      return Restoranlist.fromjson(jsonDecode(data.body));
    } else {
      throw Exception(
        "Terjadi kesalahand dengan status code ${data.statusCode}",
      );
    }
  }

  Future<SearchRestoran> getSearchRestoran(String query) async {
    final data = await http.get(Uri.parse("${Baseurl.url}/search?q=$query"));
    if (data.statusCode == 200) {
      return SearchRestoran.fromjson(jsonDecode(data.body));
    } else {
      throw Exception("terjadi kesalahan ${data.statusCode}");
    }
  }

  Future<DetailRestoran> getDetailRestoran(String id) async {
    final data = await http.get(Uri.parse("${Baseurl.url}/detail/$id"));
    if (data.statusCode == 200) {
      return DetailRestoran.fromjson(jsonDecode(data.body));
    } else {
      throw Exception("terjadi kesalahan ${data.statusCode}");
    }
  }

  Future<ReviewPostResponse> postReview(
    String id,
    String name,
    String review,
  ) async {
    final datapost = await http.post(
      Uri.parse("${Baseurl.url}/review"),
      body: ReviewPost(id: id, name: name, review: review).toJson(),
    );

    if (datapost.statusCode == 201 || datapost.statusCode == 200) {
      return ReviewPostResponse.fromjson(jsonDecode(datapost.body));
    } else {
      throw Exception("terjadi kesalhan ${datapost.statusCode}");
    }
  }
}
