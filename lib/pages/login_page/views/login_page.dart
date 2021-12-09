import 'package:flutter/material.dart';
import 'package:demo7_pro/config/theme.dart';
import 'package:flutter/services.dart';
import 'package:demo7_pro/widgets/version.dart';
import 'package:demo7_pro/widgets/swiper_button.dart';
import 'package:demo7_pro/pages/login_page/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  Widget build(BuildContext context) {
    return Scaffold(body: loginPageBody(context));
  }

  Widget loginPageBody(BuildContext context) {
    print('context:$context');
    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: AppTheme.backgroundDefaultColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _appInfoBlock(),
                _loginInForm(context),
                _swiperButtonCtn(),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 125.5, 0, 30),
                  child: VersionTip(
                      logoTitle: '文立APP',
                      versionTips: '和我一起去炸鱼吧！可莉，想回家了！嘟嘟可大魔王，我来接受你的挑战',
                      version: '1.0.0'),
                )
              ],
            ),
          ),
        ));
  }

  Widget _swiperButtonCtn() {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.fromLTRB(60, 58, 60, 22),
        child: SwiperButton(
          size: 40,
          placeholder: '滑动进入下一步',
          onSwiperStart: () {
            // 手机号输入失去焦点
            controller.focusNodeMobile.unfocus();
          },
          onSwiperValidate: controller.handleLogin,
        ),
      ),
      onTap: () {
        controller.focusNodeMobile.unfocus();
        controller.focusNodeVerifyCode.unfocus();
      },
    );
  }

  Widget _loginInForm(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(17, 58, 17, 22),
          child: _loginSpecialInput(Icons.person,
              focusNode: controller.focusNodeMobile,
              hint: '请填写您的手机号',
              maxLength: 11,
              controller: controller.phoneNumbController, onChange: (val) {
            controller.form.value.mobile = val;
          }, onClear: () {
            controller.form.value.mobile = '';
            controller.phoneNumbController.clear();
          }),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(17, 0, 17, 22),
          child: _loginSpecialInput(Icons.verified_user,
              showClear: true,
              showSmsBtn: true,
              focusNode: controller.focusNodeVerifyCode,
              context: context,
              maxLength: 6,
              hint: '请填写手机验证码',
              controller: controller.smsController, onChange: (val) {
            controller.form.value.sms = val;
          }, onClear: () {
            controller.form.value.sms = '';
            controller.smsController.clear();
          }),
        )
      ],
    );
  }

  Widget _loginSpecialInput(IconData iconData,
      {@required TextEditingController controller,
      @required Function onChange,
      @required Function onClear,
      @required BuildContext context,
      showClear = true,
      showSmsBtn = false,
      maxLength = 10,
      FocusNode focusNode,
      hint = '请填写'}) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        child: Container(
          color: Color(0xffffffff),
          padding: EdgeInsets.fromLTRB(17, 0, 17, 0),
          child: Row(
            children: [
              Icon(
                iconData,
                color: AppTheme.placeholderColor,
                size: 20,
              ),
              Expanded(
                  child: TextField(
                focusNode: focusNode,
                controller: controller,
                textAlign: TextAlign.left,
                cursorColor: Get.context.theme.primaryColor,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(maxLength),
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    filled: true,
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: TextStyle(
                        color: AppTheme.placeholderColor,
                        fontSize: AppTheme.fontSizeSecond)),
                onChanged: (String val) {
                  onChange(val);
                },
              )),
              showClear
                  ? (GestureDetector(
                      onTap: () {
                        onClear();
                      },
                      child: Icon(
                        Icons.close,
                        color: AppTheme.placeholderColor,
                        size: 16,
                      ),
                    ))
                  : Container(),
              showSmsBtn ? _smsButton() : Container()
            ],
          ),
        ));
  }

  Widget _smsButton() {
    return Padding(
        padding: EdgeInsets.only(left: 10),
        child: Obx(() => ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: !(controller.smsCountDownNumb.value == null ||
                          controller.smsCountDownNumb.value >= 0 &&
                              controller.smsCountDownNumb.value <= 10)
                      ? AppTheme.primaryColor
                      : AppTheme.lightTextColor,
                  onPrimary: Colors.white,
                  minimumSize: Size(60, 30),
                  textStyle: TextStyle(fontSize: 16),
                  padding: EdgeInsets.fromLTRB(13, 6, 13, 7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  )),
              onPressed: () {
                controller.requestAuthCode();
              },
              child: _buttonLoadingChild(),
            )));
  }

  Widget _buttonLoadingChild() {
    return Obx(() => controller.smsCountDownNumb.value >= 0 &&
            controller.smsCountDownNumb.value <= 10
        ? (Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: SizedBox(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                  width: AppTheme.fontSizeSmall,
                  height: AppTheme.fontSizeSmall,
                ),
              ),
              Text(
                '${controller.smsCountDownNumb.value} s',
                style: TextStyle(
                    fontSize: AppTheme.fontSizeSmall, color: Colors.white),
              )
            ],
          ))
        : (Text(
            '获取短信验证码',
            style: TextStyle(
                fontSize: AppTheme.fontSizeSmall, color: Colors.white),
          )));
  }

  Widget _appInfoBlock() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 58, 0, 33),
          child: Icon(
            Icons.flight,
            color: AppTheme.primaryColor,
            size: 60,
          ),
        ),
        Text(
          '文立测试APP',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.only(top: 6)),
        Text(
          'DingDang Customer Relationship Management',
          style: TextStyle(
            fontSize: AppTheme.fontSizeSmall,
            fontWeight: FontWeight.bold,
            color: AppTheme.lightTextColor,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        Text(
          '高效 · 安全 · 合规',
          style: TextStyle(
              fontSize: AppTheme.fontSizeSecond, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
