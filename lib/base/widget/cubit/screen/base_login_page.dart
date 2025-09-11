import 'package:flutter/material.dart';
import 'package:note_app/base/widget/cubit/base_bloc_page.dart';
import 'package:note_app/base/widget/cubit/base_cubit.dart';
import 'package:note_app/base/widget/cubit/base_state.dart';

abstract class BaseLoginBlocPageState<
    S extends StatefulWidget,
    P extends BaseState,
    C extends BaseCubit<P>> extends BaseBlocPageState<S, P, C> {
  @override
  Widget buildAppBar(BuildContext context, C cubit, P state) {
    return super.buildAppBar(context, cubit, state);
  }

  @override
  bool get hasBackgroundBody => true;

  @override
  Widget buildBackgroundBody(Widget child) {
    return super.buildBackgroundBody(child);
  }
}
