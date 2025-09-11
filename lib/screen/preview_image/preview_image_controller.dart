import 'package:note_app/base/widget/cubit/base_cubit.dart';
import 'package:note_app/screen/preview_image/preview_image_parameter.dart';
import 'package:note_app/screen/preview_image/preview_image_state.dart';

class PreviewImageController extends BaseCubit<PreviewImageState> {
  final PreviewImageParameter parameter;

  PreviewImageController({required this.parameter})
      : super(PreviewImageState(imageUrl: parameter.imageUrl));
}
