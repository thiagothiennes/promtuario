import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:promt/core/network/api_client.dart';
import 'package:promt/core/database/local_database.dart';
import 'package:promt/features/prontuario/domain/entities/odontogram.dart';
import 'package:promt/features/prontuario/domain/entities/prescription.dart';
import 'package:promt/features/prontuario/domain/entities/anamnese.dart';
import 'package:promt/features/prontuario/domain/entities/treatment_plan.dart';
import 'package:promt/features/prontuario/domain/entities/evolution.dart';
import 'package:promt/features/prontuario/domain/repositories/i_prontuario_repository.dart';

/// Implementação do Repositório de Prontuário com suporte a Cache Offline e Sincronização.
class ProntuarioRepository implements IProntuarioRepository {
  final ApiClient _apiClient;
  final AppDatabase _localDb;

  ProntuarioRepository(this._apiClient, this._localDb);

  @override
  Future<Odontogram> getOdontogram(String patientId) async {
    try {
      final response =
          await _apiClient.instance.get('/prontuario/$patientId/odontogram');
      final odontogram = Odontogram.fromJson(response.data);

      await _saveOdontogramLocal(odontogram);
      return odontogram;
    } catch (e) {
      final local = await (_localDb.select(_localDb.odontogramLocal)
            ..where((t) => t.patientId.equals(patientId)))
          .getSingleOrNull();

      if (local != null) {
        return _mapLocalToOdontogram(local);
      }
      rethrow;
    }
  }

  @override
  Future<void> saveOdontogram(Odontogram odontogram) async {
    await _saveOdontogramLocal(odontogram, isSynced: false);
    try {
      await _apiClient.instance.post(
        '/prontuario/${odontogram.patientId}/odontogram',
        data: odontogram.toJson(),
      );
      await _markOdontogramAsSynced(odontogram.patientId);
    } catch (_) {
      // O registro local jÃ¡ foi gravado como pendente antes da tentativa remota.
    }
  }

  @override
  Future<void> addEvolution(
      String patientId, String description, String professorId) async {
    try {
      await _apiClient.instance.post(
        '/evolutions',
        data: {
          'patientId': patientId,
          'description': description,
          'professorId': professorId,
        },
      );
    } catch (e) {
      await _localDb.into(_localDb.evolutionsLocal).insert(
            EvolutionsLocalCompanion.insert(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              patientId: patientId,
              description: description,
              professorId: Value(professorId),
              createdAt: DateTime.now(),
              isSynced: const Value(false),
            ),
          );
    }
  }

  @override
  Future<List<Evolution>> getEvolutionHistory(String patientId) async {
    try {
      final response =
          await _apiClient.instance.get('/prontuario/$patientId/evolutions');
      final List<dynamic> data = response.data ?? [];
      return data.map((json) => Evolution.fromJson(json)).toList();
    } catch (e) {
      final localEvolutions = await (_localDb.select(_localDb.evolutionsLocal)
            ..where((t) => t.patientId.equals(patientId)))
          .get();

      return localEvolutions
          .map((row) => Evolution(
                id: row.id,
                patientId: row.patientId,
                studentId: '',
                studentName: 'Modo Offline',
                professorId: row.professorId ?? '',
                professorName: 'Aguardando Sinc.',
                description: row.description,
                isSignedByProfessor: false,
                createdAt: row.createdAt,
              ))
          .toList();
    }
  }

  @override
  Future<void> signEvolution(String evolutionId) async {
    await _apiClient.instance.patch('/prontuario/evolutions/$evolutionId/sign');
  }

  @override
  Future<Prescription> createPrescription(Prescription prescription) async {
    final response = await _apiClient.instance.post(
      '/patients/${prescription.patientId}/prescriptions',
      data: prescription.toJson(),
    );
    return Prescription.fromJson(response.data);
  }

  @override
  Future<List<Prescription>> getPrescriptionHistory(String patientId) async {
    final response =
        await _apiClient.instance.get('/patients/$patientId/prescriptions');
    final List<dynamic> data = response.data ?? [];
    return data.map((json) => Prescription.fromJson(json)).toList();
  }

  @override
  Future<MedicalCertificate> createCertificate(
      MedicalCertificate certificate) async {
    final response = await _apiClient.instance.post(
      '/patients/${certificate.patientId}/certificates',
      data: certificate.toJson(),
    );
    return MedicalCertificate.fromJson(response.data);
  }

