
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:chicle_app_empleados/presentation/screens/settings/settings.dart';
import 'package:chicle_app_empleados/theme_data.dart';
// import 'package:chicle_app_empleados/presentation/screens/modules/update_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
import '../../domain/domain.dart';

class CardUserCustomPortrait extends StatelessWidget {
  final User item;
  final bool isCurrentUser;
  final bool isAdmin;
  final VoidCallback reload;
  const CardUserCustomPortrait({super.key, required this.item, this.isCurrentUser = false, this.isAdmin = false, required this.reload});

  @override
  Widget build(BuildContext context) {
    print('CardUserCustomPortrait: ${item.id}');
    return Container(
        // margin: const EdgeInsets.only(bottom: 12),
        // padding: const EdgeInsets.all(12),
        child: ListTile(
          leading: CircleAvatar(child: Text(item.username[0], style: const TextStyle(fontSize: 20))),
          title: Text(item.username),
          subtitle: Text('@${item.username}'),
          trailing: isCurrentUser ? IconButton(
            icon: const Icon(ChicleIcons.edit),
            onPressed: () {
              if(isCurrentUser) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
              }
            },
          ) : isAdmin ? IconButton(
            icon: const Icon(ChicleIcons.delete, color: Colors.red),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Confirmar eliminación'),
                  content: Text('¿Estás seguro de que deseas eliminar al usuario "${item.username}"?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () async {
                        final success = await context.read<UserProvider>().deleteUser(user: item);
                        Navigator.pop(context); // Cerrar el diálogo
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Usuario "${item.username}" eliminado correctamente')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error al eliminar al usuario "${item.username}"')),
                          );
                        }
                        reload();
                      },
                      child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ) : const SizedBox.shrink(),
        ),
      );
  }
}