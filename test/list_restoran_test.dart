import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/api/data/restoran_api.dart';
import 'package:restaurant_app/api/model/restoran_model.dart';
import 'package:restaurant_app/provider/restoranlist_provider.dart';
import 'package:restaurant_app/static/status.dart';
import 'list_restoran_test.mocks.dart';
// Buat class mock manual
@GenerateMocks([Apiservice])

void main() {
  late RestoranlistProvider restoranlistprovider;
  late Apiservice mockApi;
  setUp(
    () {
      mockApi = MockApiservice();
      restoranlistprovider = RestoranlistProvider(api: mockApi);
    },
  );


  test('Memastikan state awal provider harus didefinisikan', () {
    final init = restoranlistprovider.status;
    expect(init, StatusIdle());
  },);

  test(
    'Memastikan harus mengembalikan daftar restoran ketika pengambilan data API berhasil.',
    () async {
      final dummyResponse = Restoranlist(
        error: false,
        message: '',
        count: 0,
        restaurant: [],
      );
      when(mockApi.getRestoranlist())
          .thenAnswer((_) async => Future.value(dummyResponse));
      await restoranlistprovider.fetchdata();
      expect(
        restoranlistprovider.status,
        isA<Statussukses>().having(
          (s) => s.datarestoran,
          'data restoran',
          dummyResponse,
        ),
      );
      verify(mockApi.getRestoranlist()).called(1);
    },
  );
  test('Memastikan harus mengembalikan kesalahan ketika pengambilan data API gagal', ()async {
    when(mockApi.getRestoranlist()).thenThrow((realInvocation) => Exception('terjadi kesalahan'),);
    await restoranlistprovider.fetchdata();
    expect(restoranlistprovider.status, isA<Statuserror>());
  },);
  

}
