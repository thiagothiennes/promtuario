import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:promt/features/agenda/presentation/viewmodels/appointment_viewmodel.dart';
import 'package:promt/features/patients/presentation/viewmodels/patient_viewmodel.dart';
import 'package:promt/features/users/presentation/viewmodels/user_management_viewmodel.dart';
import 'package:promt/features/procedures/presentation/viewmodels/clinics_viewmodel.dart';
import 'package:promt/features/procedures/presentation/viewmodels/procedures_viewmodel.dart';
import 'package:promt/features/agenda/domain/entities/appointment.dart';
import 'package:promt/features/auth/domain/entities/user.dart';

/// Tela para criação de novos agendamentos na agenda clínica.
class AddAppointmentScreen extends ConsumerStatefulWidget {
  const AddAppointmentScreen({super.key});

  @override
  ConsumerState<AddAppointmentScreen> createState() => _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends ConsumerState<AddAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  
  String? _selectedPatientId;
  String? _selectedPatientName;
  String? _selectedDoctorId;
  String? _selectedDoctorName;
  String? _selectedClinicId;
  String? _selectedProcedureName;
  
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 8, minute: 0);
  int _durationMinutes = 30;
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final patientsAsync = ref.watch(patientViewModelProvider);
    final usersAsync = ref.watch(userManagementViewModelProvider);
    final clinicsAsync = ref.watch(clinicsViewModelProvider);
    final proceduresAsync = ref.watch(proceduresViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Agendamento'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              clinicsAsync.when(
                data: (clinics) => DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Clínica / Especialidade', prefixIcon: Icon(Icons.account_balance)),
                  items: clinics.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
                  onChanged: (val) => setState(() => _selectedClinicId = val),
                  validator: (v) => v == null ? 'Obrigatório' : null,
                ),
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const Text('Erro ao carregar clínicas'),
              ),
              const SizedBox(height: 16),

              patientsAsync.when(
                data: (patients) => DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Paciente', prefixIcon: Icon(Icons.person_outline)),
                  items: patients.map((p) => DropdownMenuItem(value: p.id, child: Text(p.fullName))).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedPatientId = val;
                      _selectedPatientName = patients.firstWhere((p) => p.id == val).fullName;
                    });
                  },
                  validator: (v) => v == null ? 'Obrigatório' : null,
                ),
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const Text('Erro ao carregar pacientes'),
              ),
              const SizedBox(height: 16),

              usersAsync.when(
                data: (users) {
                  final professionals = users.where((u) => u.role == UserRole.professor || u.role == UserRole.aluno).toList();
                  return DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Profissional Responsável', prefixIcon: Icon(Icons.medical_services_outlined)),
                    items: professionals.map((u) => DropdownMenuItem(value: u.id, child: Text('${u.name} (${u.role.displayName})'))).toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedDoctorId = val;
                        _selectedDoctorName = professionals.firstWhere((u) => u.id == val).name;
                      });
                    },
                    validator: (v) => v == null ? 'Obrigatório' : null,
                  );
                },
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const Text('Erro ao carregar profissionais'),
              ),
              const SizedBox(height: 16),

              proceduresAsync.when(
                data: (procedures) => DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Procedimento', prefixIcon: Icon(Icons.list_alt)),
                  items: procedures.map((p) => DropdownMenuItem(value: p.name, child: Text(p.name))).toList(),
                  onChanged: (val) => setState(() => _selectedProcedureName = val),
                  validator: (v) => v == null ? 'Obrigatório' : null,
                ),
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const Text('Erro ao carregar procedimentos'),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Data'),
                      subtitle: Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (picked != null) setState(() => _selectedDate = picked);
                      },
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Hora Início'),
                      subtitle: Text(_startTime.format(context)),
                      trailing: const Icon(Icons.access_time),
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: _startTime,
                        );
                        if (picked != null) setState(() => _startTime = picked);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<int>(
                value: _durationMinutes,
                decoration: const InputDecoration(labelText: 'Duração estimada'),
                items: const [
                  DropdownMenuItem(value: 30, child: Text('30 minutos')),
                  DropdownMenuItem(value: 60, child: Text('1 hora')),
                  DropdownMenuItem(value: 90, child: Text('1 hora e 30 min')),
                  DropdownMenuItem(value: 120, child: Text('2 horas')),
                ],
                onChanged: (val) => setState(() => _durationMinutes = val!),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Observações Clínicas', border: OutlineInputBorder()),
                maxLines: 3,
              ),
              const SizedBox(height: 32),

              FilledButton(
                onPressed: _saveAppointment,
                style: FilledButton.styleFrom(padding: const EdgeInsets.all(16)),
                child: const Text('Confirmar Agendamento', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveAppointment() {
    if (_formKey.currentState!.validate()) {
      final start = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _startTime.hour,
        _startTime.minute,
      );
      final end = start.add(Duration(minutes: _durationMinutes));

      final appointment = Appointment(
        id: const Uuid().v4(),
        patientId: _selectedPatientId!,
        patientName: _selectedPatientName!,
        doctorId: _selectedDoctorId!,
        doctorName: _selectedDoctorName!,
        startTime: start,
        endTime: end,
        status: AppointmentStatus.scheduled,
        procedureName: _selectedProcedureName,
        notes: _notesController.text,
        clinicId: _selectedClinicId!,
      );

      ref.read(appointmentViewModelProvider.notifier).schedule(appointment).then((_) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Consulta agendada com sucesso!'), behavior: SnackBarBehavior.floating),
        );
      });
    }
  }
}
