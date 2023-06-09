import 'dart:async' show StreamSink;

import 'package:flutter/material.dart';
import 'package:mars/widgets/kline/utils/number_util.dart';
import '../entity/k_line_entity.dart';
import '../utils/date_format_util.dart';
import '../entity/info_window_entity.dart';

import 'base_chart_painter.dart';
import 'base_chart_renderer.dart';
import 'main_renderer.dart';
import 'secondary_renderer.dart';
import 'vol_renderer.dart';

class ChartPainter extends BaseChartPainter {
  static get maxScrollX => BaseChartPainter.maxScrollX;
  BaseChartRenderer mMainRenderer, mVolRenderer, mSecondaryRenderer;
  StreamSink<InfoWindowEntity> sink;
  Color upColor, dnColor;
  Color ma5Color, ma10Color, ma30Color;
  Color volColor;
  Color macdColor, difColor, deaColor, jColor;
  List<Color> bgColor;
  int fixedLength;
  List<int> maDayList;
  double rightInt = 40;
  bool isRight = false;
  bool isLoadMore;

  ChartPainter({@required datas, @required scaleX, @required scrollX, @required isLongPass, @required selectX, mainState, volHidden, secondaryState, this.sink, bool isLine, this.bgColor, this.fixedLength, this.maDayList, this.isLoadMore})
      : assert(bgColor == null || bgColor.length >= 2),
        super(datas: datas, scaleX: scaleX, scrollX: scrollX, isLongPress: isLongPass, selectX: selectX, mainState: mainState, volHidden: volHidden, secondaryState: secondaryState, isLine: isLine);

  @override
  void initChartRenderer() {
    if (fixedLength == null) {
      if (datas == null || datas.isEmpty) {
        fixedLength = 2;
      } else {
        var t = datas[0];
        fixedLength = NumberUtil.getMaxDecimalLength(t.open, t.close, t.high, t.low);
      }
    }
    mMainRenderer ??= MainRenderer(mMainRect, mMainMaxValue, mMainMinValue, mTopPadding, mainState, isLine, fixedLength, maDayList);
    if (mVolRect != null) {
      mVolRenderer ??= VolRenderer(mVolRect, mVolMaxValue, mVolMinValue, mChildPadding, fixedLength);
    }
    if (mSecondaryRect != null) mSecondaryRenderer ??= SecondaryRenderer(mSecondaryRect, mSecondaryMaxValue, mSecondaryMinValue, mChildPadding, secondaryState, fixedLength);
  }

  @override
  void drawBg(Canvas canvas, Size size) {
    Paint mBgPaint = Paint();
    Gradient mBgGradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: bgColor,
    );
    if (mMainRect != null) {
      Rect mainRect = Rect.fromLTRB(0, 0, mMainRect.width, mMainRect.height + mTopPadding);
      canvas.drawRect(mainRect, mBgPaint..shader = mBgGradient.createShader(mainRect));
    }

    if (mVolRect != null) {
      Rect volRect = Rect.fromLTRB(0, mVolRect.top - mChildPadding, mVolRect.width, mVolRect.bottom);
      canvas.drawRect(volRect, mBgPaint..shader = mBgGradient.createShader(volRect));
    }

