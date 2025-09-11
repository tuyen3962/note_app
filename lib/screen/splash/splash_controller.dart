import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:note_app/base/widget/base_controller.dart';
import 'package:note_app/config/service/account_service.dart';
import 'package:note_app/config/service/app_service.dart';
import 'package:note_app/router/app_route.dart';

class SplashController extends BaseController {
  late final AccountService accountService = locator.get();
  final isScale = ValueNotifier<bool>(false);

  SplashController(super.state) {
    Future.delayed(const Duration(milliseconds: 100))
        .then((value) => isScale.value = true);
    initService();
  }

  initService() async {
    await Future.delayed(const Duration(seconds: 1))
        .then((value) => goToOnboardingPage());
  }

  goToOnboardingPage() {
    context.replaceRoute(const HomeRoute());
  }

  @override
  List<ValueNotifier> get notifiers => [isScale];
}
