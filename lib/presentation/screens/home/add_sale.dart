// // import 'package:chicle_app_empleados/domain/domain.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../presentation.dart';

// class AddSaleScreen extends StatelessWidget {
//   const AddSaleScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final vm = context.watch<AddSaleController>();
//     final listCustomers = context.watch<CustomerProvider>().customers;
//     print('listCustomers: ${listCustomers}');
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Nueva orden'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SafeArea(
//           child: Form(
//             key: vm.formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     height:500,
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: ListView(
//                             children: [
//                               const SizedBox(height: 12),
//                               TextFormField(
//                                 controller: vm.nameC,
//                                 decoration: const InputDecoration(labelText: 'Nombre del cliente'),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Nombre inválido';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                               const SizedBox(height: 12),
//                             ],
//                           ),
//                         ),
//                         Center(
//                           child: ElevatedButton(
//                             onPressed: () async {
//                               final res = await vm.saveSale(context, _items);
//                               if (res != '') {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(content: Text(res)),
//                                 );
//                                 return;
//                               }
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text('Guardado ✔️')),
//                               );
//                               Navigator.pop(context);
//                             },
//                             child: const Text('Siguiente'),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//   }
// }