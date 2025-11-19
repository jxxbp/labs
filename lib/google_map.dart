import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

class BazaarMapWidget extends StatefulWidget {
  const BazaarMapWidget({super.key});

  @override
  State<BazaarMapWidget> createState() => _BazaarMapWidgetState();
}

class _BazaarMapWidgetState extends State<BazaarMapWidget> {
  GoogleMapController? _controller;
  Set<Polygon> _polygons = {};
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};
  GroundOverlay? _groundOverlay;

  // Координаты центра базара
  static const LatLng bazaarCenter = LatLng(47.1081, 51.9125); // Атырау

  @override
  void initState() {
    super.initState();
    _createBazaarElements();
  }

  // Создание элементов базара
  void _createBazaarElements() {
    _createShopPolygons();
    _createPathways();
    _createMarkers();
  }

  // Создание контуров магазинов/бутиков
  void _createShopPolygons() {
    _polygons = {
      // Магазин 1 - Фрукты
      Polygon(
        polygonId: const PolygonId('shop1'),
        points: [
          LatLng(47.1085, 51.9120),
          LatLng(47.1085, 51.9125),
          LatLng(47.1082, 51.9125),
          LatLng(47.1082, 51.9120),
        ],
        fillColor: Colors.green.withOpacity(0.3),
        strokeColor: Colors.green,
        strokeWidth: 2,
        consumeTapEvents: true,
        onTap: () => _showShopInfo('Фрукты и овощи', 'Магазин №1'),
      ),

      // Магазин 2 - Мясо
      Polygon(
        polygonId: const PolygonId('shop2'),
        points: [
          LatLng(47.1085, 51.9126),
          LatLng(47.1085, 51.9131),
          LatLng(47.1082, 51.9131),
          LatLng(47.1082, 51.9126),
        ],
        fillColor: Colors.red.withOpacity(0.3),
        strokeColor: Colors.red,
        strokeWidth: 2,
        consumeTapEvents: true,
        onTap: () => _showShopInfo('Мясная лавка', 'Магазин №2'),
      ),

      // Магазин 3 - Специи
      Polygon(
        polygonId: const PolygonId('shop3'),
        points: [
          LatLng(47.1080, 51.9120),
          LatLng(47.1080, 51.9125),
          LatLng(47.1077, 51.9125),
          LatLng(47.1077, 51.9120),
        ],
        fillColor: Colors.orange.withOpacity(0.3),
        strokeColor: Colors.orange,
        strokeWidth: 2,
        consumeTapEvents: true,
        onTap: () => _showShopInfo('Специи и приправы', 'Магазин №3'),
      ),

      // Магазин 4 - Рыба
      Polygon(
        polygonId: const PolygonId('shop4'),
        points: [
          LatLng(47.1080, 51.9126),
          LatLng(47.1080, 51.9131),
          LatLng(47.1077, 51.9131),
          LatLng(47.1077, 51.9126),
        ],
        fillColor: Colors.blue.withOpacity(0.3),
        strokeColor: Colors.blue,
        strokeWidth: 2,
        consumeTapEvents: true,
        onTap: () => _showShopInfo('Свежая рыба', 'Магазин №4'),
      ),

      // Центральная площадь
      Polygon(
        polygonId: const PolygonId('central'),
        points: [
          LatLng(47.1082, 51.9121),
          LatLng(47.1082, 51.9130),
          LatLng(47.1077, 51.9130),
          LatLng(47.1077, 51.9121),
        ],
        fillColor: Colors.grey.withOpacity(0.1),
        strokeColor: Colors.grey,
        strokeWidth: 1,
      ),
    };
  }

  // Создание дорожек/проходов
  void _createPathways() {
    _polylines = {
      // Главная аллея
      Polyline(
        polylineId: const PolylineId('main_path'),
        points: [LatLng(47.1090, 51.9125), LatLng(47.1075, 51.9125)],
        color: Colors.brown,
        width: 8,
        patterns: [PatternItem.dash(20), PatternItem.gap(10)],
      ),

      // Боковая дорожка 1
      Polyline(
        polylineId: const PolylineId('side_path1'),
        points: [LatLng(47.1081, 51.9118), LatLng(47.1081, 51.9132)],
        color: Colors.brown.withOpacity(0.7),
        width: 5,
      ),

      // Боковая дорожка 2
      Polyline(
        polylineId: const PolylineId('side_path2'),
        points: [LatLng(47.1086, 51.9118), LatLng(47.1086, 51.9132)],
        color: Colors.brown.withOpacity(0.7),
        width: 5,
      ),
    };
  }

  // Создание маркеров
  Future<void> _createMarkers() async {
    final markers = <Marker>{};

    // Вход на базар
    markers.add(
      Marker(
        markerId: const MarkerId('entrance'),
        position: LatLng(47.1090, 51.9125),
        icon: await _createCustomMarker('🚪', Colors.blue),
        infoWindow: const InfoWindow(
          title: 'Главный вход',
          snippet: 'Добро пожаловать на базар',
        ),
      ),
    );

    setState(() {
      _markers = markers;
    });
  }

  // Создание кастомного маркера с эмодзи
  Future<BitmapDescriptor> _createCustomMarker(
    String emoji,
    Color backgroundColor,
  ) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    const size = Size(100, 100);

    // Фон
    final paint = Paint()..color = backgroundColor;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 40, paint);

    // Белая обводка
    final strokePaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 40, strokePaint);

    // Эмодзи
    final textPainter = TextPainter(
      text: TextSpan(text: emoji, style: const TextStyle(fontSize: 40)),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2,
      ),
    );

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final buffer = byteData!.buffer.asUint8List();

    return BitmapDescriptor.bytes(buffer);
  }

  // Показать информацию о магазине
  void _showShopInfo(String name, String number) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(number, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                const Text('Режим работы: 08:00 - 20:00'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Закрыть'),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: bazaarCenter,
              zoom: 17.5,
              tilt: 45,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            polygons: _polygons,
            polylines: _polylines,
            markers: _markers,
            mapType: MapType.satellite,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            compassEnabled: true,
          ),
        ],
      ),

      // Кнопки управления
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'zoom_in',
            mini: true,
            onPressed: () {
              _controller?.animateCamera(CameraUpdate.zoomIn());
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'zoom_out',
            mini: true,
            onPressed: () {
              _controller?.animateCamera(CameraUpdate.zoomOut());
            },
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              border: Border.all(color: color, width: 2),
            ),
          ),
          const SizedBox(width: 5),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
