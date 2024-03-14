import 'package:dio/dio.dart';
import 'package:flutter_rickandmorty/common/constants.dart';

class CharactersService {
  late Dio dio;

  CharactersService() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      method: 'GET',
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );

    dio = Dio(options);
  }

  Future<Map<String, dynamic>> getAll({int page = 1}) async {
    Response res = await dio.get('character/?page=$page');
    return res.data as Map<String, dynamic>;
  }
}

// void main() async {
//   final ch = CharactersService();
//   final x = await ch.getAll(page: 2);
//   print(x['info']);
// }
