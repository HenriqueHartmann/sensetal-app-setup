import 'dart:ui';

/// Computes a responsive vertical gap based on the screen height and
/// configurable proportional values.
///
/// This function returns a vertical spacing value that scales smoothly
/// between two proportional values (`minValue` to `maxValue`), based
/// on the device's screen height. It enables adaptive spacing across
/// different screen sizes, from small phones to large tablets or foldables.
///
/// The proportional gap is calculated using the following rules:
///
/// - For screens <= 500dp tall, it returns `screenHeight * minValue`.
/// - For screens >= 1200dp tall, it returns `screenHeight * maxValue`.
/// - For anything in between, it linearly interpolates between the two.
///
/// This is useful for vertical spacing in responsive layouts, maintaining
/// visual balance across devices with different screen dimensions.
///
/// Example usage:
/// ```dart
/// double verticalGap = computeVerticalGap(
///   MediaQuery.of(context).size.height,
///   0.2, // minValue
///   0.25 // maxValue
/// );
/// SizedBox(height: verticalGap);
/// ```
///
/// [screenHeight] — The height of the screen in logical pixels (dp).
/// [minValue] — The proportional gap for small screens (e.g., 0.2 for 20%).
/// [maxValue] — The proportional gap for large screens (e.g., 0.25 for 25%).
///
/// Returns a vertical gap in logical pixels (dp).
double computeVerticalGap(double screenHeight, double minValue, double maxValue) {
  const minDeviceHeight = 500.0;
  const maxDeviceHeight = 1200.0;

  final minGap = screenHeight * minValue;
  final maxGap = screenHeight * maxValue;

  if (screenHeight <= minDeviceHeight) return minGap;
  if (screenHeight >= maxDeviceHeight) return maxGap;

  final t = ((screenHeight - minDeviceHeight) /
      (maxDeviceHeight - minDeviceHeight));
  return lerpDouble(minGap, maxGap, t)!;
}
