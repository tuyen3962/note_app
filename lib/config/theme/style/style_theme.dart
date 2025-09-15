import 'package:flutter/material.dart';
import 'package:note_app/main.dart';

class BaseFontStyle {
  final String fontFamily;

  BaseFontStyle({required this.fontFamily});

  TextStyle regular(
          {Color? color,
          double? size,
          double? lineHeight,
          double? letterSpacing}) =>
      _baseStyle(
          size: size,
          fontWeight: FontWeight.w400,
          color: color,
          letterSpacing: letterSpacing,
          lineHeight: lineHeight);

  TextStyle semiBold(
          {Color? color,
          double? size,
          double? lineHeight,
          double? letterSpacing}) =>
      _baseStyle(
          size: size,
          fontWeight: FontWeight.w600,
          color: color ?? appTheme.gray900,
          letterSpacing: letterSpacing,
          lineHeight: lineHeight);

  TextStyle bold(
          {Color? color,
          double? size,
          double? lineHeight,
          double? letterSpacing}) =>
      _baseStyle(
          size: size,
          fontWeight: FontWeight.w600,
          color: color,
          letterSpacing: letterSpacing,
          lineHeight: lineHeight);

  TextStyle _baseStyle(
          {Color? color,
          double? size,
          double? lineHeight,
          double? letterSpacing,
          FontWeight? fontWeight}) =>
      TextStyle(
          fontSize: size ?? 10,
          fontFamily: fontFamily,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color ?? appTheme.gray900,
          height: lineHeight != null ? lineHeight / (size ?? 10) : null,
          letterSpacing: letterSpacing ?? -0.01);
}
