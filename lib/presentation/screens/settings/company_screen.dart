import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


import '../../../domain/domain.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});
  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
} 

class _CompanyScreenState extends State<CompanyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameC = TextEditingController();
  final _currencyC = TextEditingController();
  final _taxC = TextEditingController();
  String? _logoC = null;
  BusinessType _selectedType = BusinessType.cafeteria;

  @override
  void initState() {
    super.initState();
    // Carga inicial desde el provider
    final biz = context.read<BusinessProvider>().business;
    if (biz != null) {
      _nameC.text     = biz.name;
      _currencyC.text = biz.currency;
      _taxC.text      = biz.taxPercent.toString();
      _selectedType   = biz.type;
      _logoC          = biz.logo;
    }
  }

  Future<void> _saveLogo() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if(image != null){
      setState(() {
        _logoC = image.path;
      });
    }
  }

  @override
  void dispose() {
    _nameC.dispose();
    _currencyC.dispose();
    _taxC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Negocio'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height:500,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              ContainerAddPicture(onSaveImage: _saveLogo, rutaImagen: _logoC),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: _nameC,
                                decoration: const InputDecoration(labelText: 'Nombre del negocio'),
                                validator: (v) => v != null && v.isNotEmpty
                                    ? null
                                    : 'Nombre del negocio inválido',
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: _currencyC,
                                decoration: const InputDecoration(labelText: 'Moneda'),
                                validator: (v) =>
                                    v != null && v.isNotEmpty ? null : 'Moneda inválida',
                                    ),
                                    const SizedBox(height: 12),
                                    TextFormField(
                                      controller: _taxC,
                                      decoration: const InputDecoration(labelText: 'Porcentaje de IVA'),
                                      keyboardType: TextInputType.number,
                                      validator: (v) {
                                        if (v == null || v.isEmpty) return 'IVA requerido';
                                        if (double.tryParse(v) == null) return 'Debe ser un número';
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 12),
                                    DropdownButtonFormField<BusinessType>(
                                      value: _selectedType,
                                      decoration: const InputDecoration(labelText: 'Tipo de negocio'),
                                      items: BusinessType.values.map((t) =>
                                        DropdownMenuItem(value: t, child: Text(t.name))
                                      ).toList(),
                                      onChanged: (t) {
                                        if (t != null) setState(() => _selectedType = t);
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                ),
                              ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final business = Business(
                                  name: _nameC.text.trim(),
                                  currency: _currencyC.text.trim(),
                                  taxPercent: double.parse(_taxC.text.trim()),
                                  type: _selectedType,
                                  enabledModules: [],
                                  logo: _logoC,
                                );
                                context.read<BusinessProvider>().saveBusiness(business);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Guardado ✔️')),
                                );
                              }
                            },
                            child: const Text('Guardar'),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      );
  }

}
