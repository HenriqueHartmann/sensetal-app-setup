enum AppSpaceSize {
  xxs, // 4
  xs,  // 8
  sm,  // 12
  md,  // 16
  lg,  // 24
  xl,  // 32
  xxl, // 40
  custom
}

double getSizeFromEnum(AppSpaceSize size, [double? customSize]) {
  switch (size) {
    case AppSpaceSize.xxs:
      return 4.0;
    case AppSpaceSize.xs:
      return 8.0;
    case AppSpaceSize.sm:
      return 12.0;
    case AppSpaceSize.md:
      return 16.0;
    case AppSpaceSize.lg:
      return 24.0;
    case AppSpaceSize.xl:
      return 32.0;
    case AppSpaceSize.xxl:
      return 40.0;
    case AppSpaceSize.custom:
      return customSize ?? 0.0;
  }
}
