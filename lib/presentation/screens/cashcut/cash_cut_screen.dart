import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CashCutScreen extends StatefulWidget {
  const CashCutScreen({Key? key}) : super(key: key);

  @override
  State<CashCutScreen> createState() => _CashCutScreenState();
}
class _CashCutScreenState extends State<CashCutScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CashCutProvider>().getAllCashCuts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CashCutViewModel>(
      builder: (context, viewModel, child) {
        return _buildMainContainer(viewModel);
      },
    );
  }
  Widget _buildMainContainer(CashCutViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Corte de caja'),
      ),
      body: Container(
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
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => Navigator.push(context, RouteUtils().getRouteAddCashCut()),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent(CashCutViewModel viewModel) {
    if(viewModel.isLoading && viewModel.cashCuts.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    if (viewModel.hasError) {
      return _buildErrorState(viewModel);
    }

    if (viewModel.cashCuts.isEmpty) {
      return _buildEmptyState();
    }

    return _buildCashCutsList(viewModel.cashCuts);
  }

  Widget _buildErrorState(CashCutViewModel viewModel) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 16),
            Text(
              viewModel.error ?? 'Ocurrió un error inesperado',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.redAccent),
            ),
            const SizedBox(height: 8),
            Text(
              'Por favor, intenta de nuevo.',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => viewModel.loadCashCuts(),
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
            Icons.inbox,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No hay cortes de caja disponibles',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      )
    );
  }

  Widget _buildCashCutsList(List<CashCut> cashCuts) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: RefreshIndicator(
        onRefresh: () async {
          await context.read<CashCutViewModel>().refresh();
        },
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: cashCuts.length,
          itemBuilder: (context, index) {
            final cashCut = cashCuts[index];
            return CardCashCutCustom(
              item: cashCut,
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 1),
        ),
      ), 
    );
  }

  Widget _buildHeader(CashCutViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Cortes de caja',
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

  Widget _buildRefreshButton(CashCutViewModel viewModel) {
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
}
