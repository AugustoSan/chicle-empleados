import 'package:flutter/material.dart';

class AlertDialogAddDescrptionOrderMenuItem extends StatefulWidget {
  final String indications;
  const AlertDialogAddDescrptionOrderMenuItem({super.key, required this.indications});

  @override
  State<AlertDialogAddDescrptionOrderMenuItem> createState() => _AlertDialogAddDescrptionOrderMenuItemState();
}

class _AlertDialogAddDescrptionOrderMenuItemState extends State<AlertDialogAddDescrptionOrderMenuItem> {
  final controller = TextEditingController();
  final hintText = 'Indicaciones adicionales';

  @override
  void initState() {
    super.initState();
    controller.text = widget.indications;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(hintText, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
        content: TextField(
          controller: controller,
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          autofocus: true,
          // decoration: InputDecoration(hintText: hintText, labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: const Text('Cancelar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: const Text('Aceptar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
        ],
      );
  }
}