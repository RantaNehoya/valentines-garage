class TaskData {
  String title;
  String description;
  String date;
  String priority;
  TaskData(this.title, this.description, this.date, this.priority);
}

List<TaskData> tasklist = [
  TaskData("ben 10", "has an omnitrix", "its hero time",
      "high"),
];
// void main() {
//   runApp(
//     MaterialApp(
//       title: 'Passing Data',
//       home: TodosScreen(
//         todos: List.generate(
//           20,
//           (i) => TaskData(
//               'Todo $i',
//               'A description of what needs to be done for Todo $i',
//               'Department $i',
//               'Members $i'),
//         ),
//       ),
//     ),
//   );
// }
