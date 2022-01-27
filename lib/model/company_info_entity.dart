import 'package:demo7_pro/generated/json/base/json_convert_content.dart';
import 'package:demo7_pro/utils/app.dart' show AppUtil;
import 'package:demo7_pro/utils/validate.dart' show ValidateUtil;
import 'package:demo7_pro/utils/string.dart' show StringUtil;
import 'package:logger/logger.dart';

class CompanyInfoEntity with JsonConvert<CompanyInfoEntity> {
  String organizeNo;
  String organizeName;
  String organizeSocialCode;
  String legalName;
  String legalIdCardNo;
  String legalMobile;
  String organizeRegisteredCapital;
  String organizeRegisteredTime;
  String organizeAddress;
  String contact;
  String contactMobile;
  String contactAddress;
  String organizeAccountName;
  String organizeAccountMobile;
  String position;
  String effectiveDate;
  String expireDate;
  String subAccountNum;

  List<CompanyInfoProducts> products;
  List<CompanyInfoProducts> signProducts;
  List<CompanyInfoAttaches> applyAttaches;
  List<CompanyInfoAttaches> attaches;


  bool validateCompanyBaseInfo() {
    try {
      var errorMsg = '';
      if (StringUtil.isEmpty(this.organizeName)) {
        errorMsg += '企业名称,';
      }
      if (StringUtil.isEmpty(this.organizeSocialCode)) {
        errorMsg += '信用代码,';
      }
      if (StringUtil.isEmpty(this.legalName)) {
        errorMsg += '法人,';
      }
      if (!ValidateUtil.isMobile(this.legalMobile)) {
        errorMsg += '法人手机号,';
      }

      if (!ValidateUtil.isIdCard(this.legalIdCardNo)) {
        errorMsg += '法人身份证,';
      }
      if (!ValidateUtil.isPrice(this.organizeRegisteredCapital)) {
        errorMsg += '注册资本(最多支持2位小数),';
      }
      if (StringUtil.isEmpty(this.organizeRegisteredTime)) {
        errorMsg += '注册时间,';
      }
      if (StringUtil.isEmpty(this.organizeAddress)) {
        errorMsg += '注册地址,';
      }
      if (StringUtil.isEmpty(this.contact)) {
        errorMsg += '联系人,';
      }
      if (!ValidateUtil.isMobile(this.contactMobile)) {
        errorMsg += '联系人电话,';
      }
      if (StringUtil.isEmpty(this.organizeName)) {
        errorMsg += '企业名称,';
      }
      if (!ValidateUtil.verifyObjArrFilled(
          arr: this.attaches, key: 'attachUrl',isObject:true)) {
        errorMsg += '证照信息,';
      }

      if (errorMsg != '') {
        errorMsg = '请正确填写：' + errorMsg;
        errorMsg = StringUtil.spliceChar(errorMsg, ',');
        throw errorMsg;
      }
      return true;
    } catch (e) {
      AppUtil.showToast(e);
      return false;
    }
  }

  bool validateAccount() {
    try {
      var errorMsg = '';
      if (StringUtil.isEmpty(this.organizeAccountName)) {
        errorMsg += '管理员账号姓名,';
      }
      if (!ValidateUtil.isMobile(this.organizeAccountMobile)) {
        errorMsg += '管理员手机号,';
      }

      if (errorMsg != '') {
        errorMsg = '请正确填写：' + errorMsg;
        errorMsg = StringUtil.spliceChar(errorMsg, ',');
        throw errorMsg;
      }
      return true;
    } catch (e) {
      AppUtil.showToast(e);
      return false;
    }
  }

  bool validatePackagesChoose() {
    try {
      var errorMsg = '';
      if (this.effectiveDate != null && this.expireDate != null) {
        bool effectiveDateFlg = DateTime.tryParse(this.effectiveDate) != null;
        bool expireDateFlg = DateTime.tryParse(this.expireDate) != null;

        if (!effectiveDateFlg) {
          errorMsg += '合同起始日期,';
        }
        if (!expireDateFlg) {
          errorMsg += '合同终止日期,';
        }
        if (effectiveDateFlg &&
            expireDateFlg &&
            DateTime.parse(this.expireDate).millisecondsSinceEpoch <
                DateTime.parse(this.effectiveDate).millisecondsSinceEpoch) {
          errorMsg += '合同终止日期应大于起始日期,';
        }
      } else {
        if (StringUtil.isEmpty(this.effectiveDate)) {
          errorMsg += '合同起始日期,';
        }
        if (StringUtil.isEmpty(this.expireDate)) {
          errorMsg += '合同终止日期,';
        }
      }

      if (this.products != null && this.products.length > 0) {
        for (var item in this.products) {
          if (!StringUtil.isEmpty(item.productNo) &&
              !StringUtil.isEmpty(item.giftContractFlag) &&
              !ValidateUtil.isPrice(item.contractedPrice)) {
            errorMsg += '套餐价格,';
          }
        }
      } else {
        errorMsg += '套餐,';
      }

      if (errorMsg != '') {
        errorMsg = '请正确填写：' + errorMsg;
        errorMsg = StringUtil.spliceChar(errorMsg, ',');
        throw errorMsg;
      }
      return true;
    } catch (e) {
      Logger().e(e);
      AppUtil.showToast(e);
      return false;
    }
  }
}

class CompanyInfoProducts with JsonConvert<CompanyInfoProducts> {
  String productNo;
  String contractedPrice;
  String giftContractFlag;
}

class CompanyInfoAttaches with JsonConvert<CompanyInfoAttaches> {
  String attachType;
  String attachUrl;
}
