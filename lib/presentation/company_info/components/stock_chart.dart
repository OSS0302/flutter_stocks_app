import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_stocks_app/domain/model/intraday_info.dart';

class StockChart extends StatelessWidget {
  final List<IntradayInfo> infos; // info 데이터 받고

  final Color graphColor; // 컬러를 받는다 .
  final Color textColor; // 컬러를 받는다 .
  const StockChart({
    Key? key,
    this.infos = const [],
    required this.graphColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: CustomPaint(
        painter: ChartPainter(infos, graphColor,textColor),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<IntradayInfo> infos;
  final Color graphColor;
  final Color textColor;


  //가격 높은값
  late int upperValue = infos.map((e) => e.close)
      .fold<double>(0.0, max).ceil(); // 올림
  //(previousValue , element)=> max(previousValue, element) :max으로 생략 가능
  // 가격 낮은 값
  late int lowerValue = infos.map((e) => e.close)
      .reduce((min)).toInt(); // 올림
  //(value, element) => min(value, element) : min

  final spacing = 50.0; // 좌표 그리는 데 필요하다
  late Paint strokePaint; // 캠퍼스 설정하기

  ChartPainter(this.infos, this.graphColor, this.textColor) {
    strokePaint = Paint()
      ..color = graphColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 캠퍼스 와 사이즈 직접 그리는 코드
    //그림 그리기 숫자 그리기 와 그래프는 패스라는 기능으로 그린다.
    //가격 6로  간격나누기
    final priceStep = (upperValue - lowerValue) / 5.0;
    for (var i = 0; i < 6; i++) {
      //텍스트 페인터로 위치를 잡는다
      final tp = TextPainter(
        text: TextSpan(
          text: '${(lowerValue + priceStep * i ).round()}', // 밑에서 위로 그리는 방식 이다.
          style:  TextStyle(fontSize: 12,color:  textColor),
        ),

        textAlign: TextAlign.start,
        textDirection: TextDirection.ltr, // 왼쪽 지정
      );

      tp.layout();
      tp.paint(canvas, Offset(
          10, size.height -i  * (size.height / 5.0 ))); // offset좌표
    }
    final spacePerHour = (size.width-spacing) / infos.length; // length만큼 쪼깬다.
    for (var i = 0; i < infos.length; i += 12) {
      final hour = infos[i].date.hour;

      final tp = TextPainter(
        text: TextSpan(
          text: '$hour',
          style:   TextStyle(fontSize: 12,color: textColor),
        ),
        textAlign: TextAlign.start,
        textDirection: TextDirection.ltr, // 왼쪽 지정
      );
      tp.layout();
      tp.paint(canvas,
          Offset(i * spacePerHour + spacing, size.height +20 )); // offset좌표
    }
    // 그래프 계산하기  (path)
    var lastX = 0.0; // 추가
    final strockePath = Path();
    for (var i = 0; i < infos.length; i++) {
      final info = infos[i]; // infos 을 얻고
      // x축 y축 계산하기
      var nextIndex = i + 1;
      if (i + 1 > infos.length - 1) nextIndex = infos.length - 1;
      final nextInfo = infos[nextIndex];
      // 비율 구하기
      final leftRatio = (info.close - lowerValue) / (upperValue - lowerValue);
      final rightRatio = (nextInfo.close - lowerValue) /
          (upperValue - lowerValue);
      // 좌표 (앞에 좌표와 뒤에 좌표를 이어라)
      final x1 = spacing + i * spacePerHour;
      final y1 = size.height - (leftRatio * size.height).toDouble();
      //x1 과 y1 다음 좌표
      final x2 = spacing + (i + 1) * spacePerHour;
      final y2 = size.height - (rightRatio * size.height).toDouble();
      // 처음 무브 를 하고
      if (i == 0) {
        strockePath.moveTo(x1, y1);
      }
      lastX = (x1 + x2) / 2.0; // x축 이동
      strockePath.quadraticBezierTo(
          x1, y1, lastX, (y1 + y2) / 2.0); // x축 y축연결하기
    }


    // 그래프 모형 형태 그리기
    final fillPath = Path.from(strockePath)
      ..lineTo(lastX, size.height - spacing)..lineTo(spacing,
          size.height - spacing); // lineTo 안에  double 만 된다. spacing double형으로 변경
    // 그리기
    final fillPaint = Paint()
      ..color = graphColor
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
          Offset.zero, Offset(0, size.height - spacing),
          [
            graphColor.withOpacity(0.5),
            Colors.transparent,
          ]
      );


    // 그래프 그리기
    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(strockePath, strokePaint);

  }

  @override
  bool shouldRepaint(ChartPainter oldDelegate) {
    // 갱신하는 규칙 정의하는 부분
    // 타입을 호환되는 CustomPainer를 그런 타입으로 변경할 수있다. (covariant CustomPainter->ChartPainter)
    return oldDelegate.infos !=
        infos; // 이전 상태와 현재상태 다르면 다시 그려라 //true 무조건 다시 그려라
  }

}