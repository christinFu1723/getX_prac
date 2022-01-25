import 'dart:async';
import 'package:demo7_pro/http/http.dart';
import 'package:demo7_pro/dto/page_no_entity.dart' show PageNoEntity;
import 'package:demo7_pro/dto/search_company_entity.dart'
    show SearchCompanyEntity; // 搜索企业接口而入参
import 'package:demo7_pro/model/search_company_list_entity.dart'
    show SearchCompanyListEntity; // 搜索企业列表回参
import 'package:demo7_pro/model/company_info_entity.dart' show CompanyInfoEntity;
import 'package:demo7_pro/generated/json/base/json_convert_content.dart'
    show JsonConvert;

const baseUrl = 'https://api.uat.chanjesign.com';

class SearchCompanyRequest {
  // 搜索企业列表
  static Future<dynamic> fetch(
      PageNoEntity urlData, SearchCompanyEntity data) async {
    final resp = await HttpUtil.instance.post(
        '$baseUrl/api/mini/v1/organizes/apply/page',
        queryParameters: {
          'pageNo': urlData.pageNo ?? 1,
          'pageSize': urlData.pageSize ?? 10
        },
        data: data.toJson());
    SearchCompanyListEntity respJson;

    if (resp['code'] == 200) {
      respJson = JsonConvert.fromJsonAsT(resp['data']);
    }
    return respJson;
  }
  // 获取企业详情
  static Future<dynamic> getItem(String organizeNo) async {
    final resp = await HttpUtil.instance.get(
      '$baseUrl/api/mini/v1/organizes/organize/$organizeNo',
    );
    CompanyInfoEntity respJson;

    if (resp['code'] == 200) {
      respJson = JsonConvert.fromJsonAsT(resp['data']);
    }
    return respJson;
  }
}
