class TaskData {
  String title;
  String description;
  List department;
  String date;
  List added_members;

  TaskData(this.title, this.description, this.department, this.date,
      this.added_members);
}

List<TaskData> tasklist = [
  TaskData("ben 10", "has an omnitrix", ["plumber"], "its hero time",
      ["gwen tennyson", "max tennyson"]),
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
