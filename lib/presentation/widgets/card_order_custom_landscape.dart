
import 'package:chicle_app_empleados/presentation/presentation.dart';
// import 'package:chicle_app_empleados/presentation/screens/modules/update_menu.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import '../../domain/domain.dart';

class CardOrderCustomLandscape extends StatelessWidget {
  final Order item;
  const CardOrderCustomLandscape({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // final navigatorKey = context.watch<ShellNavigatorController>();
    return InkWell(
                onLongPress: () => mostrarSaleDialog(context, item),
                child: Container(
                  // margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text('Orden: # ${item.id.toString()}'),
                          ),
                          Text(
                            item.status.name.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              color: item.status == EnumOrderStatus.completed
                                  ? Colors.green
                                  : item.status == EnumOrderStatus.pending
                                      ? Colors.red
                                      : Colors.black,
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              PriceUtils.getStringPrice(item.total),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          Text(
                            DateUtil.formatDateTime(item.date),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
  }
}