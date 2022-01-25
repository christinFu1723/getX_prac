import 'package:demo7_pro/dto/page_no_entity.dart';

pageNoEntityFromJson(PageNoEntity data, Map<String, dynamic> json) {
	if (json['pageNo'] != null) {
		data.pageNo = json['pageNo'] is String
				? int.tryParse(json['pageNo'])
				: json['pageNo'].toInt();
	}
	if (json['pageSize'] != null) {
		data.pageSize = json['pageSize'] is String
				? int.tryParse(json['pageSize'])
				: json['pageSize'].toInt();
	}
	return data;
}

Map<String, dynamic> pageNoEntityToJson(PageNoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['pageNo'] = entity.pageNo;
	data['pageSize'] = entity.pageSize;
	return data;
}