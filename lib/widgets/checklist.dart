// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
//
// class Checklist extends StatefulWidget {
//   const Checklist(
//       {required this.color, required this.title, required this.time});
//   final Color color;
//   final String title;
//   final DateTime time;
//
//   @override
//   State<Checklist> createState() => _ChecklistState(color, title, time);
// }
//
// class _ChecklistState extends State<Checklist> {
//   _ChecklistState(Color color, String title, DateTime time);
//
//   @override
//   Widget build(BuildContext context) {
//     return Slidable(
//       actionPane: SlidableDrawerActionPane(),
//       actionExtentRatio: 0.3,
//       child: Container(
//           height: 80,
//           margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           decoration: BoxDecoration(color: Colors.white, boxShadow: [
//             BoxShadow(
//                 color: Colors.black.withOpacity(0.03),
//                 offset: Offset(0, 9),
//                 blurRadius: 20,
//                 spreadRadius: 1)
//           ]),
//           child: Row(
//             children: [
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 20),
//                 height: 25,
//                 width: 25,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                     border: Border.all(color: color, width: 4)),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(color: Colors.black, fontSize: 18),
//                   ),
//                   Text(
//                     time.toString(),
//                     style: TextStyle(color: Colors.grey, fontSize: 18),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: Container(),
//               ),
//               Container(
//                 height: 50,
//                 width: 5,
//                 color: color,
//               ),
//             ],
//           )),
//       secondaryActions: [
//         IconSlideAction(
//           caption: "Edit",
//           color: Colors.white,
//           icon: Icons.edit,
//           onTap: () {
//             // open edit_task page
//           },
//         ),
//         IconSlideAction(
//           caption: "Delete",
//           color: color,
//           icon: Icons.delete,
//           onTap: () {
//             //remove TaskData at that index
//             setState(() {});
//           },
//         )
//       ],
//     );
//   }
// }
