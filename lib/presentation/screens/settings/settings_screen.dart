import 'package:chicle_app_empleados/presentation/screens/settings/company_screen.dart';
import 'package:flutter/material.dart';
// import 'package:chicle_app_empleados/presentation/presentation.dart';
// import 'package:provider/provider.dart';


// import '../../../domain/domain.dart';
// import '../../providers/providers.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListView(
              children: [
                const ListTile(
                  title: Text('Perfil'),
                  leading: Icon(Icons.person),
                    trailing: Icon(Icons.arrow_forward_ios),
                    // onTap: () => Navigator.pushNamed(context, '/company'),
                  ),
                  ListTile(
                    title: Text('Negocio'),
                    leading: Icon(Icons.business),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyScreen())),
                  ),
                  const ListTile(
                    title: Text('Acerca de'),
                    leading: Icon(Icons.info),
                    trailing: Icon(Icons.arrow_forward_ios),
                    // onTap: () => Navigator.pushNamed(context, '/company'),
                  ),
                ],
              ),
            ),
          // Expanded(
          //   child: Container(),
          // )
        ],
      ),
    );
  }
}