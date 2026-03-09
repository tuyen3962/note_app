import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/config/theme/style/app_style.dart';
import 'package:note_app/main.dart';
import 'package:note_app/utils/loading.dart';
import 'package:note_app/widget/appbar_custom.dart';

import 'cubit/base_bloc_provider.dart';
import 'cubit/base_cubit.dart';
import 'cubit/base_state.dart';

abstract class BaseBlocPageState<S extends StatefulWidget, P extends BaseState,
    C extends BaseCubit<P>> extends BaseBlocViewState<S, P, C> {
  bool get isResizeToAvoidBottomInset => true;

  bool get scaleByKeyboard => true;

  final _keyboardDismissPaddingNotifier = ValueNotifier<double>(0.0);
  ValueNotifier<double> get keyboardHeightNotifier =>
      _keyboardDismissPaddingNotifier;

  // This field validate the user in the group of univini
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

  C get cubit {
    if (context.mounted) {
      return context.read<C>();
    } else {
      throw Exception('context is not mounted');
    }
  }

  void setBottomButtonHeight(double value) {
    _bottomButtonHeight = value;
  }

  void unfocusNode(PointerDownEvent event) {
    if (!mounted) return;
    FocusScope.of(context).unfocus();
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
      }
    }
  }

  bool get canPop => true;

  bool get showAppName => true;

  Color get pageBackgroundColor => backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _keyboardDismissPaddingNotifier,
      builder: (context, bottomPadding, child) => GestureDetector(
        onTap: () => unfocusNode(const PointerDownEvent()),
        behavior: HitTestBehavior.deferToChild,
        child: Scaffold(
          backgroundColor: pageBackgroundColor,
          resizeToAvoidBottomInset: isResizeToAvoidBottomInset,
          body: PopScope(
            canPop: canPop,
            onPopInvokedWithResult: (didPop, result) {
              unfocusNode(const PointerDownEvent());
              onPopInvoke();
              dismissLoading();
              if (didPop) {
                return;
              }
              handleBackEvent();
            },
            child: TapRegion(
                onTapInside: (_) {
                  if (FocusScope.of(context).hasFocus) {
                    return;
                  }
                  unfocusNode(_);
                },
                behavior: HitTestBehavior.opaque,
                child: SafeArea(
                  left: isLeftSafeArea ?? isSafeArea,
                  right: isRightSafeArea ?? isSafeArea,
                  top: isTopSafeArea ?? isSafeArea,
                  bottom: isBottomSafeArea ?? isSafeArea,
                  child: Column(
                    crossAxisAlignment: crossAxisAlignment,
                    children: [
                      GestureDetector(
                          onTap: FocusScope.of(context).unfocus,
                          child: buildAppBar(context)),
                      Expanded(child: buildBody(context)),
                      buildBottomView(context),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Widget blocBuilder({
    required Widget Function(BuildContext context, P state) viewBuilder,
    bool Function(P previous, P current)? buildWhen,
  }) {
    return BlocBuilder<C, P>(
        buildWhen: buildWhen, bloc: cubit, builder: viewBuilder);
  }

  Widget blocConsumer(
      {required Widget Function(BuildContext context, P state) viewBuilder,
      required void Function(BuildContext context, P state) listener,
      bool Function(P previous, P current)? listenWhen,
      bool Function(P previous, P current)? buildWhen}) {
    return BlocConsumer<C, P>(
        bloc: cubit,
        builder: viewBuilder,
        listener: listener,
        buildWhen: buildWhen,
        listenWhen: listenWhen);
  }

  void onPopInvoke() {}

  void handleBackEvent() {}

  void onBack() {
    if (context.mounted) {
      Navigator.of(context).maybePop();
    }
  }

  Color? get backgroundAppBarColor => null;

  Color? get titleAppBarColor => null;

  bool get isBackIcon => true;

  Widget buildAppBar(BuildContext context) {
    final appbar = AppBarCustom(
      title: title,
      showBack: showBack,
      onBack: onBack,
      isBackIcon: isBackIcon,
      backColor: titleAppBarColor,
      backgroundColor: backgroundAppBarColor,
      titleStyle: AppStyle.style.bold(size: 18, color: titleAppBarColor),
    );
    if (isTopSafeArea == false || isSafeArea == false) {
      return Container(
        color: backgroundAppBarColor ?? appTheme.background,
        child: SafeArea(bottom: false, child: appbar),
      );
    }

    return appbar;
  }

  Widget buildBody(BuildContext context) => Container();

  Widget buildBottomView(BuildContext context) => const SizedBox();
}

abstract class BaseBlocNoAppBar<S extends StatefulWidget, P extends BaseState,
        C extends BaseCubit<P>> extends BaseBlocPageState<S, P, C>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> opacityAnimation;

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    animationController.value = scrollController.offset / 100;
  }

  @override
  void dispose() {
    animationController.dispose();
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  List<Widget> buildBackgroundView(BuildContext context) => [
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: opacityAnimation,
              builder: (context, child) => Opacity(
                  opacity: opacityAnimation.value,
                  child: Container(
                      height: MediaQuery.of(context).padding.top,
                      color: appTheme.background,
                      width: double.infinity)),
            )),
      ];
}
