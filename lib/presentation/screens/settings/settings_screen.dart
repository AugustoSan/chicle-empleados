import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:chicle_app_empleados/presentation/screens/settings/company_screen.dart';
import 'package:chicle_app_empleados/presentation/screens/settings/profile_screen.dart';
// import 'package:chicle_app_empleados/presentation/screens/settings/users_screen.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final users = DrawerProducts.users;
    final company = DrawerProducts.companySettings;
    final acercaDe = DrawerProducts.acercaDe;
    final profile = DrawerProducts.profile;
    final isAdmin = context.read<AuthProvider>().isAdmin;
    print('isAdmin: ${isAdmin}');
    return SafeArea(
      child: Column(
        children: [
          const HeaderCustom(title: 'Configuración', onBack: false),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            height: 320,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListView(
              children: [
                ListTile(
                  title: Text(profile.title),
                  leading: Icon(profile.icon),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen())),
                ),
                isAdmin
                    ? ListTile(
                        title: Text(users.title),
                        leading: Icon(users.icon),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                      Navigator.pushNamed(context, '/users');
                    },
                  ) : const SizedBox.shrink(),
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
                  PrivacyTile(),
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