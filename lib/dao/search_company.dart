import 'dart:async';
import 'package:demo7_pro/http/http.dart';

const baseUrl = 'https://api.uat.chanjesign.com';

class SearchCompanyRequest {
  static Future<dynamic> fetch(urlData, data) async {
    final resp = await HttpUtil.instance.post(
        '$baseUrl/api/mini/v1/organizes/apply/page',
        queryParameters: {
          'pageNo': urlData['pageNo'] ?? 1,
          'pageSize': urlData['pageSize'] ?? 10
        },
        data: data);
    Map respJson = {};

    if (resp['code'] == 200) {
      respJson = resp['data'] ?? {};
    }

    return {'data': respJson['data']??[],'total':respJson['total']??0};
  }
}
