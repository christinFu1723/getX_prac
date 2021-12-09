import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:demo7_pro/dto/login_form.dart';
import 'package:demo7_pro/services/app.dart';
import 'dart:async';
import 'package:demo7_pro/utils/app.dart';
import 'package:demo7_pro/utils/validate.dart';
import 'package:demo7_pro/dao/login/login.dart';
import 'package:demo7_pro/utils/string.dart';
import 'package:demo7_pro/utils/prefers.dart';
import 'package:demo7_pro/dao/login/sms.dart';
import 'dart:convert';

class LoginController extends GetxController {
  var form =new LoginForm() .obs; // 表单object

  Timer smsCountDown; //  验证码倒计时
  final smsCountPeriod = 10; // 验证码倒计时10s
  var smsCountDownNumb = 0 .obs; // 验证码倒计时展示number

  TextEditingController phoneNumbController; // 手机号——输入框控制器
  TextEditingController smsController; // 验证码——输入框控制器
  FocusNode focusNodeMobile = FocusNode();
  FocusNode focusNodeVerifyCode = FocusNode();

  String loginSmsCount = 'login_sms_count';

  @override
  void onInit() {
    smsCountDownNumb.value = -1 ;
    phoneNumbController = TextEditingController();
    smsController = TextEditingController();
    focusNodeMobile.requestFocus();
    super.onInit();
  }

  @override
  void onClose() {
    focusNodeMobile?.dispose();
    focusNodeVerifyCode?.dispose();
    smsController.dispose();
    phoneNumbController.dispose();
    if (smsCountDown != null) {
      smsCountDown.cancel();
    }
    super.onClose();
  }

  /// 手机号输入完成回调
  Future<bool> handleLogin() async {
    try {
      focusNodeMobile.unfocus();
      focusNodeVerifyCode.unfocus();

      /// 手机号验证
      if (StringUtil.isEmpty(form.value.mobile)) throw '请填写手机号';
      if (!ValidateUtil.isMobile(form.value.mobile)) throw '请填写正确的手机号';

      /// 验证码验证
      if (StringUtil.isEmpty(form.value.sms)) throw '请填写验证码';

      AppUtil.showLoading();

      var loginInMap = await LoginIn.fetch(form.value);
      var loginInJson = loginInMap['loginInJson'];
      var loginInResp = loginInMap['loginInResp'];

      if (loginInResp['code'] == 500 || loginInResp['code'] == 404) {
        throw loginInResp['message'];
      }
      if (loginInJson != null &&
          loginInJson['tokenInfo'] != null &&
          loginInJson['tokenInfo']['access_token'] != null) {
        await AppService.setToken(
            'Bearer ${loginInJson['tokenInfo']['access_token']}');
        await PrefersUtil.set("userInfo", json.encode(loginInJson));
        Get.rootDelegate.offNamed('/');
      }
      return true;
    } catch (e) {
      focusNodeMobile.requestFocus();
      AppUtil.showToast(e);
      return false;
    } finally {
      AppUtil.hideLoading();
    }
  }

  // 请求获取验证码
  void requestAuthCode() async {
    if (smsCountDownNumb.value != null &&
        smsCountDownNumb.value > 0 &&
        smsCountDownNumb.value <= 10) {
      return;
    }
    AppUtil.showLoading();
    try {
      /// 手机号验证
      if (StringUtil.isEmpty(form.value.mobile)) throw '请填写手机号';
      if (!ValidateUtil.isMobile(form.value.mobile)) throw '请填写正确的手机号';
      await SMSRequest.fetch(form.value.mobile);
      AppUtil.showToast('短信验证码发送成功');
      focusNodeMobile.unfocus();
      focusNodeVerifyCode.unfocus();
      _initTimer();
    } catch (e) {
      AppUtil.showToast(e);
    } finally {
      AppUtil.hideLoading();
    }
  }

  // 初始化倒计时（私有成员函数）
  void _initTimer() {
    if (smsCountDownNumb.value != null &&
        smsCountDownNumb.value > 0 &&
        smsCountDownNumb.value <= smsCountPeriod) {
      return;
    }
    DateTime endAt = DateTime.now().add(Duration(seconds: smsCountPeriod));

    smsCountDownNumb.value = smsCountPeriod;

    smsCountDown = Timer.periodic(Duration(seconds: 1), (timer) {
      if (smsCountDownNumb.value <= 0) {
        timer.cancel();
        smsCountDown.cancel();
        smsCountDownNumb.value = -1;
        return;
      }

      smsCountDownNumb.value = ((endAt.millisecondsSinceEpoch -
                  DateTime.now().millisecondsSinceEpoch) /
              1000)
          .ceil(); // 除法取整
    });
  }
}
