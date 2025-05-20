import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:chicle_app_empleados/presentation/screens/info/acerca_de.dart';
import 'package:chicle_app_empleados/presentation/screens/settings/company_screen.dart';
// import 'package:chicle_app_empleados/presentation/screens/settings/users_screen.dart';
import 'package:flutter/material.dart';
// import 'package:chicle_app_empleados/presentation/presentation.dart';
// import 'package:provider/provider.dart';


// import '../../../domain/domain.dart';
// import '../../providers/providers.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final users = DrawerMenuItems.users;
    final company = DrawerMenuItems.companySettings;
    final acercaDe = DrawerMenuItems.acercaDe;
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
                 ListTile(
                  title: Text(users.title),
                  leading: Icon(users.icon),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.pushNamed(context, '/users');
                    },
                  ),
                  ListTile(
                    title: Text(company.title),
                    leading: Icon(company.icon),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyScreen())),
                  ),
                  ListTile(
                    title: Text(acercaDe.title),
                    leading: Icon(acercaDe.icon),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AcercaDeScreen())),
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