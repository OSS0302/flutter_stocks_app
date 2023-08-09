abstract class CsvParser<T>{

  Future<List<T>>parse(String csvString); // csv 파싱 인터 페이스다
}