    if (mSecondaryRect != null) {
      Rect secondaryRect = Rect.fromLTRB(0, mSecondaryRect.top - mChildPadding, mSecondaryRect.width, mSecondaryRect.bottom);
      canvas.drawRect(secondaryRect, mBgPaint..shader = mBgGradient.createShader(secondaryRect));
    }
    Rect dateRect = Rect.fromLTRB(0, size.height - mBottomPadding, size.width, size.height);
    canvas.drawRect(dateRect, mBgPaint..shader = mBgGradient.createShader(dateRect));
  }

  @override
  void drawGrid(canvas) {
    mMainRenderer?.drawGrid(canvas, mGridRows, mGridColumns);
    mVolRenderer?.drawGrid(canvas, mGridRows, mGridColumns);
    mSecondaryRenderer?.drawGrid(canvas, mGridRows, mGridColumns);
  }

  @override
  void drawChart(Canvas canvas, Size size) {
    isLoadMore = scrollX <= 50 && datas != null && datas.length > 40;
    canvas.save();
    canvas.translate(mTranslateX * scaleX - (isLoadMore ? rightInt : 0), 0.0);
    canvas.scale(scaleX, 1.0);
    for (int i = mStartIndex; datas != null && i <= mStopIndex; i++) {
      KLineEntity curPoint = datas[i];
      if (curPoint == null) continue;
      KLineEntity lastPoint = i == 0 ? curPoint : datas[i - 1];
      double curX = getX(i);
      double lastX = i == 0 ? curX : getX(i - 1);

      mMainRenderer?.drawChart(lastPoint, curPoint, lastX, curX, size, canvas);
      mVolRenderer?.drawChart(lastPoint, curPoint, lastX, curX, size, canvas);
      mSecondaryRenderer?.drawChart(lastPoint, curPoint, lastX, curX, size, canvas);
    }

    if (isLongPress == true) drawCrossLine(canvas, size);
    canvas.restore();
  }

  @override
  void drawRightText(canvas) {
    var textStyle = getTextStyle(ChartColors.defaultTextColor);
    mMainRenderer?.drawRightText(canvas, textStyle, mGridRows);
    mVolRenderer?.drawRightText(canvas, textStyle, mGridRows);
    mSecondaryRenderer?.drawRightText(canvas, textStyle, mGridRows);
  }

  @override
  void drawDate(Canvas canvas, Size size) {
    double columnSpace = size.width / mGridColumns;
    double startX = getX(mStartIndex) - mPointWidth / 2;
    double stopX = getX(mStopIndex) + mPointWidth / 2;
    double y = 0.0;
    for (var i = 0; i <= mGridColumns; ++i) {
      double translateX = xToTranslateX(columnSpace * i);
      if (translateX >= startX && translateX <= stopX) {
        int index = indexOfTranslateX(translateX);
        if (datas[index] == null) continue;

        TextPainter tp = getTextPainter(getDate(datas[index].time));
        y = size.height - (mBottomPadding - tp.height) / 2 - tp.height;
        tp.paint(canvas, Offset(columnSpace * i - tp.width / 2, y));
      }
    }

//    double translateX = xToTranslateX(0);
//    if (translateX >= startX && translateX <= stopX) {
//      TextPainter tp = getTextPainter(getDate(datas[mStartIndex].id));
//      tp.paint(canvas, Offset(0, y));
//    }
//    translateX = xToTranslateX(size.width);
//    if (translateX >= startX && translateX <= stopX) {
//      TextPainter tp = getTextPainter(getDate(datas[mStopIndex].id));
//      tp.paint(canvas, Offset(size.width - tp.width, y));
//    }
  }

  Paint selectPointPaint = Paint()
    ..isAntiAlias = true
    ..strokeWidth = 0.5
    ..color = ChartColors.upColor;
  Paint selectorBorderPaint = Paint()
    ..isAntiAlias = true
    ..strokeWidth = 0.5
    ..style = PaintingStyle.stroke
    ..color = ChartColors.upColor;

  @override
  void drawCrossLineText(Canvas canvas, Size size) {
    var index = calculateSelectedX(selectX);
    KLineEntity point = getItem(index);

    TextPainter tp = getTextPainter(point.close, Colors.white);
    double textHeight = tp.height;
    double textWidth = tp.width;

    double w1 = 5;
    double w2 = 3;
    double r = textHeight / 2 + w2;
    double y = getMainY(point.close);
    double x;
    bool isLeft = false;
    if (translateXtoX(getX(index)) < mWidth / 2) {
      isLeft = false;
      x = 1;
      Path path = new Path();
      path.moveTo(x, y - r);
      path.lineTo(x, y + r);
      path.lineTo(textWidth + 2 * w1, y + r);
      path.lineTo(textWidth + 2 * w1 + w2, y);
      path.lineTo(textWidth + 2 * w1, y - r);
      path.close();
      canvas.drawPath(path, selectPointPaint);
      canvas.drawPath(path, selectorBorderPaint);
      tp.paint(canvas, Offset(x + w1, y - textHeight / 2));
    } else {
      isLeft = true;
      x = mWidth - textWidth - 1 - 2 * w1 - w2;
      Path path = new Path();
      path.moveTo(x, y);
      path.lineTo(x + w2, y + r);
      path.lineTo(mWidth - 2, y + r);
      path.lineTo(mWidth - 2, y - r);
      path.lineTo(x + w2, y - r);
      path.close();
      canvas.drawPath(path, selectPointPaint);
      canvas.drawPath(path, selectorBorderPaint);
      tp.paint(canvas, Offset(x + w1 + w2, y - textHeight / 2));
    }

    TextPainter dateTp = getTextPainter(getDate(point.time), Colors.white);
    textWidth = dateTp.width;
    r = textHeight / 2;
    x = translateXtoX(getX(index));
    y = size.height - mBottomPadding;

    if (x < textWidth + 2 * w1) {
      x = 1 + textWidth / 2 + w1;
    } else if (mWidth - x < textWidth + 2 * w1) {
      x = mWidth - 1 - textWidth / 2 - w1;
    }
    double baseLine = textHeight / 2;
    canvas.drawRect(Rect.fromLTRB(x - textWidth / 2 - w1, y, x + textWidth / 2 + w1, y + baseLine + r), selectPointPaint);
    canvas.drawRect(Rect.fromLTRB(x - textWidth / 2 - w1, y, x + textWidth / 2 + w1, y + baseLine + r), selectorBorderPaint);

    dateTp.paint(canvas, Offset(x - textWidth / 2, y));
    //长按显示这条数据详情
    sink?.add(InfoWindowEntity(point, isLeft));
  }

  @override
  void drawText(Canvas canvas, KLineEntity data, double x) {
    //长按显示按中的数据
    if (isLongPress) {
      var index = calculateSelectedX(selectX);
      data = getItem(index);
    }
    //松开显示最后一条数据
    mMainRenderer?.drawText(canvas, data, x);
    mVolRenderer?.drawText(canvas, data, x);
    mSecondaryRenderer?.drawText(canvas, data, x);
  }

  @override
  void drawMaxAndMin(Canvas canvas) {
    if (isLine == true) return;
    isLoadMore = scrollX <= 50 && datas != null && datas.length > 40;

    //绘制最大值和最小值
    double x = translateXtoX(getX(mMainMinIndex)) - (isLoadMore ? rightInt : 0);
    double y = getMainY(mMainLowMinValue);
    if (x < mWidth / 2) {
      //画右边
      TextPainter tp = getTextPainter("── " + mMainLowMinValue.toString(), Color(0xFF687D9C));
      tp.paint(canvas, Offset(x, y - tp.height / 2));
    } else {
      TextPainter tp = getTextPainter(mMainLowMinValue.toString() + " ──",  Color(0xFF687D9C));
      tp.paint(canvas, Offset(x - tp.width, y - tp.height / 2));
    }
    x = translateXtoX(getX(mMainMaxIndex)) - (isLoadMore ? rightInt : 0);
    y = getMainY(mMainHighMaxValue);
    if (x < mWidth / 2) {
      //画右边
      TextPainter tp = getTextPainter("── " + mMainHighMaxValue.toString(), Color(0xFF687D9C));
      tp.paint(canvas, Offset(x, y - tp.height / 2));
    } else {
      TextPainter tp = getTextPainter(mMainHighMaxValue.toString() + " ──",  Color(0xFF687D9C));
      tp.paint(canvas, Offset(x - tp.width, y - tp.height / 2));
    }
  }

  ///画交叉线
  void drawCrossLine(Canvas canvas, Size size) {
    var index = calculateSelectedX(selectX);
    KLineEntity point = getItem(index);
    Paint paintY = Paint()
      ..color = ChartColors.upColor
      ..strokeWidth = ChartStyle.hCrossWidth
      ..isAntiAlias = true;
    double x = getX(index);
    double y = getMainY(point.close);
    // k线图竖线
    canvas.drawLine(Offset(x, mTopPadding), Offset(x, size.height - mBottomPadding), paintY);

    Paint paintX = Paint()
      ..color = ChartColors.upColor
      ..strokeWidth = ChartStyle.hCrossWidth
      ..isAntiAlias = true;
    // k线图横线
    canvas.drawLine(Offset(-mTranslateX, y), Offset(-mTranslateX + mWidth / scaleX, y), paintX);
    canvas.drawCircle(Offset(x, y), 2.0, paintX);
  }

  TextPainter getTextPainter(text, [color = ChartColors.defaultTextColor]) {
    TextSpan span = TextSpan(text: "$text", style: getTextStyle(color));
    TextPainter tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout();
    return tp;
  }

  String getDate(int date) => dateFormat(DateTime.fromMillisecondsSinceEpoch(date), mFormats);

  double getMainY(double y) => mMainRenderer?.getY(y) ?? 0.0;
}
