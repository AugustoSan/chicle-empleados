// import 'package:chicle_app_empleados/presentation/presentation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SearchBarCustomer extends StatefulWidget {
//   const SearchBarCustomer({super.key});

//   @override
//   State<SearchBarCustomer> createState() => _SearchBarCustomerState();
// }

// class _SearchBarCustomerState extends State<SearchBarCustomer> {
//   bool isDark = false;

//   @override
//   Widget build(BuildContext context) {
//     final listCustomers = context.watch<CustomerProvider>().customers;
//     return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SearchAnchor(
//             builder: (BuildContext context, SearchController controller) {
//               return SearchBar(
//                 controller: controller,
//                 padding: const WidgetStatePropertyAll<EdgeInsets>(
//                   EdgeInsets.symmetric(horizontal: 16.0),
//                 ),
//                 onTap: () {
//                   controller.openView();
//                 },
//                 onChanged: (_) {
//                   controller.openView();
//                 },
//                 leading: const Icon(Icons.search),
//               );
//             },
//             suggestionsBuilder: (BuildContext context, SearchController controller) {
//               return List<ListTile>.generate(listCustomers.length, (int index) {
//                 final String item = listCustomers[index].name;
//                 return ListTile(
//                   title: Text(item),
//                   onTap: () {
//                     setState(() {
//                       controller.closeView(item);
//                     });
//                   },
//                 );
//               });
//             },
//           ),
//         );
//   }
// }