  @override
  Future<Anamnese?> getAnamneseByPatientId(String patientId) async {
    try {
      final response =
          await _apiClient.instance.get('/patients/$patientId/anamnese');
      if (response.data == null) return null;

      final anamnese = Anamnese.fromJson(response.data);

      await _localDb.into(_localDb.anamneseLocal).insertOnConflictUpdate(
            AnamneseLocalCompanion.insert(
              patientId: patientId,
              responsesJson: jsonEncode(anamnese.responses),
              lastUpdated: DateTime.now(),
              isSynced: const Value(true),
            ),
          );

      return anamnese;
    } catch (e) {
      final localData = await (_localDb.select(_localDb.anamneseLocal)
            ..where((t) => t.patientId.equals(patientId)))
          .getSingleOrNull();

      if (localData != null) {
        return Anamnese(
          id: 'local',
          patientId: patientId,
          responses: jsonDecode(localData.responsesJson),
          createdAt: localData.lastUpdated,
          createdBy: 'offline',
        );
      }
      return null;
    }
  }

  @override
  Future<void> saveAnamnese(Anamnese anamnese) async {
    try {
      await _apiClient.instance.post(
        '/patients/${anamnese.patientId}/anamnese',
        data: anamnese.toJson(),
      );

      await _localDb.into(_localDb.anamneseLocal).insertOnConflictUpdate(
            AnamneseLocalCompanion.insert(
              patientId: anamnese.patientId,
              responsesJson: jsonEncode(anamnese.responses),
              lastUpdated: DateTime.now(),
              isSynced: const Value(true),
            ),
          );
    } catch (e) {
      await _localDb.into(_localDb.anamneseLocal).insertOnConflictUpdate(
            AnamneseLocalCompanion.insert(
              patientId: anamnese.patientId,
              responsesJson: jsonEncode(anamnese.responses),
              lastUpdated: DateTime.now(),
              isSynced: const Value(false),
            ),
          );
    }
  }

  @override
  Future<TreatmentPlan?> getTreatmentPlan(String patientId) async {
    try {
      final response =
          await _apiClient.instance.get('/patients/$patientId/treatment-plan');
      if (response.data == null) return null;
      final plan = TreatmentPlan.fromJson(response.data);

      for (var item in plan.items) {
        await _saveTreatmentItemLocal(plan.id, item, true);
      }

      return plan;
    } catch (e) {
      final localItems = await (_localDb.select(_localDb.treatmentItemsLocal)
            ..where((t) => t.planId.isNotNull()))
          .get();

      if (localItems.isEmpty) return null;

      return TreatmentPlan(
        id: localItems.first.planId,
        patientId: patientId,
        description: 'Plano em modo offline',
        items: localItems
            .map((row) => TreatmentItem(
                  id: row.id,
                  procedureId: '',
                  procedureName: row.procedureName,
                  value: row.value,
                  toothNumber: row.toothNumber,
                  status: TreatmentItemStatus.values
                      .firstWhere((e) => e.name == row.status),
                ))
            .toList(),
        createdByUserId: 'offline',
        status: TreatmentPlanStatus.inProgress,
        createdAt: DateTime.now(),
      );
    }
  }

  @override
  Future<void> saveTreatmentPlan(TreatmentPlan plan) async {
    await _apiClient.instance.post(
      '/patients/${plan.patientId}/treatment-plan',
      data: plan.toJson(),
    );
    for (var item in plan.items) {
      await _saveTreatmentItemLocal(plan.id, item, true);
    }
  }

  @override
  Future<void> updateTreatmentItemStatus(
      String planId, String itemId, String status) async {
    try {
      await _apiClient.instance.patch(
        '/treatment-plans/$planId/items/$itemId',
        data: {'status': status},
      );

      final item = await (_localDb.select(_localDb.treatmentItemsLocal)
            ..where((t) => t.id.equals(itemId)))
          .getSingle();
      await _saveTreatmentItemLocal(
          planId,
          _mapRowToItem(item).copyWith(
              status: TreatmentItemStatus.values
                  .firstWhere((e) => e.name == status)),
          true);
    } catch (e) {
      final item = await (_localDb.select(_localDb.treatmentItemsLocal)
            ..where((t) => t.id.equals(itemId)))
          .getSingle();
      await _saveTreatmentItemLocal(
          planId,
          _mapRowToItem(item).copyWith(
              status: TreatmentItemStatus.values
                  .firstWhere((e) => e.name == status)),
          false);
    }
  }

