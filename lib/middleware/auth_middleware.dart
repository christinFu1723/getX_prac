import 'package:get/get.dart';

import 'package:demo7_pro/services/app.dart';

class EnsureAuthMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig> redirectDelegate(GetNavConfig route) async {
    // you can do whatever you want here
    // but it's preferable to make this method fast
    // await Future.delayed(Duration(milliseconds: 500));

    var token = await AppService.getToken();
    if (token == null) {
      await AppService.clearPrefers();
      final newRoute = '/login';
      return GetNavConfig.fromRoute(newRoute);
    }

    return await super.redirectDelegate(route);
  }
}

class EnsureNotAuthedMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig> redirectDelegate(GetNavConfig route) async {
    var token = await AppService.getToken();
    if (token!=null) {
      //NEVER navigate to auth screen, when user is already authed
      return null;

      //OR redirect user to another screen
      //return GetNavConfig.fromRoute(Routes.PROFILE);
    }
    return await super.redirectDelegate(route);
  }
}
