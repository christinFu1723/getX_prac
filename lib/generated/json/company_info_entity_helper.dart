import 'package:demo7_pro/model/company_info_entity.dart';
import 'package:demo7_pro/utils/app.dart' show AppUtil;
import 'package:demo7_pro/utils/validate.dart' show ValidateUtil;
import 'package:demo7_pro/utils/string.dart' show StringUtil;
import 'package:logger/logger.dart';

companyInfoEntityFromJson(CompanyInfoEntity data, Map<String, dynamic> json) {
	if (json['organizeNo'] != null) {
		data.organizeNo = json['organizeNo'].toString();
	}
	if (json['organizeName'] != null) {
		data.organizeName = json['organizeName'].toString();
	}
	if (json['organizeSocialCode'] != null) {
		data.organizeSocialCode = json['organizeSocialCode'].toString();
	}
	if (json['legalName'] != null) {
		data.legalName = json['legalName'].toString();
	}
	if (json['legalIdCardNo'] != null) {
		data.legalIdCardNo = json['legalIdCardNo'].toString();
	}
	if (json['legalMobile'] != null) {
		data.legalMobile = json['legalMobile'].toString();
	}
	if (json['organizeRegisteredCapital'] != null) {
		data.organizeRegisteredCapital = json['organizeRegisteredCapital'].toString();
	}
	if (json['organizeRegisteredTime'] != null) {
		data.organizeRegisteredTime = json['organizeRegisteredTime'].toString();
	}
	if (json['organizeAddress'] != null) {
		data.organizeAddress = json['organizeAddress'].toString();
	}
	if (json['contact'] != null) {
		data.contact = json['contact'].toString();
	}
	if (json['contactMobile'] != null) {
		data.contactMobile = json['contactMobile'].toString();
	}
	if (json['contactAddress'] != null) {
		data.contactAddress = json['contactAddress'].toString();
	}
	if (json['organizeAccountName'] != null) {
		data.organizeAccountName = json['organizeAccountName'].toString();
	}
	if (json['organizeAccountMobile'] != null) {
		data.organizeAccountMobile = json['organizeAccountMobile'].toString();
	}
	if (json['position'] != null) {
		data.position = json['position'].toString();
	}
	if (json['effectiveDate'] != null) {
		data.effectiveDate = json['effectiveDate'].toString();
	}
	if (json['expireDate'] != null) {
		data.expireDate = json['expireDate'].toString();
	}
	if (json['subAccountNum'] != null) {
		data.subAccountNum = json['subAccountNum'].toString();
	}
	if (json['products'] != null) {
		data.products = (json['products'] as List).map((v) => CompanyInfoProducts().fromJson(v)).toList();
	}
	if (json['signProducts'] != null) {
		data.signProducts = (json['signProducts'] as List).map((v) => CompanyInfoProducts().fromJson(v)).toList();
	}
	if (json['applyAttaches'] != null) {
		data.applyAttaches = (json['applyAttaches'] as List).map((v) => CompanyInfoAttaches().fromJson(v)).toList();
	}
	if (json['attaches'] != null) {
		data.attaches = (json['attaches'] as List).map((v) => CompanyInfoAttaches().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> companyInfoEntityToJson(CompanyInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['organizeNo'] = entity.organizeNo;
	data['organizeName'] = entity.organizeName;
	data['organizeSocialCode'] = entity.organizeSocialCode;
	data['legalName'] = entity.legalName;
	data['legalIdCardNo'] = entity.legalIdCardNo;
	data['legalMobile'] = entity.legalMobile;
	data['organizeRegisteredCapital'] = entity.organizeRegisteredCapital;
	data['organizeRegisteredTime'] = entity.organizeRegisteredTime;
	data['organizeAddress'] = entity.organizeAddress;
	data['contact'] = entity.contact;
	data['contactMobile'] = entity.contactMobile;
	data['contactAddress'] = entity.contactAddress;
	data['organizeAccountName'] = entity.organizeAccountName;
	data['organizeAccountMobile'] = entity.organizeAccountMobile;
	data['position'] = entity.position;
	data['effectiveDate'] = entity.effectiveDate;
	data['expireDate'] = entity.expireDate;
	data['subAccountNum'] = entity.subAccountNum;
	data['products'] =  entity.products?.map((v) => v.toJson())?.toList();
	data['signProducts'] =  entity.signProducts?.map((v) => v.toJson())?.toList();
	data['applyAttaches'] =  entity.applyAttaches?.map((v) => v.toJson())?.toList();
	data['attaches'] =  entity.attaches?.map((v) => v.toJson())?.toList();
	return data;
}

companyInfoProductsFromJson(CompanyInfoProducts data, Map<String, dynamic> json) {
	if (json['productNo'] != null) {
		data.productNo = json['productNo'].toString();
	}
	if (json['contractedPrice'] != null) {
		data.contractedPrice = json['contractedPrice'].toString();
	}
	if (json['giftContractFlag'] != null) {
		data.giftContractFlag = json['giftContractFlag'].toString();
	}
	return data;
}

Map<String, dynamic> companyInfoProductsToJson(CompanyInfoProducts entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['productNo'] = entity.productNo;
	data['contractedPrice'] = entity.contractedPrice;
	data['giftContractFlag'] = entity.giftContractFlag;
	return data;
}

companyInfoAttachesFromJson(CompanyInfoAttaches data, Map<String, dynamic> json) {
	if (json['attachType'] != null) {
		data.attachType = json['attachType'].toString();
	}
	if (json['attachUrl'] != null) {
		data.attachUrl = json['attachUrl'].toString();
	}
	return data;
}

Map<String, dynamic> companyInfoAttachesToJson(CompanyInfoAttaches entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['attachType'] = entity.attachType;
	data['attachUrl'] = entity.attachUrl;
	return data;
}