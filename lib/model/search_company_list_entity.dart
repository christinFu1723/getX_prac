import 'package:demo7_pro/generated/json/base/json_convert_content.dart';

class SearchCompanyListEntity with JsonConvert<SearchCompanyListEntity> {
	int total;
	List<SearchCompanyListData> data;
}

class SearchCompanyListData with JsonConvert<SearchCompanyListData> {
	String organizeNo;
	String organizeName;
	String organizeStatus;
	dynamic auditor;
	dynamic auditTime;
	String platformAccountName;
	String gmtCreate;
}
