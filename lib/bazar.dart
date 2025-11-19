// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// class BazaarMap extends StatefulWidget {
//   @override
//   _BazaarMapState createState() => _BazaarMapState();
// }

// class _BazaarMapState extends State<BazaarMap> {
//   final TransformationController _controller = TransformationController();

//   void _resetZoom() {
//     _controller.value = Matrix4.identity();
//   }

//   void _zoomIn() {
//     final matrix = _controller.value.clone();
//     matrix.scale(1.3);
//     _controller.value = matrix;
//   }

//   void _zoomOut() {
//     final matrix = _controller.value.clone();
//     matrix.scale(0.7);
//     _controller.value = matrix;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text("Карта"),
//         backgroundColor: Colors.white,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add_circle_outline),
//             onPressed: _zoomIn,
//             tooltip: "Увеличить",
//           ),
//           IconButton(
//             icon: Icon(Icons.remove_circle_outline),
//             onPressed: _zoomOut,
//             tooltip: "Уменьшить",
//           ),
//           IconButton(
//             icon: Icon(Icons.my_location),
//             onPressed: _resetZoom,
//             tooltip: "Сбросить",
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           InteractiveViewer(
//             transformationController: _controller,
//             minScale: 0.1,
//             maxScale: 8,
//             boundaryMargin: EdgeInsets.all(200),
//             constrained: false,
//             child: Container(
//               color: Color(0xFFE8F5E9),
//               child: CustomPaint(
//                 size: Size(1600, 1600),
//                 painter: Realistic2GISPainter(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Realistic2GISPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final bgPaint = Paint()..color = Color(0xFFE8F5E9);
//     canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

//     drawRoads(canvas);

//     drawMainBuilding(canvas, 80, 80, 1440, 1440);

//     drawParkingLot(canvas, 80, 1550, 400, 200);
//     drawParkingLot(canvas, 1120, 1550, 400, 200);

//     drawGreenZone(canvas, 500, 1550, 600, 200);

//     drawEntranceWithCanopy(canvas, 750, 1490, 150, 30, "ГЛАВНЫЙ ВХОД");
//     drawEntranceWithCanopy(canvas, 80, 750, 40, 100, "");
//     drawEntranceWithCanopy(canvas, 1480, 750, 40, 100, "");

//     drawLegend(canvas);
//   }

//   void drawRoads(Canvas canvas) {
//     final roadPaint =
//         Paint()
//           ..color = Color(0xFFBDBDBD)
//           ..style = PaintingStyle.fill;

//     final roadLinePaint =
//         Paint()
//           ..color = Colors.white
//           ..strokeWidth = 2
//           ..style = PaintingStyle.stroke;
//     final mainRoad = RRect.fromRectAndRadius(
//       Rect.fromLTWH(0, 1520, 1600, 80),
//       Radius.circular(0),
//     );
//     canvas.drawRRect(mainRoad, roadPaint);

//     for (double i = 0; i < 1600; i += 40) {
//       canvas.drawLine(Offset(i, 1560), Offset(i + 20, 1560), roadLinePaint);
//     }

//     canvas.drawRect(Rect.fromLTWH(0, 0, 80, 1600), roadPaint);

//     canvas.drawRect(Rect.fromLTWH(1520, 0, 80, 1600), roadPaint);
//   }

//   void drawMainBuilding(Canvas canvas, double x, double y, double w, double h) {
//     final shadowPaint =
//         Paint()
//           ..color = Colors.black.withOpacity(0.2)
//           ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20);
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromLTWH(x + 10, y + 10, w, h),
//         Radius.circular(8),
//       ),
//       shadowPaint,
//     );

//     final buildingGradient = LinearGradient(
//       colors: [Color(0xFFF5F5F5), Color(0xFFE0E0E0)],
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//     );

//     final buildingPaint =
//         Paint()
//           ..shader = buildingGradient.createShader(Rect.fromLTWH(x, y, w, h));

//     canvas.drawRRect(
//       RRect.fromRectAndRadius(Rect.fromLTWH(x, y, w, h), Radius.circular(8)),
//       buildingPaint,
//     );

//     final borderPaint =
//         Paint()
//           ..color = Color(0xFF757575)
//           ..strokeWidth = 3
//           ..style = PaintingStyle.stroke;
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(Rect.fromLTWH(x, y, w, h), Radius.circular(8)),
//       borderPaint,
//     );

//     drawShopsRealistic(canvas, x, y, w, h);
//     drawCorridors(canvas, x, y, w, h);
//     drawCentralHall(canvas, 840, 540, 380, 480);
//   }

//   void drawShopsRealistic(
//     Canvas canvas,
//     double baseX,
//     double baseY,
//     double baseW,
//     double baseH,
//   ) {
//     final shopColors = [
//       Color(0xFFFFE0B2),
//       Color(0xFFB3E5FC),
//       Color(0xFFC8E6C9),
//       Color(0xFFF8BBD0),
//     ];

//     drawShopSection(canvas, 120, 120, 7, 4, 100, 100, shopColors[0], "A");
//     drawShopSection(canvas, 840, 120, 4, 4, 100, 100, shopColors[1], "B");
//     drawShopSection(canvas, 1240, 120, 5, 4, 100, 100, shopColors[2], "C");

//     drawShopSection(canvas, 120, 540, 7, 5, 100, 100, shopColors[3], "D");
//     drawShopSection(canvas, 1240, 540, 5, 5, 100, 100, shopColors[0], "E");

//     drawShopSection(canvas, 120, 1040, 7, 5, 100, 100, shopColors[1], "F");
//     drawShopSection(canvas, 840, 1040, 4, 5, 100, 100, shopColors[2], "G");
//     drawShopSection(canvas, 1240, 1040, 5, 5, 100, 100, shopColors[3], "H");
//   }

//   void drawShopSection(
//     Canvas canvas,
//     double startX,
//     double startY,
//     int cols,
//     int rows,
//     double cellW,
//     double cellH,
//     Color baseColor,
//     String section,
//   ) {
//     for (int row = 0; row < rows; row++) {
//       for (int col = 0; col < cols; col++) {
//         final x = startX + col * cellW;
//         final y = startY + row * cellH;
//         final shopNumber = row * cols + col + 1;

//         drawSingleShop(
//           canvas,
//           x,
//           y,
//           cellW - 8,
//           cellH - 8,
//           baseColor,
//           "$section-$shopNumber",
//         );
//       }
//     }
//   }

//   void drawSingleShop(
//     Canvas canvas,
//     double x,
//     double y,
//     double w,
//     double h,
//     Color color,
//     String label,
//   ) {
//     final shadowPaint =
//         Paint()
//           ..color = Colors.black.withOpacity(0.15)
//           ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4);
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromLTWH(x + 2, y + 2, w, h),
//         Radius.circular(4),
//       ),
//       shadowPaint,
//     );

//     final shopGradient = LinearGradient(
//       colors: [color, color.withOpacity(0.7)],
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//     );

//     final shopPaint =
//         Paint()..shader = shopGradient.createShader(Rect.fromLTWH(x, y, w, h));

//     canvas.drawRRect(
//       RRect.fromRectAndRadius(Rect.fromLTWH(x, y, w, h), Radius.circular(4)),
//       shopPaint,
//     );

//     final borderPaint =
//         Paint()
//           ..color = color.withOpacity(0.5)
//           ..strokeWidth = 1.5
//           ..style = PaintingStyle.stroke;
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(Rect.fromLTWH(x, y, w, h), Radius.circular(4)),
//       borderPaint,
//     );

//     if (w > 60) {
//       drawText(canvas, label, x + w / 2, y + h / 2 - 6, Colors.black87, 10);
//     }

//     final doorRect = Rect.fromLTWH(x + w / 2 - 8, y + h - 16, 16, 12);
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(doorRect, Radius.circular(2)),
//       Paint()..color = Colors.brown.shade700,
//     );
//   }

//   void drawCorridors(Canvas canvas, double x, double y, double w, double h) {
//     final corridorPaint =
//         Paint()
//           ..color = Color(0xFFFFF9C4)
//           ..style = PaintingStyle.fill;

//     final corridorBorderPaint =
//         Paint()
//           ..color = Color(0xFFFBC02D)
//           ..strokeWidth = 2
//           ..style = PaintingStyle.stroke;

//     final corridor1 = RRect.fromRectAndRadius(
//       Rect.fromLTWH(80, 510, 1440, 40),
//       Radius.circular(4),
//     );
//     canvas.drawRRect(corridor1, corridorPaint);
//     canvas.drawRRect(corridor1, corridorBorderPaint);

//     final corridor2 = RRect.fromRectAndRadius(
//       Rect.fromLTWH(80, 1010, 1440, 40),
//       Radius.circular(4),
//     );
//     canvas.drawRRect(corridor2, corridorPaint);
//     canvas.drawRRect(corridor2, corridorBorderPaint);

//     final corridor3 = RRect.fromRectAndRadius(
//       Rect.fromLTWH(810, 80, 40, 1440),
//       Radius.circular(4),
//     );
//     canvas.drawRRect(corridor3, corridorPaint);
//     canvas.drawRRect(corridor3, corridorBorderPaint);

//     final corridor4 = RRect.fromRectAndRadius(
//       Rect.fromLTWH(1210, 80, 40, 1440),
//       Radius.circular(4),
//     );
//     canvas.drawRRect(corridor4, corridorPaint);
//     canvas.drawRRect(corridor4, corridorBorderPaint);

//     drawArrow(canvas, 800, 530, true);
//     drawArrow(canvas, 800, 1030, true);
//   }

//   void drawCentralHall(Canvas canvas, double x, double y, double w, double h) {
//     final shadowPaint =
//         Paint()
//           ..color = Colors.black.withOpacity(0.1)
//           ..maskFilter = MaskFilter.blur(BlurStyle.normal, 15);
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromLTWH(x + 5, y + 5, w, h),
//         Radius.circular(8),
//       ),
//       shadowPaint,
//     );

//     final hallGradient = RadialGradient(
//       colors: [Color(0xFFE1F5FE), Color(0xFFB3E5FC)],
//       center: Alignment.center,
//     );

//     final hallPaint =
//         Paint()..shader = hallGradient.createShader(Rect.fromLTWH(x, y, w, h));

//     canvas.drawRRect(
//       RRect.fromRectAndRadius(Rect.fromLTWH(x, y, w, h), Radius.circular(8)),
//       hallPaint,
//     );

//     final borderPaint =
//         Paint()
//           ..color = Color(0xFF0288D1)
//           ..strokeWidth = 3
//           ..style = PaintingStyle.stroke;
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(Rect.fromLTWH(x, y, w, h), Radius.circular(8)),
//       borderPaint,
//     );

//     drawText(
//       canvas,
//       "ЦЕНТРАЛЬНЫЙ",
//       x + w / 2,
//       y + h / 2 - 20,
//       Color(0xFF01579B),
//       20,
//       FontWeight.bold,
//     );
//     drawText(
//       canvas,
//       "ЗАЛ",
//       x + w / 2,
//       y + h / 2 + 5,
//       Color(0xFF01579B),
//       20,
//       FontWeight.bold,
//     );

//     for (int i = 0; i < 3; i++) {
//       final benchX = x + 60 + i * 120;
//       final benchY = y + h / 2 - 20;
//       canvas.drawRRect(
//         RRect.fromRectAndRadius(
//           Rect.fromLTWH(benchX, benchY, 80, 15),
//           Radius.circular(4),
//         ),
//         Paint()..color = Colors.brown.shade600,
//       );
//     }
//   }

//   void drawParkingLot(Canvas canvas, double x, double y, double w, double h) {
//     final parkingPaint =
//         Paint()
//           ..color = Color(0xFFEEEEEE)
//           ..style = PaintingStyle.fill;

//     canvas.drawRRect(
//       RRect.fromRectAndRadius(Rect.fromLTWH(x, y, w, h), Radius.circular(4)),
//       parkingPaint,
//     );

//     final borderPaint =
//         Paint()
//           ..color = Color(0xFF9E9E9E)
//           ..strokeWidth = 2
//           ..style = PaintingStyle.stroke;
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(Rect.fromLTWH(x, y, w, h), Radius.circular(4)),
//       borderPaint,
//     );

//     final linePaint =
//         Paint()
//           ..color = Colors.white
//           ..strokeWidth = 2;

//     for (double i = x + 40; i < x + w; i += 80) {
//       canvas.drawLine(Offset(i, y), Offset(i, y + h), linePaint);
//     }

//     drawText(
//       canvas,
//       "P",
//       x + 20,
//       y + 10,
//       Colors.blue.shade700,
//       24,
//       FontWeight.bold,
//     );
//   }

//   void drawGreenZone(Canvas canvas, double x, double y, double w, double h) {
//     final greenPaint =
//         Paint()
//           ..color = Color(0xFFA5D6A7)
//           ..style = PaintingStyle.fill;

//     canvas.drawRRect(
//       RRect.fromRectAndRadius(Rect.fromLTWH(x, y, w, h), Radius.circular(4)),
//       greenPaint,
//     );

//     for (int i = 0; i < 8; i++) {
//       final treeX = x + 50 + i * 70;
//       final treeY = y + h / 2;
//       drawTree(canvas, treeX, treeY);
//     }
//   }

//   void drawTree(Canvas canvas, double x, double y) {
//     final trunkPaint = Paint()..color = Colors.brown.shade700;
//     canvas.drawRect(Rect.fromLTWH(x - 3, y, 6, 20), trunkPaint);

//     final crownPaint = Paint()..color = Color(0xFF66BB6A);
//     canvas.drawCircle(Offset(x, y - 5), 15, crownPaint);
//   }

//   void drawEntranceWithCanopy(
//     Canvas canvas,
//     double x,
//     double y,
//     double w,
//     double h,
//     String label,
//   ) {
//     final canopyPaint =
//         Paint()
//           ..color = Color(0xFF4CAF50)
//           ..style = PaintingStyle.fill;

//     final canopyRect = RRect.fromRectAndRadius(
//       Rect.fromLTWH(x - 10, y - 15, w + 20, h + 15),
//       Radius.circular(6),
//     );
//     canvas.drawRRect(canopyRect, canopyPaint);

//     final entrancePaint =
//         Paint()
//           ..color = Color(0xFF1B5E20)
//           ..style = PaintingStyle.fill;

//     canvas.drawRRect(
//       RRect.fromRectAndRadius(Rect.fromLTWH(x, y, w, h), Radius.circular(4)),
//       entrancePaint,
//     );

//     final glassPaint =
//         Paint()
//           ..color = Color(0xFF81C784).withOpacity(0.5)
//           ..style = PaintingStyle.fill;
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromLTWH(x + 5, y + 5, w - 10, h - 10),
//         Radius.circular(2),
//       ),
//       glassPaint,
//     );

//     if (label.isNotEmpty) {
//       drawText(
//         canvas,
//         label,
//         x + w / 2,
//         y + h / 2 - 7,
//         Colors.white,
//         12,
//         FontWeight.bold,
//       );
//     }
//   }

//   void drawArrow(Canvas canvas, double x, double y, bool horizontal) {
//     final arrowPaint =
//         Paint()
//           ..color = Colors.blue.shade600
//           ..strokeWidth = 3
//           ..strokeCap = StrokeCap.round;

//     if (horizontal) {
//       canvas.drawLine(Offset(x - 15, y), Offset(x + 15, y), arrowPaint);
//       canvas.drawLine(Offset(x + 10, y - 5), Offset(x + 15, y), arrowPaint);
//       canvas.drawLine(Offset(x + 10, y + 5), Offset(x + 15, y), arrowPaint);
//     }
//   }

//   void drawLegend(Canvas canvas) {
//     final legendX = 1300.0;
//     final legendY = 100.0;

//     final legendBg = RRect.fromRectAndRadius(
//       Rect.fromLTWH(legendX, legendY, 200, 180),
//       Radius.circular(8),
//     );
//     canvas.drawRRect(legendBg, Paint()..color = Colors.white.withOpacity(0.95));
//     canvas.drawRRect(
//       legendBg,
//       Paint()
//         ..color = Colors.grey.shade400
//         ..strokeWidth = 2
//         ..style = PaintingStyle.stroke,
//     );

//     drawText(
//       canvas,
//       "ЛЕГЕНДА",
//       legendX + 100,
//       legendY + 15,
//       Colors.black87,
//       14,
//       FontWeight.bold,
//     );

//     drawLegendItem(
//       canvas,
//       legendX + 20,
//       legendY + 45,
//       Color(0xFFFFE0B2),
//       "Магазины",
//     );
//     drawLegendItem(
//       canvas,
//       legendX + 20,
//       legendY + 75,
//       Color(0xFFFFF9C4),
//       "Проходы",
//     );
//     drawLegendItem(
//       canvas,
//       legendX + 20,
//       legendY + 105,
//       Color(0xFFB3E5FC),
//       "Зал",
//     );
//     drawLegendItem(
//       canvas,
//       legendX + 20,
//       legendY + 135,
//       Color(0xFF4CAF50),
//       "Вход",
//     );
//   }

//   void drawLegendItem(
//     Canvas canvas,
//     double x,
//     double y,
//     Color color,
//     String label,
//   ) {
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(Rect.fromLTWH(x, y, 20, 20), Radius.circular(3)),
//       Paint()..color = color,
//     );
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(Rect.fromLTWH(x, y, 20, 20), Radius.circular(3)),
//       Paint()
//         ..color = Colors.grey.shade600
//         ..strokeWidth = 1
//         ..style = PaintingStyle.stroke,
//     );
//     drawText(canvas, label, x + 90, y + 5, Colors.black87, 12);
//   }

//   void drawText(
//     Canvas canvas,
//     String text,
//     double x,
//     double y,
//     Color color, [
//     double fontSize = 12,
//     FontWeight weight = FontWeight.normal,
//   ]) {
//     final textSpan = TextSpan(
//       text: text,
//       style: TextStyle(color: color, fontSize: fontSize, fontWeight: weight),
//     );
//     final textPainter = TextPainter(
//       text: textSpan,
//       textDirection: TextDirection.ltr,
//       textAlign: TextAlign.center,
//     );
//     textPainter.layout();
//     textPainter.paint(canvas, Offset(x - textPainter.width / 2, y));
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

import 'package:flutter/material.dart';

class BoutiquePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Вид сверху как на карте
    final buildingPaint =
        Paint()
          ..color = const Color(0xFFE8E6E3)
          ..style = PaintingStyle.fill;

    final outlinePaint =
        Paint()
          ..color = const Color(0xFFA0A0A0)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    final roofPaint =
        Paint()
          ..color = const Color(0xFFD4D2CF)
          ..style = PaintingStyle.fill;

    final parkingPaint =
        Paint()
          ..color = const Color(0xFFF0F0F0)
          ..style = PaintingStyle.fill;

    final roadPaint =
        Paint()
          ..color = const Color(0xFF808080)
          ..style = PaintingStyle.fill;

    final detailPaint =
        Paint()
          ..color = const Color(0xFF666666)
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke;

    // Основное здание (вид сверху - прямоугольник)
    Rect building = Rect.fromLTWH(50, 50, size.width - 100, size.height - 150);
    canvas.drawRect(building, buildingPaint);
    canvas.drawRect(building, outlinePaint);

    // Крыша (вид сверху - такой же прямоугольник с отступом)
    Rect roof = Rect.fromLTWH(45, 45, size.width - 90, size.height - 140);
    canvas.drawRect(roof, roofPaint);
    canvas.drawRect(roof, outlinePaint);

    // Входная группа (вид сверху)
    final entrancePaint =
        Paint()
          ..color = const Color(0xFF8B7355)
          ..style = PaintingStyle.fill;

    // Главный вход
    Rect entrance = Rect.fromLTWH(
      size.width / 2 - 30,
      size.height - 100,
      60,
      20,
    );
    canvas.drawRect(entrance, entrancePaint);

    // Двери (вид сверху - линии)
    canvas.drawLine(
      Offset(size.width / 2 - 20, size.height - 100),
      Offset(size.width / 2 - 20, size.height - 80),
      detailPaint..strokeWidth = 3,
    );
    canvas.drawLine(
      Offset(size.width / 2 + 20, size.height - 100),
      Offset(size.width / 2 + 20, size.height - 80),
      detailPaint..strokeWidth = 3,
    );

    // Окна (вид сверху - линии по периметру)
    // Передние окна
    canvas.drawLine(
      Offset(70, 70),
      Offset(size.width - 70, 70),
      detailPaint..strokeWidth = 2,
    );
    // Задние окна
    canvas.drawLine(
      Offset(70, size.height - 70),
      Offset(size.width - 70, size.height - 70),
      detailPaint..strokeWidth = 2,
    );
    // Боковые окна
    canvas.drawLine(
      Offset(70, 70),
      Offset(70, size.height - 70),
      detailPaint..strokeWidth = 2,
    );
    canvas.drawLine(
      Offset(size.width - 70, 70),
      Offset(size.width - 70, size.height - 70),
      detailPaint..strokeWidth = 2,
    );

    // Тротуар вокруг здания
    final sidewalkPaint =
        Paint()
          ..color = const Color(0xFFF5F5F5)
          ..style = PaintingStyle.fill;

    Rect sidewalk = Rect.fromLTWH(30, 30, size.width - 60, size.height - 110);
    canvas.drawRect(sidewalk, sidewalkPaint);
    canvas.drawRect(sidewalk, detailPaint);

    // Зеленые зоны (газоны)
    final grassPaint =
        Paint()
          ..color = const Color(0xFFE8F5E8)
          ..style = PaintingStyle.fill;

    // Газон перед зданием
    Rect frontLawn = Rect.fromLTWH(80, 20, size.width - 160, 30);
    canvas.drawRect(frontLawn, grassPaint);
    canvas.drawRect(frontLawn, detailPaint);

    // Газон за зданием
    Rect backLawn = Rect.fromLTWH(80, size.height - 120, size.width - 160, 30);
    canvas.drawRect(backLawn, grassPaint);
    canvas.drawRect(backLawn, detailPaint);

    // Деревья (круги)
    final treePaint =
        Paint()
          ..color = const Color(0xFF8BC34A)
          ..style = PaintingStyle.fill;

    // Деревья перед зданием
    canvas.drawCircle(Offset(100, 35), 8, treePaint);
    canvas.drawCircle(Offset(size.width - 100, 35), 8, treePaint);

    // Деревья на заднем дворе
    canvas.drawCircle(Offset(100, size.height - 105), 8, treePaint);
    canvas.drawCircle(
      Offset(size.width - 100, size.height - 105),
      8,
      treePaint,
    );

    // Название бутика (вид сверху - текст как на карте)
    final textBackgroundPaint =
        Paint()
          ..color = Colors.white.withOpacity(0.9)
          ..style = PaintingStyle.fill;

    Rect textBackground = Rect.fromLTWH(size.width / 2 - 40, 100, 80, 30);
    canvas.drawRect(textBackground, textBackgroundPaint);
    canvas.drawRect(textBackground, detailPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class BazarPage extends StatelessWidget {
  const BazarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Бутик',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF2D5F8B),
        elevation: 2,
      ),
      backgroundColor: const Color(0xFFF8F9FA),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Карта',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: CustomPaint(
                size: const Size(400, 500),
                painter: BoutiquePainter(),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