  @override
  Future<void> syncPendingData() async {
    final unsyncedOdontograms = await (_localDb.select(_localDb.odontogramLocal)
          ..where((t) => t.isSynced.equals(false)))
        .get();
    for (final row in unsyncedOdontograms) {
      try {
        await _apiClient.instance.post(
          '/prontuario/${row.patientId}/odontogram',
          data: jsonDecode(row.dataJson),
        );
        await _markOdontogramAsSynced(row.patientId);
      } catch (_) {}
    }

    // Sincroniza Anamneses
    final unsyncedAnamnese = await (_localDb.select(_localDb.anamneseLocal)
          ..where((t) => t.isSynced.equals(false)))
        .get();
    for (final row in unsyncedAnamnese) {
      try {
        await _apiClient.instance.post('/patients/${row.patientId}/anamnese',
            data: {'responses': jsonDecode(row.responsesJson)});
        await (_localDb.update(_localDb.anamneseLocal)
              ..where((t) => t.patientId.equals(row.patientId)))
            .write(const AnamneseLocalCompanion(isSynced: Value(true)));
      } catch (_) {}
    }

    // Sincroniza Evoluções
    final unsyncedEvolutions = await (_localDb.select(_localDb.evolutionsLocal)
          ..where((t) => t.isSynced.equals(false)))
        .get();
    for (final evolution in unsyncedEvolutions) {
      try {
        await _apiClient.instance.post('/evolutions', data: {
          'patientId': evolution.patientId,
          'description': evolution.description,
          'professorId': evolution.professorId,
        });
        await (_localDb.delete(_localDb.evolutionsLocal)
              ..where((t) => t.id.equals(evolution.id)))
            .go();
      } catch (_) {}
    }

    // Sincroniza Itens do Plano de Tratamento
    final unsyncedItems = await (_localDb.select(_localDb.treatmentItemsLocal)
          ..where((t) => t.isSynced.equals(false)))
        .get();
    for (final row in unsyncedItems) {
      try {
        await _apiClient.instance.patch(
            '/treatment-plans/${row.planId}/items/${row.id}',
            data: {'status': row.status});
        await (_localDb.update(_localDb.treatmentItemsLocal)
              ..where((t) => t.id.equals(row.id)))
            .write(const TreatmentItemsLocalCompanion(isSynced: Value(true)));
      } catch (_) {}
    }
  }

  // Helpers
  Future<void> _saveOdontogramLocal(
    Odontogram odontogram, {
    bool isSynced = true,
  }) async {
    await _localDb.into(_localDb.odontogramLocal).insertOnConflictUpdate(
          OdontogramLocalCompanion.insert(
            patientId: odontogram.patientId,
            dataJson: jsonEncode(odontogram.toJson()),
            lastUpdated: DateTime.now(),
            isSynced: Value(isSynced),
          ),
        );
  }

  Future<void> _markOdontogramAsSynced(String patientId) async {
    await (_localDb.update(_localDb.odontogramLocal)
          ..where((table) => table.patientId.equals(patientId)))
        .write(const OdontogramLocalCompanion(isSynced: Value(true)));
  }

  Odontogram _mapLocalToOdontogram(OdontogramLocalData local) {
    return Odontogram.fromJson(jsonDecode(local.dataJson));
  }

  Future<void> _saveTreatmentItemLocal(
      String planId, TreatmentItem item, bool isSynced) async {
    await _localDb.into(_localDb.treatmentItemsLocal).insertOnConflictUpdate(
          TreatmentItemsLocalCompanion.insert(
            id: item.id,
            planId: planId,
            procedureName: item.procedureName,
            value: item.value,
            toothNumber: Value(item.toothNumber),
            status: item.status.name,
            isSynced: Value(isSynced),
          ),
        );
  }

  TreatmentItem _mapRowToItem(TreatmentItemsLocalData row) {
    return TreatmentItem(
      id: row.id,
      procedureId: '',
      procedureName: row.procedureName,
      value: row.value,
      toothNumber: row.toothNumber,
      status:
          TreatmentItemStatus.values.firstWhere((e) => e.name == row.status),
    );
  }
}
