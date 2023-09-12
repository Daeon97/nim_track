// ignore_for_file: public_member_api_docs

import 'package:flutter/services.dart';
import 'package:nim_track/core/resources/colors.dart';
import 'package:nim_track/core/resources/numbers.dart';

// extension MapboxConvenienceUtils on MapboxMap {
//   Future<PointAnnotationManager> addMarker({
//     required num lng,
//     required num lat,
//     required String imagePath,
//   }) async {
//     final pointAnnotationManager =
//         await annotations.createPointAnnotationManager();
//     await pointAnnotationManager.create(
//       PointAnnotationOptions(
//         geometry: Point(
//           coordinates: Position(
//             lng,
//             lat,
//           ),
//         ).toJson(),
//         image: (await rootBundle.load(
//           imagePath,
//         ))
//             .buffer
//             .asUint8List(),
//       ),
//     );
//
//     return pointAnnotationManager;
//   }
//
//   Future<PolylineAnnotationManager> drawPolyline({
//     required List<List<num>> lngLats,
//   }) async {
//     final polylineAnnotationManager =
//         await annotations.createPolylineAnnotationManager();
//     await polylineAnnotationManager.create(
//       PolylineAnnotationOptions(
//         geometry: MultiPoint(
//           coordinates: lngLats
//               .map(
//                 (lngLat) => Position(
//                   lngLat.first,
//                   lngLat.last,
//                 ),
//               )
//               .toList(),
//         ).toJson(),
//         lineColor: availableNodesColor.value,
//         lineJoin: LineJoin.ROUND,
//         lineWidth: veryTinySpacing + tinySpacing,
//       ),
//     );
//
//     return polylineAnnotationManager;
//   }
//
//   Future<PolygonAnnotationManager> drawPolygon({
//     required List<List<num>> lngLats,
//     required Color fillColor,
//   }) async {
//     final polygonAnnotationManager =
//         await annotations.createPolygonAnnotationManager();
//     await polygonAnnotationManager.create(
//       PolygonAnnotationOptions(
//         geometry: Polygon(
//           coordinates: [
//             lngLats
//                 .map(
//                   (lngLat) => Position(
//                     lngLat.first,
//                     lngLat.last,
//                   ),
//                 )
//                 .toList(),
//           ],
//         ).toJson(),
//         fillOutlineColor: fillColor.value,
//         fillColor: fillColor.value,
//       ),
//     );
//
//     return polygonAnnotationManager;
//   }
//
//   Future<void> easeToBounds({
//     required List<List<num>> lngLats,
//   }) async {
//     final cameraOptions = await cameraForCoordinates(
//       lngLats
//           .map(
//             (lngLat) => Point(
//               coordinates: Position(
//                 lngLat.first,
//                 lngLat.last,
//               ),
//             ).toJson(),
//           )
//           .toList(),
//       MbxEdgeInsets(
//         top: veryLargeSpacing,
//         left: veryLargeSpacing + veryLargeSpacing,
//         bottom: veryLargeSpacing,
//         right: veryLargeSpacing + veryLargeSpacing,
//       ),
//       null,
//       null,
//     );
//
//     await easeTo(
//       cameraOptions,
//       null,
//     );
//
//     return;
//   }
// }
