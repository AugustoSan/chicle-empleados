import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';

class OrdersPortrait extends StatefulWidget {
  const OrdersPortrait({Key? key}) : super(key: key);

  @override
  State<OrdersPortrait> createState() => _OrdersPortraitState();
}

class _OrdersPortraitState extends State<OrdersPortrait> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().loadAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrdersViewModel>(
      builder: (context, viewModel, child) {
        return _buildMainContainer(viewModel);
      }
    );
  }

  Widget _buildMainContainer(OrdersViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header con título y botón de refresh
          _buildHeader(viewModel),
          // Contenido principal
          Expanded(
            child: _buildContent(viewModel),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(OrdersViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Órdenes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Botón de refresh con indicador de carga
          _buildRefreshButton(viewModel),
        ],
      ),
    );
  }

  Widget _buildRefreshButton(OrdersViewModel viewModel) {
    return IconButton(
      icon: viewModel.isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.refresh),
      onPressed: viewModel.isLoading ? null : () => viewModel.refresh(),
      tooltip: 'Actualizar',
    );
  }

  Widget _buildContent(OrdersViewModel viewModel) {
    if (viewModel.isLoading && viewModel.orders.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.hasError) {
      return _buildErrorState(viewModel);
    }

    if (viewModel.orders.isEmpty) {
      return _buildEmptyState();
    }

    return _buildOrdersList(viewModel.orders);
  }

  Widget _buildErrorState(OrdersViewModel viewModel) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Error al cargar órdenes',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              viewModel.error ?? 'Error desconocido',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => viewModel.loadOrders(),
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No hay órdenes',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Las órdenes aparecerán aquí',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<Order> orders) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: RefreshIndicator(
        onRefresh: () async {
          await context.read<OrdersViewModel>().refresh();
        },
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            print('Building order item: ${order.id}');
            print('Order details: $order');
            print('Estatus: ${order.status}');
            print('EstatusCashCut: ${order.statusCashCut}');
            return CardOrderCustomPortrait(
              item: order,
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 1),
        ),
      ),
    );
  }

}