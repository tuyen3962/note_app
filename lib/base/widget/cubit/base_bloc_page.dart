import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:note_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:note_app/base/widget/cubit/base_cubit.dart';
import 'package:note_app/base/widget/cubit/base_state.dart';
import 'package:note_app/config/theme/style/style_theme.dart';
import 'package:note_app/extension.dart';
import 'package:note_app/main.dart';
import 'package:note_app/utils/loading.dart';
import 'package:note_app/widget/appbar_custom.dart';
import 'package:note_app/widget/circle_item.dart';

abstract class BaseBlocPageState<S extends StatefulWidget, P extends BaseState,
    C extends BaseCubit<P>> extends BaseBlocViewState<S, P, C> {
  bool get isResizeToAvoidBottomInset => true;

  bool get scaleByKeyboard => false;

  final _keyboardDismissPaddingNotifier = ValueNotifier<double>(0.0);
  ValueNotifier<double> get keyboardHeightNotifier =>
      _keyboardDismissPaddingNotifier;

  Color get backgroundColor => appTheme.background;

  bool get isSafeArea => true;

  bool get showBack => true;

  String get title => '';

  bool? isTopSafeArea;
  bool? isBottomSafeArea;
  bool? isRightSafeArea;
  bool? isLeftSafeArea;

  CrossAxisAlignment get crossAxisAlignment => CrossAxisAlignment.center;
  String? get instanceName => null;

  double _bottomButtonHeight = 0;

  void setBottomButtonHeight(double value) {
    _bottomButtonHeight = value;
  }

  @override
  void initState() {
    super.initState();
    // final cubit = context.read<C>();
    // locator.registerSingleton<C>(cubit, instanceName: instanceName);
  }

  @override
  Future<bool> didPopRoute() {
    // locator.unregister<C>(
    //     instance: context.read<C>(), instanceName: instanceName);
    return super.didPopRoute();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (!mounted) return;
    if (!isResizeToAvoidBottomInset && scaleByKeyboard) {
      /// this mean keyboard appear
      if (WidgetsBinding.instance.window.viewInsets.bottom > 0) {
        Future.delayed(const Duration(milliseconds: 150)).then((value) {
          if (!mounted) return;
          final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
          _keyboardDismissPaddingNotifier.value =
              keyboardHeight + _bottomButtonHeight;
        });
      } else {
        if (!mounted) return;
        _keyboardDismissPaddingNotifier.value = 0;
        // FocusScope.of(context).unfocus();
      }
    }
  }

  bool get canPop => true;

  @override
  Widget buildView(BuildContext context, C cubit, P state) {
    return ValueListenableBuilder(
      valueListenable: _keyboardDismissPaddingNotifier,
      builder: (context, bottomPadding, child) => Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: isResizeToAvoidBottomInset,
        body: PopScope(
          canPop: canPop,
          onPopInvoked: (didPop) {
            FocusScope.of(context).unfocus();
            dismissLoading();
            if (didPop) {
              return;
            }
            handleBackEvent();
          },
          child: GestureDetector(
              onTap: FocusScope.of(context).unfocus,
              behavior: HitTestBehavior.opaque,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SafeArea(
                    left: isLeftSafeArea ?? isSafeArea,
                    right: isRightSafeArea ?? isSafeArea,
                    top: isTopSafeArea ?? isSafeArea,
                    bottom: isBottomSafeArea ?? isSafeArea,
                    child: Column(
                      crossAxisAlignment: crossAxisAlignment,
                      children: [
                        buildAppBar(context, cubit, state),
                        Expanded(
                            child: hasBackgroundBody
                                ? buildBackgroundBody(
                                    buildBody(context, cubit, state))
                                : buildBody(context, cubit, state)),
                        buildBottomView(context, cubit, state),
                        SizedBox(height: bottomPadding),
                      ],
                    ),
                  ),
                  ...buildBackgroundView(context, cubit, state),
                ],
              )),
        ),
      ),
    );
  }

  void handleBackEvent() {}

  void onBack() {
    context.maybePop();
  }

  List<Widget> buildBackgroundView(BuildContext context, C cubit, P state) =>
      [];

  bool get hasBackgroundBody => false;

  Widget buildBackgroundBody(Widget child) => SizedBox(child: child);

  Color? get backgroundAppBarColor => null;

  Color? get titleAppBarColor => null;

  bool get isBackIcon => true;

  String? getScreenTitle(C cubit, P state) => null;

  List<Widget>? appBarActions(C cubit, P state) => [];

  Widget? appBarBacKIcon(C cubit, P state) => null;

  Widget? appBarTitle(C cubit, P state) => null;

  Widget buildAppBar(BuildContext context, C cubit, P state) {
    final appbar = AppBarCustom(
      title: getScreenTitle.call(cubit, state) ?? title,
      showBack: showBack,
      onBack: onBack,
      titleView: appBarTitle(cubit, state),
      actions: appBarActions(cubit, state),
      backIcon: appBarBacKIcon(cubit, state),
      isBackIcon: isBackIcon,
      backColor: titleAppBarColor,
      backgroundColor: backgroundAppBarColor,
      titleStyle: AppStyle.bold18(color: titleAppBarColor),
    );
    if (isTopSafeArea == false || isSafeArea == false) {
      return Container(
        color: backgroundAppBarColor ?? appTheme.whiteText,
        child: SafeArea(bottom: false, child: appbar),
      );
    }

    return appbar;
  }

  Widget buildBody(BuildContext context, C cubit, P state) => Container();

  Widget buildBottomView(BuildContext context, C cubit, P state) =>
      const SizedBox();
}

abstract class BaseBlocNoAppBarPageState<
    S extends StatefulWidget,
    P extends BaseState,
    C extends BaseCubit<P>> extends BaseBlocPageState<S, P, C> {
  @override
  Widget buildAppBar(BuildContext context, C cubit, P state) =>
      const SizedBox();
}

abstract class BaseBlocPrimaryAppBarPageState<
    S extends StatefulWidget,
    P extends BaseState,
    C extends BaseCubit<P>> extends BaseBlocPageState<S, P, C> {
  @override
  Color? get titleAppBarColor => appTheme.whiteText;
  @override
  Color get backgroundColor => appTheme.whiteText;
  @override
  Color? get backgroundAppBarColor => appTheme.primaryColor;
  @override
  bool? get isTopSafeArea => false;

  @override
  Widget? appBarBacKIcon(C cubit, P state) {
    return CircleItem(
        onTap: onBack,
        padding: padding(all: 6),
        backgroundColor: appTheme.whiteText.withOpacity(.16),
        child: Icon(Icons.arrow_back_ios_new_rounded,
            color: appTheme.whiteText, size: 20));
  }
}

// abstract class BaseBlocInDevelopmentPageState<
//     S extends StatefulWidget,
//     P extends BaseState,
//     C extends BaseCubit<P>> extends BaseBlocNoAppBarPageState<S, P, C> {
//   @override
//   Widget buildBody(BuildContext context, C cubit, P state) {
//     return SizedBox(
//       width: double.infinity,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Assets.illustrators.signIn.svg(height: 100, width: 100),
//           SizedBox(height: 12.h),
//           Text(LocaleKeys.feature_coming_soon.tr(), style: AppStyle.medium16()),
//         ],
//       ),
//     );
//   }
// }
