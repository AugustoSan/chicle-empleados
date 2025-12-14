
import 'package:chicle_app_empleados/presentation/presentation.dart';
// import 'package:chicle_app_empleados/presentation/screens/modules/update_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
import '../../domain/domain.dart';

class CardCashCutCustom extends StatefulWidget {
  final CashCut item;
  const CardCashCutCustom({Key? key, required this.item}) : super(key: key);

  @override
  State<CardCashCutCustom> createState() => _CardCashCutCustomState();
}
class _CardCashCutCustomState extends State<CardCashCutCustom> {

  String userName = 'Sin nombre';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    try {
      final userProvider = context.read<UserProvider>();
      final user = await userProvider.findUserById( widget.item.userId);
      if (user != null) {
        setState(() {
          userName = user.username;
        });
      }
    } catch (e) {
      print('Error loading user name: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    print('CardCashCutCustom: ${item.id}');
    return Container(
        // margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Id: # ${StringUtil.hideMiddle(item.id)}'),
            const SizedBox(height: 4),
            Text('Usuario: ${userName}'),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Diferencia: ${PriceUtils.getStringPrice(item.difference)}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                Text(
                  'Fecha: ${DateUtil.formatDateTime(item.date)}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      );
  }
}