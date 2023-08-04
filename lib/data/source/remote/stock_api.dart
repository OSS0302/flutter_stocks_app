import 'package:http/http.dart' as http;

class StockApi {
  //http
  static const baseUrl = 'https://www.alphavantage.co/'; // 홈이페지 주소
  static const apiKey = 'U80NMMGLBQOFOAJL'; // 키 넣기

  final http.Client client; //통신하기 위해서 클라이언트 정의해야한다
  StockApi(this.client); // 생성자 추가

  Future<http.Response> getListings(String apiKey) async {
    // Response 객체 로 이제 데이터가 들어간다.
       return await client.get(Uri.parse('https://www.alphavantage.'
        'co/query?function=EARNINGS_CALENDAR&horizon=3month&apikey=$apiKey'));
  }
}
