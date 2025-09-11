import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:note_app/base/widget/cubit/base_bloc_page.dart';
import 'package:note_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:note_app/extension.dart';
import 'package:note_app/main.dart';
import 'package:note_app/screen/preview_image/preview_image_controller.dart';
import 'package:note_app/screen/preview_image/preview_image_parameter.dart';
import 'package:note_app/screen/preview_image/preview_image_state.dart';

@RoutePage()
class PreviewImagePage extends BaseBlocProviderParameter<PreviewImageState,
    PreviewImageController, PreviewImageParameter> {
  const PreviewImagePage({required super.parameter, super.key});

  @override
  Widget buildPageWithParam(PreviewImageParameter param) {
    return PreviewImageView();
  }

  @override
  PreviewImageController createCubitWithParam(PreviewImageParameter param) =>
      PreviewImageController(parameter: param);
}

class PreviewImageView extends StatefulWidget {
  const PreviewImageView({super.key});

  @override
  State<PreviewImageView> createState() => _PreviewImageViewState();
}

class _PreviewImageViewState extends BaseBlocPageState<PreviewImageView,
    PreviewImageState, PreviewImageController> {
  @override
  Widget buildBody(BuildContext context, PreviewImageController cubit,
      PreviewImageState state) {
    return Stack(
      children: [
        Image.asset(
          state.imageUrl,
          width: double.infinity,
          height: double.infinity,
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomPreviewButton())
      ],
    );
  }

  _buildBottomPreviewButton() {
    return Container(
      color: appTheme.blackColor,
      padding: padding(all: 12),
      child: SafeArea(
        left: false,
        right: false,
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                onTap: () => context.maybePop(false),
                child: Icon(Icons.close, color: appTheme.whiteText, size: 32)),
            GestureDetector(
                onTap: () => context.maybePop(true),
                child: Icon(Icons.check, color: appTheme.whiteText, size: 32)),
          ],
        ),
      ),
    );
  }
}
