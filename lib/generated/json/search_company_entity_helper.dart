import 'package:demo7_pro/dto/search_company_entity.dart';

searchCompanyEntityFromJson(SearchCompanyEntity data, Map<String, dynamic> json) {
	if (json['organizeNameLike'] != null) {
		data.organizeNameLike = json['organizeNameLike'].toString();
	}
	if (json['organizeStatus'] != null) {
		data.organizeStatus = json['organizeStatus'].toString();
	}
	return data;
}

Map<String, dynamic> searchCompanyEntityToJson(SearchCompanyEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['organizeNameLike'] = entity.organizeNameLike;
	data['organizeStatus'] = entity.organizeStatus;
	return data;
}