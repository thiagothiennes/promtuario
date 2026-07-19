import 'package:drift/drift.dart';
import '../../../core/network/api_client.dart';
import '../../../core/database/local_database.dart';
import '../../domain/entities/patient.dart';
import '../../domain/repositories/i_patient_repository.dart';

/// Implementação do Repositório de Pacientes.
/// Gerencia a sincronização entre a API remota e o Banco de Dados local (SQLite).
class PatientRepository implements IPatientRepository {
  final ApiClient _apiClient;
  final AppDatabase _localDb;

  PatientRepository(this._apiClient, this._localDb);

  @override
  Future<List<Patient>> getPatients({int page = 1, String? query}) async {
    try {
      final response = await _apiClient.instance.get('/patients', queryParameters: {
        'page': page,
        'search': query,
      });

      final List<dynamic> data = response.data['items'];
      final patients = data.map((json) => _mapJsonToEntity(json)).toList();

      // Atualiza o cache local de forma assíncrona
      _updateLocalCache(patients);

      return patients;
    } catch (e) {
      // Em caso de falha na rede, busca no cache local
      return getLocalPatients();
    }
  }

  @override
  Future<Patient> getPatientById(String id) async {
    final response = await _apiClient.instance.get('/patients/$id');
    return _mapJsonToEntity(response.data);
  }

  @override
  Future<Patient> createPatient(Patient patient) async {
    try {
      final response = await _apiClient.instance.post('/patients', data: _mapEntityToJson(patient));
      final newPatient = _mapJsonToEntity(response.data);
      
      // Salva no banco local como sincronizado
      await _saveLocal(newPatient, true);
      return newPatient;
    } catch (e) {
      // Se falhar a rede, salva localmente marcado como NÃO sincronizado
      await _saveLocal(patient, false);
      return patient;
    }
  }

  @override
  Future<void> updatePatient(Patient patient) async {
    await _apiClient.instance.put('/patients/${patient.id}', data: _mapEntityToJson(patient));
    await _saveLocal(patient, true);
  }

  @override
  Future<List<Patient>> getLocalPatients() async {
    final results = await _localDb.select(_localDb.patients).get();
    return results.map((row) => _mapSchemaToEntity(row)).toList();
  }

  @override
  Future<void> syncPatients() async {
    // Busca pacientes criados offline
    final unsynced = await (_localDb.select(_localDb.patients)
          ..where((t) => t.isSynced.equals(false)))
        .get();

    for (final row in unsynced) {
      try {
        final patient = _mapSchemaToEntity(row);
        await _apiClient.instance.post('/patients', data: _mapEntityToJson(patient));
        
        // Marca como sincronizado no banco local
        await (_localDb.update(_localDb.patients)..where((t) => t.id.equals(row.id))).write(
          const PatientsCompanion(isSynced: Value(true)),
        );
      } catch (_) {
        // Ignora falha individual para tentar na próxima rodada do SyncService
      }
    }
  }

  Future<void> _saveLocal(Patient patient, bool isSynced) async {
    await _localDb.into(_localDb.patients).insertOnConflictUpdate(
          PatientsCompanion.insert(
            id: patient.id,
            fullName: patient.fullName,
            cpf: patient.cpf,
            birthDate: patient.birthDate,
            email: Value(patient.email),
            phone: Value(patient.phone),
            gender: Value(patient.gender),
            lgpdConsent: Value(patient.lgpdConsent),
            isSynced: Value(isSynced),
            street: Value(patient.address?.street),
            number: Value(patient.address?.number),
            neighborhood: Value(patient.address?.neighborhood),
            city: Value(patient.address?.city),
            state: Value(patient.address?.state),
            zipCode: Value(patient.address?.zipCode),
          ),
        );
  }

  void _updateLocalCache(List<Patient> patients) async {
    for (var patient in patients) {
      await _saveLocal(patient, true);
    }
  }

  Patient _mapJsonToEntity(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      fullName: json['fullName'],
      cpf: json['cpf'],
      birthDate: DateTime.parse(json['birthDate']),
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
      address: json['address'] != null ? PatientAddress(
        street: json['address']['street'],
        number: json['address']['number'],
        neighborhood: json['address']['neighborhood'],
        city: json['address']['city'],
        state: json['address']['state'],
        zipCode: json['address']['zipCode'],
      ) : null,
      createdAt: DateTime.parse(json['createdAt']),
      lgpdConsent: json['lgpdConsent'] ?? false,
    );
  }

  Patient _mapSchemaToEntity(PatientData row) {
    return Patient(
      id: row.id,
      fullName: row.fullName,
      cpf: row.cpf,
      birthDate: row.birthDate,
      email: row.email,
      phone: row.phone,
      gender: row.gender,
      lgpdConsent: row.lgpdConsent,
      address: row.street != null ? PatientAddress(
        street: row.street!,
        number: row.number ?? '',
        neighborhood: row.neighborhood ?? '',
        city: row.city ?? '',
        state: row.state ?? '',
        zipCode: row.zipCode ?? '',
      ) : null,
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> _mapEntityToJson(Patient patient) {
    return {
      'id': patient.id,
      'fullName': patient.fullName,
      'cpf': patient.cpf,
      'birthDate': patient.birthDate.toIso8601String(),
      'email': patient.email,
      'phone': patient.phone,
      'gender': patient.gender,
      'lgpdConsent': patient.lgpdConsent,
      'address': patient.address != null ? {
        'street': patient.address!.street,
        'number': patient.address!.number,
        'neighborhood': patient.address!.neighborhood,
        'city': patient.address!.city,
        'state': patient.address!.state,
        'zipCode': patient.address!.zipCode,
      } : null,
    };
  }
}
