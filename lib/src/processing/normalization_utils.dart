import 'dart:math';

/// A utility class containing static methods for data normalization and scaling.
///
/// These functions are commonly used in data processing pipelines to bring
/// values from different scales into a common format, which is essential for
/// stable and reliable data fusion and analysis.
abstract class NormalizationUtils {
  /// Scales a value from an original range to a new target range.
  ///
  /// This is also known as min-max normalization. For example, it can be used to
  /// scale a sensor reading from its known range [min, max] to a standard
  /// range like [0.0, 1.0].
  ///
  /// [value] The input value to scale.
  /// [sourceMin] The minimum value of the original range.
  /// [sourceMax] The maximum value of the original range.
  /// [targetMin] The minimum value of the new target range (defaults to 0.0).
  /// [targetMax] The maximum value of the new target range (defaults to 1.0).
  ///
  /// Returns the scaled value. Returns [targetMin] if the source range is zero.
  static double minMaxScale(
    double value, {
    required double sourceMin,
    required double sourceMax,
    double targetMin = 0.0,
    double targetMax = 1.0,
  }) {
    if (sourceMin == sourceMax) {
      return targetMin;
    }
    // Formula for min-max scaling.
    return (value - sourceMin) * (targetMax - targetMin) / (sourceMax - sourceMin) + targetMin;
  }

  /// Clamps a value to be within a specified range [min, max].
  ///
  /// If the value is less than the minimum, it returns the minimum.
  /// If the value is greater than the maximum, it returns the maximum.
  /// Otherwise, it returns the original value.
  ///
  /// [value] The input value to clamp.
  /// [min] The lower bound of the range.
  /// [max] The upper bound of the range.
  ///
  /// Returns the clamped value.
  static double clamp(double value, double min, double max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  /// Applies the softmax function to a list of values.
  ///
  /// The softmax function converts a vector of K real numbers into a probability
  /// distribution of K possible outcomes. It is widely used in machine learning
  /// for multi-class classification problems.
  ///
  /// [values] A list of real numbers (logits).
  ///
  /// Returns a list of probabilities that sum to 1.0.
  static List<double> softmax(List<double> values) {
    if (values.isEmpty) return [];

    // Find the maximum value for numerical stability.
    // Subtracting the max value prevents overflow when computing the exponential.
    final double maxVal = values.reduce((a, b) => a > b ? a : b);
    
    final exps = values.map((v) => exp(v - maxVal)).toList();
    final double sumExps = exps.reduce((a, b) => a + b);

    if (sumExps == 0) {
      // If the sum is zero, return a uniform distribution.
      return List<double>.filled(values.length, 1.0 / values.length);
    }
    
    return exps.map((e) => e / sumExps).toList();
  }

  /// Linearly interpolates between two numbers.
  ///
  /// The parameter [t] is the interpolation factor, typically clamped between 0.0
  /// and 1.0. When [t] is 0.0, it returns [a]. When [t] is 1.0, it returns [b].
  ///
  /// [a] The start value.
  /// [b] The end value.
  /// [t] The interpolation factor.
  ///
  /// Returns the interpolated value.
  static double lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }
}
