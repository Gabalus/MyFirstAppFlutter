import 'dart:convert';

import 'package:http/http.dart' as http;

import '../assets/constants.dart' as Constants;

const _postLimit = 30;

class RestServiceImpl {
  final http.Client httpClient;

  RestServiceImpl({required this.httpClient});

  Future<List<dynamic>> getPostsRequest(int index, dynamic httpClient) async {
    var uri = Uri.http(Constants.baseUrl, Constants.usersEndpoint);
    final response = await httpClient.get(uri, headers: {
      'Authorization':
      'Token eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTYsImV4cCI6MTcxMTA0MjM4OH0.5HM0ybuS9C8EWeNZhziipj7eEIk9OfM9OZnHDovnofg',
      'X-Pagination-Per-Page': '$_postLimit',
      'X-Pagination-Current-Page': '$index',
    });
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['data'];
      return body;
    }
    throw Exception('error fetching posts');
  }
}
