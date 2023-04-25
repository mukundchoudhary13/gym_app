import 'dart:math';

class StandardScaler {
  bool copy;
  bool withMean;
  bool withStd;
  List<double> mean_ = [];
  List<double> scale_ = [];

  StandardScaler({this.copy = true, this.withMean = true, this.withStd = true});

  StandardScaler fit(List<List<double>> X) {
    if (withMean) {
      mean_ = List<double>.from(
          X.reduce((a, b) => List<double>.generate(a.length, (i) => a[i] + b[i]))
              .map((e) => e / X.length));
    }

    if (withStd) {
      scale_ = List<double>.from(
          X.reduce((a, b) => List<double>.generate(a.length, (i) => a[i] + b[i]))
              .map((e) => sqrt(e / X.length - pow(mean_[scale_.length], 2))));
    }

    return this;
  }

  List<List<double>> transform(List<List<double>> X) {
    if (withMean) {
      X = X.map((row) => List<double>.generate(
          row.length, (i) => row[i] - mean_[i])).toList();
    }

    if (withStd) {
      X = X.map((row) => List<double>.generate(
          row.length, (i) => row[i] / scale_[i])).toList();
    }

    return X;
  }

  List<List<double>> fit_transform(List<List<double>> X) {
    fit(X);
    return transform(X);
  }

  List<List<double>> inverse_transform(List<List<double>> X) {
    if (withStd) {
      X = X.map((row) => List<double>.generate(
          row.length, (i) => row[i] * scale_[i])).toList();
    }

    if (withMean) {
      X = X.map((row) => List<double>.generate(
          row.length, (i) => row[i] + mean_[i])).toList();
    }

    return X;
  }
}
