import 'package:flutter/material.dart';

import 'package:demo7_pro/widgets/title.dart' show TitleSpan;
import 'package:demo7_pro/config/theme.dart' show AppTheme;
import 'package:demo7_pro/utils/validate.dart' show ValidateUtil;
import 'package:demo7_pro/model/company_info_entity.dart'
    show CompanyInfoEntity,CompanyInfoAttaches;
import 'package:demo7_pro/generated/json/base/json_convert_content.dart'
    show JsonConvert;
import 'package:logger/logger.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:demo7_pro/utils/time.dart' show TimeUtil;
import 'package:demo7_pro/widgets/common/input.dart' show InputForm;
import 'package:demo7_pro/widgets/common/input_decoration.dart'
    show InputStyleDecoration;
import 'package:demo7_pro/widgets/common/img_upload_decorator.dart';

class CompanyInfoSubmit extends StatefulWidget {
  final Function onNextStep;
  final CompanyInfoEntity form;
  final bool isDetail;

  @override
  CompanyInfoSubmit({Key key, this.onNextStep, this.form, this.isDetail})
      : super(key: key);

  @override
  _CompanyInfoSubmitState createState() => _CompanyInfoSubmitState();
}

class _CompanyInfoSubmitState extends State<CompanyInfoSubmit>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController organizeNameController;
  TextEditingController organizeSocialCodeController;
  TextEditingController legalNameController;
  TextEditingController legalIdCardNoController;
  TextEditingController legalMobileController;
  TextEditingController organizeRegisteredCapitalController;
  TextEditingController organizeRegisteredTimeController;
  TextEditingController organizeAddressController;
  TextEditingController contactController;
  TextEditingController contactMobileController;
  TextEditingController contactAddressController;
  TextEditingController attachesController;
  CompanyInfoEntity form;
  List<String> initImgsShow;

  @override
  bool get wantKeepAlive => true; // 防止页面tab切换以后，页面重绘

  @override
  initState() {
    form = widget.form;

    initImgsShow = this.initImgUploadData(form?.applyAttaches) ?? [];
    organizeNameController = TextEditingController();
    organizeSocialCodeController = TextEditingController();
    legalNameController = TextEditingController();
    legalIdCardNoController = TextEditingController();
    legalMobileController = TextEditingController();
    organizeRegisteredCapitalController = TextEditingController();
    organizeRegisteredTimeController = TextEditingController();
    organizeAddressController = TextEditingController();
    contactController = TextEditingController();
    contactMobileController = TextEditingController();
    contactAddressController = TextEditingController();
    attachesController = TextEditingController();
    super.initState();
  }

  @override
  didUpdateWidget(CompanyInfoSubmit oldWidget) {
    print('子组件更新');

    form = widget.form;

    initImgsShow = this.initImgUploadData(form?.applyAttaches) ?? [];
    print('查看${form?.toJson()}');
    super.didUpdateWidget(oldWidget);
  }

  @override
  dispose() {
    organizeNameController?.dispose();
    organizeSocialCodeController?.dispose();
    legalNameController?.dispose();
    legalIdCardNoController?.dispose();
    legalMobileController?.dispose();
    organizeRegisteredCapitalController?.dispose();
    organizeRegisteredTimeController?.dispose();
    organizeAddressController?.dispose();
    contactController?.dispose();
    contactMobileController?.dispose();
    contactAddressController?.dispose();
    attachesController?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    print('子组件渲染${form?.toJson()}');
    return SizedBox(
      child: Form(
        child: Column(
          children: [
            _companyInfoForm(),
            _certificateForm(),
            _contactInfoForm(),
            _nextBtn(),
          ],
        ),
      ),
    );
  }

  Widget _nextBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          if (form.validateCompanyBaseInfo()) {
            widget.onNextStep.call();
          }
        },
        child: const Text('下一步'),
      ),
    );
  }

  Widget _companyInfoForm() {
    return Column(children: [
      TitleSpan(title: '企业信息'),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      ),
      Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: Column(
          children: [
            InputStyleDecoration(
              '企业名称',
              InputForm(
                  readOnly: widget.isDetail,
                  controller: organizeNameController,
                  initVal: form?.organizeName,
                  validatorFn: (
                    String value,
                  ) {
                    return _inputValidate(value,
                        validateType: '', errMsg: '请输入企业名称');
                  },
                  onChange: (String value) {
                    // organizeNameController.text = value;
                    form.organizeName = value;
                  },
                  hintStr: '请输入企业名称',
                  maxLength: 10),
              showRequireFlg: true,
            ),
            InputStyleDecoration(
              '社会统一信用代码',
              InputForm(
                  readOnly: widget.isDetail,
                  controller: organizeSocialCodeController,
                  initVal: form?.organizeSocialCode,
                  validatorFn: (
                    String value,
                  ) {
                    return _inputValidate(value,
                        validateType: '', errMsg: '请输入社会统一信用代码');
                  },
                  onChange: (String value) {
                    // organizeSocialCodeController.text = value;
                    form.organizeSocialCode = value;
                  },
                  hintStr: '请输入社会统一信用代码',
                  maxLength: 20),
              showRequireFlg: true,
            ),
            InputStyleDecoration(
              '法定代表人',
              InputForm(
                  readOnly: widget.isDetail,
                  controller: legalNameController,
                  initVal: form?.legalName,
                  validatorFn: (
                    String value,
                  ) {
                    return _inputValidate(value,
                        validateType: '', errMsg: '请输入法定代表人');
                  },
                  onChange: (String value) {
                    // legalNameController.text = value;
                    form.legalName = value;
                  },
                  hintStr: '请输入法定代表人',
                  maxLength: 10),
              showRequireFlg: true,
            ),
            InputStyleDecoration(
              '法人手机号',
              InputForm(
                  readOnly: widget.isDetail,
                  controller: legalMobileController,
                  initVal: form?.legalMobile,
                  validatorFn: (
                    String value,
                  ) {
                    return _inputValidate(value,
                        validateType: 'mobile', errMsg: '请输入法人手机号');
                  },
                  onChange: (String value) {
                    // legalMobileController.text = value;
                    form.legalMobile = value;
                  },
                  hintStr: '请输入法人手机号',
                  maxLength: 11,
                  keyboardType: TextInputType.phone),
              showRequireFlg: true,
            ),
            InputStyleDecoration(
              '法人身份证号',
              InputForm(
                readOnly: widget.isDetail,
                controller: legalIdCardNoController,
                initVal: form?.legalIdCardNo,
                validatorFn: (
                  String value,
                ) {
                  return _inputValidate(value,
                      validateType: 'id', errMsg: '请输入法人身份证号');
                },
                onChange: (String value) {
                  // legalIdCardNoController.text = value;
                  form.legalIdCardNo = value;
                },
                hintStr: '请输入法人身份证号',
                maxLength: 20,
              ),
              showRequireFlg: true,
            ),
            InputStyleDecoration(
                '注册资本',
                InputForm(
                    readOnly: widget.isDetail,
                    controller: organizeRegisteredCapitalController,
                    initVal: form?.organizeRegisteredCapital,
                    validatorFn: (
                      String value,
                    ) {
                      return _inputValidate(value,
                          validateType: '', errMsg: '请输入注册资本');
                    },
                    onChange: (String value) {
                      // organizeRegisteredCapitalController.text = value;
                      form.organizeRegisteredCapital = value;
                    },
                    hintStr: '请输入注册资本',
                    maxLength: 8,
                    keyboardType: TextInputType.number),
                showRequireFlg: true,
                extendsWidget: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      '万元',
                      style: TextStyle(
                          fontSize: AppTheme.fontSizeSmall,
                          color: AppTheme.titleColor),
                    ))),
            InputStyleDecoration(
                '注册时间',
                InputForm(
                  readOnly: widget.isDetail,
                  controller: organizeRegisteredTimeController,
                  initVal: form?.organizeRegisteredTime,
                  validatorFn: (
                    String value,
                  ) {
                    return _inputValidate(value,
                        validateType: 'mobile', errMsg: '请输入注册时间');
                  },
                  onTap: () async {
                    if (widget.isDetail) {
                      return;
                    }
                    Logger().i(form.organizeRegisteredTime != null
                        ? DateTime.parse(form.organizeRegisteredTime)
                        : DateTime.now());
                    DateTime newDateTime = await showRoundedDatePicker(
                      context: context,
                      locale: Locale("zh", "CN"),
                      initialDate: form.organizeRegisteredTime != null
                          ? DateTime.parse(form.organizeRegisteredTime)
                          : DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                      borderRadius: 16,
                    );

                    var dateStr = TimeUtil.DateTime2YMD(newDateTime);
                    organizeRegisteredTimeController.text = dateStr;
                    form.organizeRegisteredTime = dateStr;
                  },
                  onChange: (String value) {},
                  hintStr: '请输入注册时间',
                ),
                showRequireFlg: true,
                extendsWidget: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(Icons.date_range_sharp))),
            InputStyleDecoration(
                '注册地址',
                InputForm(
                    readOnly: widget.isDetail,
                    controller: organizeAddressController,
                    initVal: form?.organizeAddress,
                    validatorFn: (
                      String value,
                    ) {
                      return _inputValidate(value,
                          validateType: '', errMsg: '请输入注册地址');
                    },
                    onChange: (String value) {
                      // organizeAddressController.text = value;
                      form.organizeAddress = value;
                    },
                    hintStr: '请输入注册地址',
                    maxLength: 30),
                showRequireFlg: true,
                isLastChild: true),
          ],
        ),
      )
    ]);
  }

  Widget _contactInfoForm() {
    return Column(children: [
      Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      ),
      TitleSpan(title: '联系人信息'),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      ),
      Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: Column(
          children: [
            InputStyleDecoration(
              '联系人',
              InputForm(
                  readOnly: widget.isDetail,
                  controller: contactController,
                  initVal: form?.contact,
                  validatorFn: (
                    String value,
                  ) {
                    return _inputValidate(value,
                        validateType: '', errMsg: '请输入联系人');
                  },
                  onChange: (String value) {
                    // contactController.text = value;
                    form.contact = value;
                  },
                  hintStr: '请输入联系人',
                  maxLength: 10),
              showRequireFlg: true,
            ),
            InputStyleDecoration(
              '联系人手机号',
              InputForm(
                  readOnly: widget.isDetail,
                  controller: contactMobileController,
                  initVal: form?.contactMobile,
                  validatorFn: (
                    String value,
                  ) {
                    return _inputValidate(value,
                        validateType: 'mobile', errMsg: '请输入联系人手机号');
                  },
                  onChange: (String value) {
                    // contactMobileController.text = value;
                    form.contactMobile = value;
                  },
                  hintStr: '请输入联系人手机号',
                  maxLength: 11,
                  keyboardType: TextInputType.phone),
              showRequireFlg: true,
            ),
            InputStyleDecoration(
                '联系地址',
                InputForm(
                    readOnly: widget.isDetail,
                    controller: contactAddressController,
                    initVal: form?.contactAddress,
                    validatorFn: (
                      String value,
                    ) {
                      return '';
                    },
                    onChange: (String value) {
                      // contactAddressController.text = value;
                      form.contactAddress = value;
                    },
                    hintStr: '请输入联系地址',
                    maxLength: 30),
                isLastChild: true),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
      ),
    ]);
  }

  Widget _certificateForm() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        ),
        TitleSpan(title: '证照信息'),
        // Padding(
        //   padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        // ),
        ImgUploadDecorator(
            readOnly: widget.isDetail,
            maxLength: 1,
            initImgList: initImgsShow,
            imgListUploadCallback: handleImgChange),
      ],
    );
  }

  List<String> initImgUploadData(List attaches) {
    List<String> arr = [];
    if (attaches != null) {
      for (var item in attaches) {
        if (item.attachUrl != '' && item.attachUrl is String) {
          arr.add(item.attachUrl);
        }
      }
    }

    return arr;
  }

  void handleImgChange(List<String> imgs) {
    List<CompanyInfoAttaches> saveAttachesArr = [];
    var obj;
    if (imgs != null && imgs.length >= 1) {
      obj = {
        'attachType': '1001',
        'attachUrl': imgs[0],
      };
      saveAttachesArr.add(JsonConvert.fromJsonAsT(obj));
    }

    form.attaches = saveAttachesArr;
    Logger().i('传回来的照片: ${form.attaches}');
    Logger().i('传回来的照片: ${form.toJson()}');
  }

  String _inputValidate(String value,
      {@required String validateType, @required String errMsg}) {
    switch (validateType) {
      case 'mobile':
        if (!ValidateUtil.isMobile(value)) {
          return errMsg;
        }
        break;
      case 'id':
        if (!ValidateUtil.isIdCard(value)) {
          return errMsg;
        }
        break;
      default:
        if (value == '' || value == null) {
          return errMsg;
        }
        break;
    }
    return '';
  }
}
