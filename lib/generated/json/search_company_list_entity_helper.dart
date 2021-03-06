import 'package:demo7_pro/model/search_company_list_entity.dart';

searchCompanyListEntityFromJson(SearchCompanyListEntity data, Map<String, dynamic> json) {
	if (json['total'] != null) {
		data.total = json['total'] is String
				? int.tryParse(json['total'])
				: json['total'].toInt();
	}
	if (json['data'] != null) {
		data.data = (json['data'] as List).map((v) => SearchCompanyListData().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> searchCompanyListEntityToJson(SearchCompanyListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['total'] = entity.total;
	data['data'] =  entity.data?.map((v) => v.toJson())?.toList();
	return data;
}

searchCompanyListDataFromJson(SearchCompanyListData data, Map<String, dynamic> json) {
	if (json['organizeNo'] != null) {
		data.organizeNo = json['organizeNo'].toString();
	}
	if (json['organizeName'] != null) {
		data.organizeName = json['organizeName'].toString();
	}
	if (json['organizeStatus'] != null) {
		data.organizeStatus = json['organizeStatus'].toString();
	}
	if (json['auditor'] != null) {
		data.auditor = json['auditor'];
	}
	if (json['auditTime'] != null) {
		data.auditTime = json['auditTime'];
	}
	if (json['platformAccountName'] != null) {
		data.platformAccountName = json['platformAccountName'].toString();
	}
	if (json['gmtCreate'] != null) {
		data.gmtCreate = json['gmtCreate'].toString();
	}
	return data;
}

Map<String, dynamic> searchCompanyListDataToJson(SearchCompanyListData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['organizeNo'] = entity.organizeNo;
	data['organizeName'] = entity.organizeName;
	data['organizeStatus'] = entity.organizeStatus;
	data['auditor'] = entity.auditor;
	data['auditTime'] = entity.auditTime;
	data['platformAccountName'] = entity.platformAccountName;
	data['gmtCreate'] = entity.gmtCreate;
	return data;
}