import 'package:note_app/base/stream/base_stream_controller.dart';
import 'package:note_app/config/theme/style/style_theme.dart';

enum FontStyle {
  mali,
  handlee,
  justAnotherHand,
  licorice,
  meowScript,
  miniver,
  nanumBrushScript,
  niconne,
  norican,
  sendFlowers,
  pacifico
}

class AppStyle {
  static final _currentFontStyle = BaseStreamController<BaseFontStyle>(
      BaseFontStyle(fontFamily: FontStyle.mali.fontFamily));

  final defaultFontStyle = 'Mali';

  static BaseFontStyle get style => _currentFontStyle.value;

  static void setFontStyle(FontStyle fontStyle) {
    _currentFontStyle.value = BaseFontStyle(fontFamily: fontStyle.fontFamily);
  }
}

extension FontStyleExtension on FontStyle {
  String get fontFamily => switch (this) {
        FontStyle.mali => 'Mali',
        FontStyle.handlee => 'Handlee',
        FontStyle.justAnotherHand => 'JustAnotherHand',
        FontStyle.licorice => 'Licorice',
        FontStyle.meowScript => 'MeowScript',
        FontStyle.miniver => 'Miniver',
        FontStyle.nanumBrushScript => 'NanumBrushScript',
        FontStyle.niconne => 'Niconne',
        FontStyle.norican => 'Norican',
        FontStyle.sendFlowers => 'SendFlowers',
        FontStyle.pacifico => 'Pacifico',
      };
}
