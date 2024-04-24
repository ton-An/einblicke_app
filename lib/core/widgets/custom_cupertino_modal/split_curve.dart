/*
Copied from https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/animation/curves.dart due to it not having been exported


Copyright 2014 The Flutter Authors. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of Google Inc. nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import 'dart:ui';

import 'package:flutter/widgets.dart';

/// A curve that progresses according to [beginCurve] until [split], then
/// according to [endCurve].
///
/// Split curves are useful in situations where a widget must track the
/// user's finger (which requires a linear animation), but can also be flung
/// using a curve specified with the [endCurve] argument, after the finger is
/// released. In such a case, the value of [split] would be the progress
/// of the animation at the time when the finger was released.
///
/// For example, if [split] is set to 0.5, [beginCurve] is [Curves.linear],
/// and [endCurve] is [Curves.easeOutCubic], then the bottom-left quarter of the
/// curve will be a straight line, and the top-right quarter will contain the
/// entire [Curves.easeOutCubic] curve.
///
/// {@animation 464 192 https://flutter.github.io/assets-for-api-docs/assets/animation/curve_split.mp4}
class Split extends Curve {
  /// Creates a split curve.
  const Split(
    this.split, {
    this.beginCurve = Curves.linear,
    this.endCurve = Curves.easeOutCubic,
  });

  /// The progress value separating [beginCurve] from [endCurve].
  ///
  /// The value before which the curve progresses according to [beginCurve] and
  /// after which the curve progresses according to [endCurve].
  ///
  /// When t is exactly `split`, the curve has the value `split`.
  ///
  /// Must be between 0 and 1.0, inclusively.
  final double split;

  /// The curve to use before [split] is reached.
  ///
  /// Defaults to [Curves.linear].
  final Curve beginCurve;

  /// The curve to use after [split] is reached.
  ///
  /// Defaults to [Curves.easeOutCubic].
  final Curve endCurve;

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    assert(split >= 0.0 && split <= 1.0);

    if (t == 0.0 || t == 1.0) {
      return t;
    }

    if (t == split) {
      return split;
    }

    if (t < split) {
      final double curveProgress = t / split;
      final double transformed = beginCurve.transform(curveProgress);
      return lerpDouble(0, split, transformed)!;
    } else {
      final double curveProgress = (t - split) / (1 - split);
      final double transformed = endCurve.transform(curveProgress);
      return lerpDouble(split, 1, transformed)!;
    }
  }
}
