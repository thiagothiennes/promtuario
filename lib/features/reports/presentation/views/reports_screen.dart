import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../viewmodels/reports_viewmodel.dart';
import '../../domain/entities/report_data.dart';

/// Tela de Relatórios e Indicadores de Gestão.
/// Integrada ao ReportsViewModel para dados reais e filtragem por período.
class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsAsync = ref.watch(reportsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatórios & Indicadores'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(reportsViewModelProvider.notifier).refresh(),
          ),
          IconButton(
            icon: const Icon(Icons.download_outlined),
            tooltip: 'Exportar PDF',
            onPressed: () => _exportReport(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: reportsAsync.when(
        data: (metrics) => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPeriodSelector(context, ref, reportsAsync),
              const SizedBox(height: 32),
              if (metrics != null) _buildSummaryGrid(metrics),
              const SizedBox(height: 32),
              if (metrics != null) _buildChartSection(context, metrics.growthHistory),
              const SizedBox(height: 32),
              // TODO: _buildDetailedTable precisa ser implementado ou removido
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Erro ao carregar dados: $err')),
      ),
    );
  }

  Widget _buildPeriodSelector(BuildContext context, WidgetRef ref, AsyncValue<ClinicPerformanceMetrics?> state) {
    final df = DateFormat('dd/MM/yyyy');
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.date_range, color: Color(0xFF006494)),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Período Analisado:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                if (state.value != null)
                  Text('${df.format(state.value!.startDate)} até ${df.format(state.value!.endDate)}'),
              ],
            ),
            const Spacer(),
            FilledButton.tonalIcon(
              onPressed: () => _selectDateRange(context, ref, state),
              icon: const Icon(Icons.filter_alt_outlined),
              label: const Text('Alterar Período'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDateRange(BuildContext context, WidgetRef ref, AsyncValue<ClinicPerformanceMetrics?> state) async {
    if (state.value == null) return;
    final picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: state.value!.startDate, end: state.value!.endDate),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      // TODO: Implement updatePeriod no viewmodel se necessário
    }
  }

  Widget _buildSummaryGrid(ClinicPerformanceMetrics metrics) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: MediaQuery.of(null).size.width > 800 ? 3 : 1,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 2.5,
      children: [
        _reportStat('Atendimentos', '${metrics.totalProceduresThisMonth}', Icons.assignment_turned_in, Colors.blue),
        _reportStat('Taxa de Ocupação', '${(metrics.occupancyRate * 100).toStringAsFixed(1)}%', Icons.pie_chart, Colors.orange),
        _reportStat('Índice de Faltas', '${(metrics.absenceRate * 100).toStringAsFixed(1)}%', Icons.person_off, Colors.red),
      ],
    );
  }

  Widget _reportStat(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartSection(BuildContext context, List<MonthlyGrowth> growthData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Evolução Mensal', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: growthData.map((d) => _buildBar(context, d)).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBar(BuildContext context, MonthlyGrowth data) {
    // Cálculo simples de altura para o gráfico de barras
    final double height = (data.count * 2.0).clamp(10, 150);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Tooltip(
          message: '${data.count} atendimentos',
          child: Container(
            width: 40,
            height: height,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(data.month, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildDetailedTable(BuildContext context, List<SpecialtyProduction> production) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Produção Detalhada por Especialidade', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Card(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Especialidade')),
                DataColumn(label: Text('Qtd')),
                DataColumn(label: Text('Valor Total')),
                DataColumn(label: Text('Eficiência')),
              ],
              rows: production.map((p) => DataRow(cells: [
                DataCell(Text(p.specialty)),
                DataCell(Text(p.appointmentCount.toString())),
                DataCell(Text(NumberFormat.currency(symbol: 'R\$').format(p.totalValue))),
                DataCell(Text('${(p.efficiencyRate * 100).toStringAsFixed(0)}%')),
              ])).toList(),
            ),
          ),
        ),
      ],
    );
  }

  void _exportReport(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Gerando arquivo PDF consolidado...'), behavior: SnackBarBehavior.floating),
    );
  }
}
