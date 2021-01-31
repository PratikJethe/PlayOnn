import 'package:dio/dio.dart';

Future fetchData() async {
  Dio dio = Dio();
  var res = await dio.get(
      'http://playonnuat-env.eba-ernpdw3w.ap-south-1.elasticbeanstalk.com/api/v1/establishment/test/list?offset=0&limit=10');
  return res.data;
}
