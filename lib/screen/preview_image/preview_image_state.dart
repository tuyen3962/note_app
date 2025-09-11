// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:note_app/base/widget/cubit/base_state.dart';

class PreviewImageState extends BaseState {
  final String imageUrl;
  PreviewImageState({
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [imageUrl];

  PreviewImageState copyWith({
    String? imageUrl,
  }) {
    return PreviewImageState(
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
