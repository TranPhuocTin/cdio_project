import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff4c5c92),
      surfaceTint: Color(0xff4c5c92),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffdce1ff),
      onPrimaryContainer: Color(0xff03174b),
      secondary: Color(0xff595e72),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffdee1f9),
      onSecondaryContainer: Color(0xff161b2c),
      tertiary: Color(0xff745470),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffd7f6),
      onTertiaryContainer: Color(0xff2c122a),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfffaf8ff),
      onBackground: Color(0xff1a1b21),
      surface: Color(0xfffaf8ff),
      onSurface: Color(0xff1a1b21),
      surfaceVariant: Color(0xffe2e1ec),
      onSurfaceVariant: Color(0xff45464f),
      outline: Color(0xff767680),
      outlineVariant: Color(0xffc6c6d0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inverseOnSurface: Color(0xfff1f0f7),
      inversePrimary: Color(0xffb5c4ff),
      primaryFixed: Color(0xffdce1ff),
      onPrimaryFixed: Color(0xff03174b),
      primaryFixedDim: Color(0xffb5c4ff),
      onPrimaryFixedVariant: Color(0xff344479),
      secondaryFixed: Color(0xffdee1f9),
      onSecondaryFixed: Color(0xff161b2c),
      secondaryFixedDim: Color(0xffc2c5dd),
      onSecondaryFixedVariant: Color(0xff414659),
      tertiaryFixed: Color(0xffffd7f6),
      onTertiaryFixed: Color(0xff2c122a),
      tertiaryFixedDim: Color(0xffe3bada),
      onTertiaryFixedVariant: Color(0xff5b3d57),
      surfaceDim: Color(0xffdad9e0),
      surfaceBright: Color(0xfffaf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f3fa),
      surfaceContainer: Color(0xffeeedf4),
      surfaceContainerHigh: Color(0xffe9e7ef),
      surfaceContainerHighest: Color(0xffe3e1e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff304074),
      surfaceTint: Color(0xff4c5c92),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6372aa),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3d4255),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6f7488),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff573953),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff8c6a86),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffaf8ff),
      onBackground: Color(0xff1a1b21),
      surface: Color(0xfffaf8ff),
      onSurface: Color(0xff1a1b21),
      surfaceVariant: Color(0xffe2e1ec),
      onSurfaceVariant: Color(0xff41424b),
      outline: Color(0xff5d5e67),
      outlineVariant: Color(0xff797a83),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inverseOnSurface: Color(0xfff1f0f7),
      inversePrimary: Color(0xffb5c4ff),
      primaryFixed: Color(0xff6372aa),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff4a598f),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6f7488),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff575b6f),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff8c6a86),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff72526d),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdad9e0),
      surfaceBright: Color(0xfffaf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f3fa),
      surfaceContainer: Color(0xffeeedf4),
      surfaceContainerHigh: Color(0xffe9e7ef),
      surfaceContainerHighest: Color(0xffe3e1e9),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff0b1e52),
      surfaceTint: Color(0xff4c5c92),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff304074),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff1d2133),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff3d4255),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff331931),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff573953),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffaf8ff),
      onBackground: Color(0xff1a1b21),
      surface: Color(0xfffaf8ff),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffe2e1ec),
      onSurfaceVariant: Color(0xff22242b),
      outline: Color(0xff41424b),
      outlineVariant: Color(0xff41424b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffe9ebff),
      primaryFixed: Color(0xff304074),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff18295d),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff3d4255),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff272c3e),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff573953),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff3f233c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdad9e0),
      surfaceBright: Color(0xfffaf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f3fa),
      surfaceContainer: Color(0xffeeedf4),
      surfaceContainerHigh: Color(0xffe9e7ef),
      surfaceContainerHighest: Color(0xffe3e1e9),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb5c4ff),
      surfaceTint: Color(0xffb5c4ff),
      onPrimary: Color(0xff1c2d61),
      primaryContainer: Color(0xff344479),
      onPrimaryContainer: Color(0xffdce1ff),
      secondary: Color(0xffc2c5dd),
      onSecondary: Color(0xff2b3042),
      secondaryContainer: Color(0xff414659),
      onSecondaryContainer: Color(0xffdee1f9),
      tertiary: Color(0xffe3bada),
      onTertiary: Color(0xff432740),
      tertiaryContainer: Color(0xff5b3d57),
      onTertiaryContainer: Color(0xffffd7f6),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff121318),
      onBackground: Color(0xffe3e1e9),
      surface: Color(0xff121318),
      onSurface: Color(0xffe3e1e9),
      surfaceVariant: Color(0xff45464f),
      onSurfaceVariant: Color(0xffc6c6d0),
      outline: Color(0xff8f909a),
      outlineVariant: Color(0xff45464f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e1e9),
      inverseOnSurface: Color(0xff2f3036),
      inversePrimary: Color(0xff4c5c92),
      primaryFixed: Color(0xffdce1ff),
      onPrimaryFixed: Color(0xff03174b),
      primaryFixedDim: Color(0xffb5c4ff),
      onPrimaryFixedVariant: Color(0xff344479),
      secondaryFixed: Color(0xffdee1f9),
      onSecondaryFixed: Color(0xff161b2c),
      secondaryFixedDim: Color(0xffc2c5dd),
      onSecondaryFixedVariant: Color(0xff414659),
      tertiaryFixed: Color(0xffffd7f6),
      onTertiaryFixed: Color(0xff2c122a),
      tertiaryFixedDim: Color(0xffe3bada),
      onTertiaryFixedVariant: Color(0xff5b3d57),
      surfaceDim: Color(0xff121318),
      surfaceBright: Color(0xff38393f),
      surfaceContainerLowest: Color(0xff0d0e13),
      surfaceContainerLow: Color(0xff1a1b21),
      surfaceContainer: Color(0xff1e1f25),
      surfaceContainerHigh: Color(0xff292a2f),
      surfaceContainerHighest: Color(0xff34343a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffbbc9ff),
      surfaceTint: Color(0xffb5c4ff),
      onPrimary: Color(0xff001143),
      primaryContainer: Color(0xff7f8ec8),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffc6cae1),
      onSecondary: Color(0xff111626),
      secondaryContainer: Color(0xff8c90a5),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffe7bfdf),
      onTertiary: Color(0xff260d24),
      tertiaryContainer: Color(0xffaa85a3),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff121318),
      onBackground: Color(0xffe3e1e9),
      surface: Color(0xff121318),
      onSurface: Color(0xfffcfaff),
      surfaceVariant: Color(0xff45464f),
      onSurfaceVariant: Color(0xffcacad4),
      outline: Color(0xffa2a2ac),
      outlineVariant: Color(0xff82828c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e1e9),
      inverseOnSurface: Color(0xff292a2f),
      inversePrimary: Color(0xff35457a),
      primaryFixed: Color(0xffdce1ff),
      onPrimaryFixed: Color(0xff000d37),
      primaryFixedDim: Color(0xffb5c4ff),
      onPrimaryFixedVariant: Color(0xff233367),
      secondaryFixed: Color(0xffdee1f9),
      onSecondaryFixed: Color(0xff0b1021),
      secondaryFixedDim: Color(0xffc2c5dd),
      onSecondaryFixedVariant: Color(0xff313548),
      tertiaryFixed: Color(0xffffd7f6),
      onTertiaryFixed: Color(0xff20071f),
      tertiaryFixedDim: Color(0xffe3bada),
      onTertiaryFixedVariant: Color(0xff492c46),
      surfaceDim: Color(0xff121318),
      surfaceBright: Color(0xff38393f),
      surfaceContainerLowest: Color(0xff0d0e13),
      surfaceContainerLow: Color(0xff1a1b21),
      surfaceContainer: Color(0xff1e1f25),
      surfaceContainerHigh: Color(0xff292a2f),
      surfaceContainerHighest: Color(0xff34343a),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffcfaff),
      surfaceTint: Color(0xffb5c4ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffbbc9ff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffcfaff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc6cae1),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffff9fa),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffe7bfdf),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff121318),
      onBackground: Color(0xffe3e1e9),
      surface: Color(0xff121318),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff45464f),
      onSurfaceVariant: Color(0xfffcfaff),
      outline: Color(0xffcacad4),
      outlineVariant: Color(0xffcacad4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e1e9),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff15265a),
      primaryFixed: Color(0xffe2e6ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffbbc9ff),
      onPrimaryFixedVariant: Color(0xff001143),
      secondaryFixed: Color(0xffe2e6fe),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc6cae1),
      onSecondaryFixedVariant: Color(0xff111626),
      tertiaryFixed: Color(0xffffddf6),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffe7bfdf),
      onTertiaryFixedVariant: Color(0xff260d24),
      surfaceDim: Color(0xff121318),
      surfaceBright: Color(0xff38393f),
      surfaceContainerLowest: Color(0xff0d0e13),
      surfaceContainerLow: Color(0xff1a1b21),
      surfaceContainer: Color(0xff1e1f25),
      surfaceContainerHigh: Color(0xff292a2f),
      surfaceContainerHighest: Color(0xff34343a),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary, 
    required this.surfaceTint, 
    required this.onPrimary, 
    required this.primaryContainer, 
    required this.onPrimaryContainer, 
    required this.secondary, 
    required this.onSecondary, 
    required this.secondaryContainer, 
    required this.onSecondaryContainer, 
    required this.tertiary, 
    required this.onTertiary, 
    required this.tertiaryContainer, 
    required this.onTertiaryContainer, 
    required this.error, 
    required this.onError, 
    required this.errorContainer, 
    required this.onErrorContainer, 
    required this.background, 
    required this.onBackground, 
    required this.surface, 
    required this.onSurface, 
    required this.surfaceVariant, 
    required this.onSurfaceVariant, 
    required this.outline, 
    required this.outlineVariant, 
    required this.shadow, 
    required this.scrim, 
    required this.inverseSurface, 
    required this.inverseOnSurface, 
    required this.inversePrimary, 
    required this.primaryFixed, 
    required this.onPrimaryFixed, 
    required this.primaryFixedDim, 
    required this.onPrimaryFixedVariant, 
    required this.secondaryFixed, 
    required this.onSecondaryFixed, 
    required this.secondaryFixedDim, 
    required this.onSecondaryFixedVariant, 
    required this.tertiaryFixed, 
    required this.onTertiaryFixed, 
    required this.tertiaryFixedDim, 
    required this.onTertiaryFixedVariant, 
    required this.surfaceDim, 
    required this.surfaceBright, 
    required this.surfaceContainerLowest, 
    required this.surfaceContainerLow, 
    required this.surfaceContainer, 
    required this.surfaceContainerHigh, 
    required this.surfaceContainerHighest, 
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
