// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $PatientsTable extends Patients with TableInfo<$PatientsTable, Patient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PatientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _cpfMeta = const VerificationMeta('cpf');
  @override
  late final GeneratedColumn<String> cpf = GeneratedColumn<String>(
      'cpf', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 11, maxTextLength: 14),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _birthDateMeta =
      const VerificationMeta('birthDate');
  @override
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
      'birth_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lgpdConsentMeta =
      const VerificationMeta('lgpdConsent');
  @override
  late final GeneratedColumn<bool> lgpdConsent = GeneratedColumn<bool>(
      'lgpd_consent', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("lgpd_consent" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _streetMeta = const VerificationMeta('street');
  @override
  late final GeneratedColumn<String> street = GeneratedColumn<String>(
      'street', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
      'number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _neighborhoodMeta =
      const VerificationMeta('neighborhood');
  @override
  late final GeneratedColumn<String> neighborhood = GeneratedColumn<String>(
      'neighborhood', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
      'state', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _zipCodeMeta =
      const VerificationMeta('zipCode');
  @override
  late final GeneratedColumn<String> zipCode = GeneratedColumn<String>(
      'zip_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        fullName,
        cpf,
        birthDate,
        email,
        phone,
        gender,
        lgpdConsent,
        isSynced,
        street,
        number,
        neighborhood,
        city,
        state,
        zipCode
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'patients';
  @override
  VerificationContext validateIntegrity(Insertable<Patient> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('cpf')) {
      context.handle(
          _cpfMeta, cpf.isAcceptableOrUnknown(data['cpf']!, _cpfMeta));
    } else if (isInserting) {
      context.missing(_cpfMeta);
    }
    if (data.containsKey('birth_date')) {
      context.handle(_birthDateMeta,
          birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta));
    } else if (isInserting) {
      context.missing(_birthDateMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('lgpd_consent')) {
      context.handle(
          _lgpdConsentMeta,
          lgpdConsent.isAcceptableOrUnknown(
              data['lgpd_consent']!, _lgpdConsentMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('street')) {
      context.handle(_streetMeta,
          street.isAcceptableOrUnknown(data['street']!, _streetMeta));
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    }
    if (data.containsKey('neighborhood')) {
      context.handle(
          _neighborhoodMeta,
          neighborhood.isAcceptableOrUnknown(
              data['neighborhood']!, _neighborhoodMeta));
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    }
    if (data.containsKey('zip_code')) {
      context.handle(_zipCodeMeta,
          zipCode.isAcceptableOrUnknown(data['zip_code']!, _zipCodeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Patient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Patient(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name'])!,
      cpf: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cpf'])!,
      birthDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}birth_date'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      lgpdConsent: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}lgpd_consent'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      street: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}street']),
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}number']),
      neighborhood: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}neighborhood']),
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city']),
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state']),
      zipCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}zip_code']),
    );
  }

  @override
  $PatientsTable createAlias(String alias) {
    return $PatientsTable(attachedDatabase, alias);
  }
}

class Patient extends DataClass implements Insertable<Patient> {
  final String id;
  final String fullName;
  final String cpf;
  final DateTime birthDate;
  final String? email;
  final String? phone;
  final String? gender;
  final bool lgpdConsent;
  final bool isSynced;
  final String? street;
  final String? number;
  final String? neighborhood;
  final String? city;
  final String? state;
  final String? zipCode;
  const Patient(
      {required this.id,
      required this.fullName,
      required this.cpf,
      required this.birthDate,
      this.email,
      this.phone,
      this.gender,
      required this.lgpdConsent,
      required this.isSynced,
      this.street,
      this.number,
      this.neighborhood,
      this.city,
      this.state,
      this.zipCode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['full_name'] = Variable<String>(fullName);
    map['cpf'] = Variable<String>(cpf);
    map['birth_date'] = Variable<DateTime>(birthDate);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    map['lgpd_consent'] = Variable<bool>(lgpdConsent);
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || street != null) {
      map['street'] = Variable<String>(street);
    }
    if (!nullToAbsent || number != null) {
      map['number'] = Variable<String>(number);
    }
    if (!nullToAbsent || neighborhood != null) {
      map['neighborhood'] = Variable<String>(neighborhood);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || state != null) {
      map['state'] = Variable<String>(state);
    }
    if (!nullToAbsent || zipCode != null) {
      map['zip_code'] = Variable<String>(zipCode);
    }
    return map;
  }

  PatientsCompanion toCompanion(bool nullToAbsent) {
    return PatientsCompanion(
      id: Value(id),
      fullName: Value(fullName),
      cpf: Value(cpf),
      birthDate: Value(birthDate),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      lgpdConsent: Value(lgpdConsent),
      isSynced: Value(isSynced),
      street:
          street == null && nullToAbsent ? const Value.absent() : Value(street),
      number:
          number == null && nullToAbsent ? const Value.absent() : Value(number),
      neighborhood: neighborhood == null && nullToAbsent
          ? const Value.absent()
          : Value(neighborhood),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      state:
          state == null && nullToAbsent ? const Value.absent() : Value(state),
      zipCode: zipCode == null && nullToAbsent
          ? const Value.absent()
          : Value(zipCode),
    );
  }

  factory Patient.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Patient(
      id: serializer.fromJson<String>(json['id']),
      fullName: serializer.fromJson<String>(json['fullName']),
      cpf: serializer.fromJson<String>(json['cpf']),
      birthDate: serializer.fromJson<DateTime>(json['birthDate']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      gender: serializer.fromJson<String?>(json['gender']),
      lgpdConsent: serializer.fromJson<bool>(json['lgpdConsent']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      street: serializer.fromJson<String?>(json['street']),
      number: serializer.fromJson<String?>(json['number']),
      neighborhood: serializer.fromJson<String?>(json['neighborhood']),
      city: serializer.fromJson<String?>(json['city']),
      state: serializer.fromJson<String?>(json['state']),
      zipCode: serializer.fromJson<String?>(json['zipCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fullName': serializer.toJson<String>(fullName),
      'cpf': serializer.toJson<String>(cpf),
      'birthDate': serializer.toJson<DateTime>(birthDate),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'gender': serializer.toJson<String?>(gender),
      'lgpdConsent': serializer.toJson<bool>(lgpdConsent),
      'isSynced': serializer.toJson<bool>(isSynced),
      'street': serializer.toJson<String?>(street),
      'number': serializer.toJson<String?>(number),
      'neighborhood': serializer.toJson<String?>(neighborhood),
      'city': serializer.toJson<String?>(city),
      'state': serializer.toJson<String?>(state),
      'zipCode': serializer.toJson<String?>(zipCode),
    };
  }

  Patient copyWith(
          {String? id,
          String? fullName,
          String? cpf,
          DateTime? birthDate,
          Value<String?> email = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> gender = const Value.absent(),
          bool? lgpdConsent,
          bool? isSynced,
          Value<String?> street = const Value.absent(),
          Value<String?> number = const Value.absent(),
          Value<String?> neighborhood = const Value.absent(),
          Value<String?> city = const Value.absent(),
          Value<String?> state = const Value.absent(),
          Value<String?> zipCode = const Value.absent()}) =>
      Patient(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        cpf: cpf ?? this.cpf,
        birthDate: birthDate ?? this.birthDate,
        email: email.present ? email.value : this.email,
        phone: phone.present ? phone.value : this.phone,
        gender: gender.present ? gender.value : this.gender,
        lgpdConsent: lgpdConsent ?? this.lgpdConsent,
        isSynced: isSynced ?? this.isSynced,
        street: street.present ? street.value : this.street,
        number: number.present ? number.value : this.number,
        neighborhood:
            neighborhood.present ? neighborhood.value : this.neighborhood,
        city: city.present ? city.value : this.city,
        state: state.present ? state.value : this.state,
        zipCode: zipCode.present ? zipCode.value : this.zipCode,
      );
  Patient copyWithCompanion(PatientsCompanion data) {
    return Patient(
      id: data.id.present ? data.id.value : this.id,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      cpf: data.cpf.present ? data.cpf.value : this.cpf,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      gender: data.gender.present ? data.gender.value : this.gender,
      lgpdConsent:
          data.lgpdConsent.present ? data.lgpdConsent.value : this.lgpdConsent,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      street: data.street.present ? data.street.value : this.street,
      number: data.number.present ? data.number.value : this.number,
      neighborhood: data.neighborhood.present
          ? data.neighborhood.value
          : this.neighborhood,
      city: data.city.present ? data.city.value : this.city,
      state: data.state.present ? data.state.value : this.state,
      zipCode: data.zipCode.present ? data.zipCode.value : this.zipCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Patient(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('cpf: $cpf, ')
          ..write('birthDate: $birthDate, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('gender: $gender, ')
          ..write('lgpdConsent: $lgpdConsent, ')
          ..write('isSynced: $isSynced, ')
          ..write('street: $street, ')
          ..write('number: $number, ')
          ..write('neighborhood: $neighborhood, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('zipCode: $zipCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      fullName,
      cpf,
      birthDate,
      email,
      phone,
      gender,
      lgpdConsent,
      isSynced,
      street,
      number,
      neighborhood,
      city,
      state,
      zipCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Patient &&
          other.id == this.id &&
          other.fullName == this.fullName &&
          other.cpf == this.cpf &&
          other.birthDate == this.birthDate &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.gender == this.gender &&
          other.lgpdConsent == this.lgpdConsent &&
          other.isSynced == this.isSynced &&
          other.street == this.street &&
          other.number == this.number &&
          other.neighborhood == this.neighborhood &&
          other.city == this.city &&
          other.state == this.state &&
          other.zipCode == this.zipCode);
}

class PatientsCompanion extends UpdateCompanion<Patient> {
  final Value<String> id;
  final Value<String> fullName;
  final Value<String> cpf;
  final Value<DateTime> birthDate;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> gender;
  final Value<bool> lgpdConsent;
  final Value<bool> isSynced;
  final Value<String?> street;
  final Value<String?> number;
  final Value<String?> neighborhood;
  final Value<String?> city;
  final Value<String?> state;
  final Value<String?> zipCode;
  final Value<int> rowid;
  const PatientsCompanion({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.cpf = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.gender = const Value.absent(),
    this.lgpdConsent = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.street = const Value.absent(),
    this.number = const Value.absent(),
    this.neighborhood = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.zipCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PatientsCompanion.insert({
    required String id,
    required String fullName,
    required String cpf,
    required DateTime birthDate,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.gender = const Value.absent(),
    this.lgpdConsent = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.street = const Value.absent(),
    this.number = const Value.absent(),
    this.neighborhood = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.zipCode = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        fullName = Value(fullName),
        cpf = Value(cpf),
        birthDate = Value(birthDate);
  static Insertable<Patient> custom({
    Expression<String>? id,
    Expression<String>? fullName,
    Expression<String>? cpf,
    Expression<DateTime>? birthDate,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? gender,
    Expression<bool>? lgpdConsent,
    Expression<bool>? isSynced,
    Expression<String>? street,
    Expression<String>? number,
    Expression<String>? neighborhood,
    Expression<String>? city,
    Expression<String>? state,
    Expression<String>? zipCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fullName != null) 'full_name': fullName,
      if (cpf != null) 'cpf': cpf,
      if (birthDate != null) 'birth_date': birthDate,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (gender != null) 'gender': gender,
      if (lgpdConsent != null) 'lgpd_consent': lgpdConsent,
      if (isSynced != null) 'is_synced': isSynced,
      if (street != null) 'street': street,
      if (number != null) 'number': number,
      if (neighborhood != null) 'neighborhood': neighborhood,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (zipCode != null) 'zip_code': zipCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PatientsCompanion copyWith(
      {Value<String>? id,
      Value<String>? fullName,
      Value<String>? cpf,
      Value<DateTime>? birthDate,
      Value<String?>? email,
      Value<String?>? phone,
      Value<String?>? gender,
      Value<bool>? lgpdConsent,
      Value<bool>? isSynced,
      Value<String?>? street,
      Value<String?>? number,
      Value<String?>? neighborhood,
      Value<String?>? city,
      Value<String?>? state,
      Value<String?>? zipCode,
      Value<int>? rowid}) {
    return PatientsCompanion(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      cpf: cpf ?? this.cpf,
      birthDate: birthDate ?? this.birthDate,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      lgpdConsent: lgpdConsent ?? this.lgpdConsent,
      isSynced: isSynced ?? this.isSynced,
      street: street ?? this.street,
      number: number ?? this.number,
      neighborhood: neighborhood ?? this.neighborhood,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (cpf.present) {
      map['cpf'] = Variable<String>(cpf.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (lgpdConsent.present) {
      map['lgpd_consent'] = Variable<bool>(lgpdConsent.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (street.present) {
      map['street'] = Variable<String>(street.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (neighborhood.present) {
      map['neighborhood'] = Variable<String>(neighborhood.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (zipCode.present) {
      map['zip_code'] = Variable<String>(zipCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientsCompanion(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('cpf: $cpf, ')
          ..write('birthDate: $birthDate, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('gender: $gender, ')
          ..write('lgpdConsent: $lgpdConsent, ')
          ..write('isSynced: $isSynced, ')
          ..write('street: $street, ')
          ..write('number: $number, ')
          ..write('neighborhood: $neighborhood, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('zipCode: $zipCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsersLocalTable extends UsersLocal
    with TableInfo<$UsersLocalTable, UsersLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [id, name, email, role, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users_local';
  @override
  VerificationContext validateIntegrity(Insertable<UsersLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsersLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsersLocalData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $UsersLocalTable createAlias(String alias) {
    return $UsersLocalTable(attachedDatabase, alias);
  }
}

class UsersLocalData extends DataClass implements Insertable<UsersLocalData> {
  final String id;
  final String name;
  final String email;
  final String role;
  final bool isActive;
  const UsersLocalData(
      {required this.id,
      required this.name,
      required this.email,
      required this.role,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['role'] = Variable<String>(role);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  UsersLocalCompanion toCompanion(bool nullToAbsent) {
    return UsersLocalCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      role: Value(role),
      isActive: Value(isActive),
    );
  }

  factory UsersLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsersLocalData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      role: serializer.fromJson<String>(json['role']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'role': serializer.toJson<String>(role),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  UsersLocalData copyWith(
          {String? id,
          String? name,
          String? email,
          String? role,
          bool? isActive}) =>
      UsersLocalData(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        role: role ?? this.role,
        isActive: isActive ?? this.isActive,
      );
  UsersLocalData copyWithCompanion(UsersLocalCompanion data) {
    return UsersLocalData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      role: data.role.present ? data.role.value : this.role,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsersLocalData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, email, role, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsersLocalData &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.role == this.role &&
          other.isActive == this.isActive);
}

class UsersLocalCompanion extends UpdateCompanion<UsersLocalData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String> role;
  final Value<bool> isActive;
  final Value<int> rowid;
  const UsersLocalCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.role = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersLocalCompanion.insert({
    required String id,
    required String name,
    required String email,
    required String role,
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        email = Value(email),
        role = Value(role);
  static Insertable<UsersLocalData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? role,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (role != null) 'role': role,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersLocalCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? email,
      Value<String>? role,
      Value<bool>? isActive,
      Value<int>? rowid}) {
    return UsersLocalCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersLocalCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttachmentsLocalTable extends AttachmentsLocal
    with TableInfo<$AttachmentsLocalTable, AttachmentsLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttachmentsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localPathMeta =
      const VerificationMeta('localPath');
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
      'local_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, patientId, localPath, type, description, createdAt, isSynced];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attachments_local';
  @override
  VerificationContext validateIntegrity(
      Insertable<AttachmentsLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(_localPathMeta,
          localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta));
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttachmentsLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttachmentsLocalData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_id'])!,
      localPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_path'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $AttachmentsLocalTable createAlias(String alias) {
    return $AttachmentsLocalTable(attachedDatabase, alias);
  }
}

class AttachmentsLocalData extends DataClass
    implements Insertable<AttachmentsLocalData> {
  final String id;
  final String patientId;
  final String localPath;
  final String type;
  final String? description;
  final DateTime createdAt;
  final bool isSynced;
  const AttachmentsLocalData(
      {required this.id,
      required this.patientId,
      required this.localPath,
      required this.type,
      this.description,
      required this.createdAt,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['local_path'] = Variable<String>(localPath);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  AttachmentsLocalCompanion toCompanion(bool nullToAbsent) {
    return AttachmentsLocalCompanion(
      id: Value(id),
      patientId: Value(patientId),
      localPath: Value(localPath),
      type: Value(type),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      isSynced: Value(isSynced),
    );
  }

  factory AttachmentsLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttachmentsLocalData(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      localPath: serializer.fromJson<String>(json['localPath']),
      type: serializer.fromJson<String>(json['type']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'localPath': serializer.toJson<String>(localPath),
      'type': serializer.toJson<String>(type),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  AttachmentsLocalData copyWith(
          {String? id,
          String? patientId,
          String? localPath,
          String? type,
          Value<String?> description = const Value.absent(),
          DateTime? createdAt,
          bool? isSynced}) =>
      AttachmentsLocalData(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        localPath: localPath ?? this.localPath,
        type: type ?? this.type,
        description: description.present ? description.value : this.description,
        createdAt: createdAt ?? this.createdAt,
        isSynced: isSynced ?? this.isSynced,
      );
  AttachmentsLocalData copyWithCompanion(AttachmentsLocalCompanion data) {
    return AttachmentsLocalData(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      type: data.type.present ? data.type.value : this.type,
      description:
          data.description.present ? data.description.value : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentsLocalData(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('localPath: $localPath, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, patientId, localPath, type, description, createdAt, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttachmentsLocalData &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.localPath == this.localPath &&
          other.type == this.type &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced);
}

class AttachmentsLocalCompanion extends UpdateCompanion<AttachmentsLocalData> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String> localPath;
  final Value<String> type;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const AttachmentsLocalCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.localPath = const Value.absent(),
    this.type = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttachmentsLocalCompanion.insert({
    required String id,
    required String patientId,
    required String localPath,
    required String type,
    this.description = const Value.absent(),
    required DateTime createdAt,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        patientId = Value(patientId),
        localPath = Value(localPath),
        type = Value(type),
        createdAt = Value(createdAt);
  static Insertable<AttachmentsLocalData> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? localPath,
    Expression<String>? type,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (localPath != null) 'local_path': localPath,
      if (type != null) 'type': type,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttachmentsLocalCompanion copyWith(
      {Value<String>? id,
      Value<String>? patientId,
      Value<String>? localPath,
      Value<String>? type,
      Value<String?>? description,
      Value<DateTime>? createdAt,
      Value<bool>? isSynced,
      Value<int>? rowid}) {
    return AttachmentsLocalCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      localPath: localPath ?? this.localPath,
      type: type ?? this.type,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentsLocalCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('localPath: $localPath, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OdontogramLocalTable extends OdontogramLocal
    with TableInfo<$OdontogramLocalTable, OdontogramLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OdontogramLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dataJsonMeta =
      const VerificationMeta('dataJson');
  @override
  late final GeneratedColumn<String> dataJson = GeneratedColumn<String>(
      'data_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [patientId, dataJson, lastUpdated, isSynced];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'odontogram_local';
  @override
  VerificationContext validateIntegrity(
      Insertable<OdontogramLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('data_json')) {
      context.handle(_dataJsonMeta,
          dataJson.isAcceptableOrUnknown(data['data_json']!, _dataJsonMeta));
    } else if (isInserting) {
      context.missing(_dataJsonMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {patientId};
  @override
  OdontogramLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OdontogramLocalData(
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_id'])!,
      dataJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data_json'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $OdontogramLocalTable createAlias(String alias) {
    return $OdontogramLocalTable(attachedDatabase, alias);
  }
}

class OdontogramLocalData extends DataClass
    implements Insertable<OdontogramLocalData> {
  final String patientId;
  final String dataJson;
  final DateTime lastUpdated;
  final bool isSynced;
  const OdontogramLocalData(
      {required this.patientId,
      required this.dataJson,
      required this.lastUpdated,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['patient_id'] = Variable<String>(patientId);
    map['data_json'] = Variable<String>(dataJson);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  OdontogramLocalCompanion toCompanion(bool nullToAbsent) {
    return OdontogramLocalCompanion(
      patientId: Value(patientId),
      dataJson: Value(dataJson),
      lastUpdated: Value(lastUpdated),
      isSynced: Value(isSynced),
    );
  }

  factory OdontogramLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OdontogramLocalData(
      patientId: serializer.fromJson<String>(json['patientId']),
      dataJson: serializer.fromJson<String>(json['dataJson']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'patientId': serializer.toJson<String>(patientId),
      'dataJson': serializer.toJson<String>(dataJson),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  OdontogramLocalData copyWith(
          {String? patientId,
          String? dataJson,
          DateTime? lastUpdated,
          bool? isSynced}) =>
      OdontogramLocalData(
        patientId: patientId ?? this.patientId,
        dataJson: dataJson ?? this.dataJson,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        isSynced: isSynced ?? this.isSynced,
      );
  OdontogramLocalData copyWithCompanion(OdontogramLocalCompanion data) {
    return OdontogramLocalData(
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      dataJson: data.dataJson.present ? data.dataJson.value : this.dataJson,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OdontogramLocalData(')
          ..write('patientId: $patientId, ')
          ..write('dataJson: $dataJson, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(patientId, dataJson, lastUpdated, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OdontogramLocalData &&
          other.patientId == this.patientId &&
          other.dataJson == this.dataJson &&
          other.lastUpdated == this.lastUpdated &&
          other.isSynced == this.isSynced);
}

class OdontogramLocalCompanion extends UpdateCompanion<OdontogramLocalData> {
  final Value<String> patientId;
  final Value<String> dataJson;
  final Value<DateTime> lastUpdated;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const OdontogramLocalCompanion({
    this.patientId = const Value.absent(),
    this.dataJson = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OdontogramLocalCompanion.insert({
    required String patientId,
    required String dataJson,
    required DateTime lastUpdated,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : patientId = Value(patientId),
        dataJson = Value(dataJson),
        lastUpdated = Value(lastUpdated);
  static Insertable<OdontogramLocalData> custom({
    Expression<String>? patientId,
    Expression<String>? dataJson,
    Expression<DateTime>? lastUpdated,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (patientId != null) 'patient_id': patientId,
      if (dataJson != null) 'data_json': dataJson,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OdontogramLocalCompanion copyWith(
      {Value<String>? patientId,
      Value<String>? dataJson,
      Value<DateTime>? lastUpdated,
      Value<bool>? isSynced,
      Value<int>? rowid}) {
    return OdontogramLocalCompanion(
      patientId: patientId ?? this.patientId,
      dataJson: dataJson ?? this.dataJson,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (dataJson.present) {
      map['data_json'] = Variable<String>(dataJson.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OdontogramLocalCompanion(')
          ..write('patientId: $patientId, ')
          ..write('dataJson: $dataJson, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WaitListLocalTable extends WaitListLocal
    with TableInfo<$WaitListLocalTable, WaitListLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WaitListLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _patientNameMeta =
      const VerificationMeta('patientName');
  @override
  late final GeneratedColumn<String> patientName = GeneratedColumn<String>(
      'patient_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _clinicIdMeta =
      const VerificationMeta('clinicId');
  @override
  late final GeneratedColumn<String> clinicId = GeneratedColumn<String>(
      'clinic_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
      'priority', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _specialtyMeta =
      const VerificationMeta('specialty');
  @override
  late final GeneratedColumn<String> specialty = GeneratedColumn<String>(
      'specialty', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _observationMeta =
      const VerificationMeta('observation');
  @override
  late final GeneratedColumn<String> observation = GeneratedColumn<String>(
      'observation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        patientId,
        patientName,
        clinicId,
        priority,
        specialty,
        observation,
        createdAt,
        isSynced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wait_list_local';
  @override
  VerificationContext validateIntegrity(Insertable<WaitListLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('patient_name')) {
      context.handle(
          _patientNameMeta,
          patientName.isAcceptableOrUnknown(
              data['patient_name']!, _patientNameMeta));
    } else if (isInserting) {
      context.missing(_patientNameMeta);
    }
    if (data.containsKey('clinic_id')) {
      context.handle(_clinicIdMeta,
          clinicId.isAcceptableOrUnknown(data['clinic_id']!, _clinicIdMeta));
    } else if (isInserting) {
      context.missing(_clinicIdMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('specialty')) {
      context.handle(_specialtyMeta,
          specialty.isAcceptableOrUnknown(data['specialty']!, _specialtyMeta));
    } else if (isInserting) {
      context.missing(_specialtyMeta);
    }
    if (data.containsKey('observation')) {
      context.handle(
          _observationMeta,
          observation.isAcceptableOrUnknown(
              data['observation']!, _observationMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WaitListLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WaitListLocalData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_id'])!,
      patientName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_name'])!,
      clinicId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}clinic_id'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}priority'])!,
      specialty: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}specialty'])!,
      observation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observation']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $WaitListLocalTable createAlias(String alias) {
    return $WaitListLocalTable(attachedDatabase, alias);
  }
}

class WaitListLocalData extends DataClass
    implements Insertable<WaitListLocalData> {
  final String id;
  final String patientId;
  final String patientName;
  final String clinicId;
  final String priority;
  final String specialty;
  final String? observation;
  final DateTime createdAt;
  final bool isSynced;
  const WaitListLocalData(
      {required this.id,
      required this.patientId,
      required this.patientName,
      required this.clinicId,
      required this.priority,
      required this.specialty,
      this.observation,
      required this.createdAt,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['patient_name'] = Variable<String>(patientName);
    map['clinic_id'] = Variable<String>(clinicId);
    map['priority'] = Variable<String>(priority);
    map['specialty'] = Variable<String>(specialty);
    if (!nullToAbsent || observation != null) {
      map['observation'] = Variable<String>(observation);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  WaitListLocalCompanion toCompanion(bool nullToAbsent) {
    return WaitListLocalCompanion(
      id: Value(id),
      patientId: Value(patientId),
      patientName: Value(patientName),
      clinicId: Value(clinicId),
      priority: Value(priority),
      specialty: Value(specialty),
      observation: observation == null && nullToAbsent
          ? const Value.absent()
          : Value(observation),
      createdAt: Value(createdAt),
      isSynced: Value(isSynced),
    );
  }

  factory WaitListLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WaitListLocalData(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      patientName: serializer.fromJson<String>(json['patientName']),
      clinicId: serializer.fromJson<String>(json['clinicId']),
      priority: serializer.fromJson<String>(json['priority']),
      specialty: serializer.fromJson<String>(json['specialty']),
      observation: serializer.fromJson<String?>(json['observation']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'patientName': serializer.toJson<String>(patientName),
      'clinicId': serializer.toJson<String>(clinicId),
      'priority': serializer.toJson<String>(priority),
      'specialty': serializer.toJson<String>(specialty),
      'observation': serializer.toJson<String?>(observation),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  WaitListLocalData copyWith(
          {String? id,
          String? patientId,
          String? patientName,
          String? clinicId,
          String? priority,
          String? specialty,
          Value<String?> observation = const Value.absent(),
          DateTime? createdAt,
          bool? isSynced}) =>
      WaitListLocalData(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        patientName: patientName ?? this.patientName,
        clinicId: clinicId ?? this.clinicId,
        priority: priority ?? this.priority,
        specialty: specialty ?? this.specialty,
        observation: observation.present ? observation.value : this.observation,
        createdAt: createdAt ?? this.createdAt,
        isSynced: isSynced ?? this.isSynced,
      );
  WaitListLocalData copyWithCompanion(WaitListLocalCompanion data) {
    return WaitListLocalData(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      patientName:
          data.patientName.present ? data.patientName.value : this.patientName,
      clinicId: data.clinicId.present ? data.clinicId.value : this.clinicId,
      priority: data.priority.present ? data.priority.value : this.priority,
      specialty: data.specialty.present ? data.specialty.value : this.specialty,
      observation:
          data.observation.present ? data.observation.value : this.observation,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WaitListLocalData(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('patientName: $patientName, ')
          ..write('clinicId: $clinicId, ')
          ..write('priority: $priority, ')
          ..write('specialty: $specialty, ')
          ..write('observation: $observation, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, patientId, patientName, clinicId,
      priority, specialty, observation, createdAt, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WaitListLocalData &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.patientName == this.patientName &&
          other.clinicId == this.clinicId &&
          other.priority == this.priority &&
          other.specialty == this.specialty &&
          other.observation == this.observation &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced);
}

class WaitListLocalCompanion extends UpdateCompanion<WaitListLocalData> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String> patientName;
  final Value<String> clinicId;
  final Value<String> priority;
  final Value<String> specialty;
  final Value<String?> observation;
  final Value<DateTime> createdAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const WaitListLocalCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.patientName = const Value.absent(),
    this.clinicId = const Value.absent(),
    this.priority = const Value.absent(),
    this.specialty = const Value.absent(),
    this.observation = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WaitListLocalCompanion.insert({
    required String id,
    required String patientId,
    required String patientName,
    required String clinicId,
    required String priority,
    required String specialty,
    this.observation = const Value.absent(),
    required DateTime createdAt,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        patientId = Value(patientId),
        patientName = Value(patientName),
        clinicId = Value(clinicId),
        priority = Value(priority),
        specialty = Value(specialty),
        createdAt = Value(createdAt);
  static Insertable<WaitListLocalData> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? patientName,
    Expression<String>? clinicId,
    Expression<String>? priority,
    Expression<String>? specialty,
    Expression<String>? observation,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (patientName != null) 'patient_name': patientName,
      if (clinicId != null) 'clinic_id': clinicId,
      if (priority != null) 'priority': priority,
      if (specialty != null) 'specialty': specialty,
      if (observation != null) 'observation': observation,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WaitListLocalCompanion copyWith(
      {Value<String>? id,
      Value<String>? patientId,
      Value<String>? patientName,
      Value<String>? clinicId,
      Value<String>? priority,
      Value<String>? specialty,
      Value<String?>? observation,
      Value<DateTime>? createdAt,
      Value<bool>? isSynced,
      Value<int>? rowid}) {
    return WaitListLocalCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      clinicId: clinicId ?? this.clinicId,
      priority: priority ?? this.priority,
      specialty: specialty ?? this.specialty,
      observation: observation ?? this.observation,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (patientName.present) {
      map['patient_name'] = Variable<String>(patientName.value);
    }
    if (clinicId.present) {
      map['clinic_id'] = Variable<String>(clinicId.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (specialty.present) {
      map['specialty'] = Variable<String>(specialty.value);
    }
    if (observation.present) {
      map['observation'] = Variable<String>(observation.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WaitListLocalCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('patientName: $patientName, ')
          ..write('clinicId: $clinicId, ')
          ..write('priority: $priority, ')
          ..write('specialty: $specialty, ')
          ..write('observation: $observation, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuditLocalTable extends AuditLocal
    with TableInfo<$AuditLocalTable, AuditLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _resourceIdMeta =
      const VerificationMeta('resourceId');
  @override
  late final GeneratedColumn<String> resourceId = GeneratedColumn<String>(
      'resource_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
      'action', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, resourceId, action, timestamp, isSynced];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_local';
  @override
  VerificationContext validateIntegrity(Insertable<AuditLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('resource_id')) {
      context.handle(
          _resourceIdMeta,
          resourceId.isAcceptableOrUnknown(
              data['resource_id']!, _resourceIdMeta));
    } else if (isInserting) {
      context.missing(_resourceIdMeta);
    }
    if (data.containsKey('action')) {
      context.handle(_actionMeta,
          action.isAcceptableOrUnknown(data['action']!, _actionMeta));
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLocalData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      resourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}resource_id'])!,
      action: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $AuditLocalTable createAlias(String alias) {
    return $AuditLocalTable(attachedDatabase, alias);
  }
}

class AuditLocalData extends DataClass implements Insertable<AuditLocalData> {
  final int id;
  final String resourceId;
  final String action;
  final DateTime timestamp;
  final bool isSynced;
  const AuditLocalData(
      {required this.id,
      required this.resourceId,
      required this.action,
      required this.timestamp,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['resource_id'] = Variable<String>(resourceId);
    map['action'] = Variable<String>(action);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  AuditLocalCompanion toCompanion(bool nullToAbsent) {
    return AuditLocalCompanion(
      id: Value(id),
      resourceId: Value(resourceId),
      action: Value(action),
      timestamp: Value(timestamp),
      isSynced: Value(isSynced),
    );
  }

  factory AuditLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLocalData(
      id: serializer.fromJson<int>(json['id']),
      resourceId: serializer.fromJson<String>(json['resourceId']),
      action: serializer.fromJson<String>(json['action']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'resourceId': serializer.toJson<String>(resourceId),
      'action': serializer.toJson<String>(action),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  AuditLocalData copyWith(
          {int? id,
          String? resourceId,
          String? action,
          DateTime? timestamp,
          bool? isSynced}) =>
      AuditLocalData(
        id: id ?? this.id,
        resourceId: resourceId ?? this.resourceId,
        action: action ?? this.action,
        timestamp: timestamp ?? this.timestamp,
        isSynced: isSynced ?? this.isSynced,
      );
  AuditLocalData copyWithCompanion(AuditLocalCompanion data) {
    return AuditLocalData(
      id: data.id.present ? data.id.value : this.id,
      resourceId:
          data.resourceId.present ? data.resourceId.value : this.resourceId,
      action: data.action.present ? data.action.value : this.action,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLocalData(')
          ..write('id: $id, ')
          ..write('resourceId: $resourceId, ')
          ..write('action: $action, ')
          ..write('timestamp: $timestamp, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, resourceId, action, timestamp, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLocalData &&
          other.id == this.id &&
          other.resourceId == this.resourceId &&
          other.action == this.action &&
          other.timestamp == this.timestamp &&
          other.isSynced == this.isSynced);
}

class AuditLocalCompanion extends UpdateCompanion<AuditLocalData> {
  final Value<int> id;
  final Value<String> resourceId;
  final Value<String> action;
  final Value<DateTime> timestamp;
  final Value<bool> isSynced;
  const AuditLocalCompanion({
    this.id = const Value.absent(),
    this.resourceId = const Value.absent(),
    this.action = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.isSynced = const Value.absent(),
  });
  AuditLocalCompanion.insert({
    this.id = const Value.absent(),
    required String resourceId,
    required String action,
    required DateTime timestamp,
    this.isSynced = const Value.absent(),
  })  : resourceId = Value(resourceId),
        action = Value(action),
        timestamp = Value(timestamp);
  static Insertable<AuditLocalData> custom({
    Expression<int>? id,
    Expression<String>? resourceId,
    Expression<String>? action,
    Expression<DateTime>? timestamp,
    Expression<bool>? isSynced,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (resourceId != null) 'resource_id': resourceId,
      if (action != null) 'action': action,
      if (timestamp != null) 'timestamp': timestamp,
      if (isSynced != null) 'is_synced': isSynced,
    });
  }

  AuditLocalCompanion copyWith(
      {Value<int>? id,
      Value<String>? resourceId,
      Value<String>? action,
      Value<DateTime>? timestamp,
      Value<bool>? isSynced}) {
    return AuditLocalCompanion(
      id: id ?? this.id,
      resourceId: resourceId ?? this.resourceId,
      action: action ?? this.action,
      timestamp: timestamp ?? this.timestamp,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (resourceId.present) {
      map['resource_id'] = Variable<String>(resourceId.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLocalCompanion(')
          ..write('id: $id, ')
          ..write('resourceId: $resourceId, ')
          ..write('action: $action, ')
          ..write('timestamp: $timestamp, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }
}

class $AnamneseLocalTable extends AnamneseLocal
    with TableInfo<$AnamneseLocalTable, AnamneseLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnamneseLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _responsesJsonMeta =
      const VerificationMeta('responsesJson');
  @override
  late final GeneratedColumn<String> responsesJson = GeneratedColumn<String>(
      'responses_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [patientId, responsesJson, lastUpdated, isSynced];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'anamnese_local';
  @override
  VerificationContext validateIntegrity(Insertable<AnamneseLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('responses_json')) {
      context.handle(
          _responsesJsonMeta,
          responsesJson.isAcceptableOrUnknown(
              data['responses_json']!, _responsesJsonMeta));
    } else if (isInserting) {
      context.missing(_responsesJsonMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {patientId};
  @override
  AnamneseLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnamneseLocalData(
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_id'])!,
      responsesJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}responses_json'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $AnamneseLocalTable createAlias(String alias) {
    return $AnamneseLocalTable(attachedDatabase, alias);
  }
}

class AnamneseLocalData extends DataClass
    implements Insertable<AnamneseLocalData> {
  final String patientId;
  final String responsesJson;
  final DateTime lastUpdated;
  final bool isSynced;
  const AnamneseLocalData(
      {required this.patientId,
      required this.responsesJson,
      required this.lastUpdated,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['patient_id'] = Variable<String>(patientId);
    map['responses_json'] = Variable<String>(responsesJson);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  AnamneseLocalCompanion toCompanion(bool nullToAbsent) {
    return AnamneseLocalCompanion(
      patientId: Value(patientId),
      responsesJson: Value(responsesJson),
      lastUpdated: Value(lastUpdated),
      isSynced: Value(isSynced),
    );
  }

  factory AnamneseLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnamneseLocalData(
      patientId: serializer.fromJson<String>(json['patientId']),
      responsesJson: serializer.fromJson<String>(json['responsesJson']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'patientId': serializer.toJson<String>(patientId),
      'responsesJson': serializer.toJson<String>(responsesJson),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  AnamneseLocalData copyWith(
          {String? patientId,
          String? responsesJson,
          DateTime? lastUpdated,
          bool? isSynced}) =>
      AnamneseLocalData(
        patientId: patientId ?? this.patientId,
        responsesJson: responsesJson ?? this.responsesJson,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        isSynced: isSynced ?? this.isSynced,
      );
  AnamneseLocalData copyWithCompanion(AnamneseLocalCompanion data) {
    return AnamneseLocalData(
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      responsesJson: data.responsesJson.present
          ? data.responsesJson.value
          : this.responsesJson,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnamneseLocalData(')
          ..write('patientId: $patientId, ')
          ..write('responsesJson: $responsesJson, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(patientId, responsesJson, lastUpdated, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnamneseLocalData &&
          other.patientId == this.patientId &&
          other.responsesJson == this.responsesJson &&
          other.lastUpdated == this.lastUpdated &&
          other.isSynced == this.isSynced);
}

class AnamneseLocalCompanion extends UpdateCompanion<AnamneseLocalData> {
  final Value<String> patientId;
  final Value<String> responsesJson;
  final Value<DateTime> lastUpdated;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const AnamneseLocalCompanion({
    this.patientId = const Value.absent(),
    this.responsesJson = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AnamneseLocalCompanion.insert({
    required String patientId,
    required String responsesJson,
    required DateTime lastUpdated,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : patientId = Value(patientId),
        responsesJson = Value(responsesJson),
        lastUpdated = Value(lastUpdated);
  static Insertable<AnamneseLocalData> custom({
    Expression<String>? patientId,
    Expression<String>? responsesJson,
    Expression<DateTime>? lastUpdated,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (patientId != null) 'patient_id': patientId,
      if (responsesJson != null) 'responses_json': responsesJson,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AnamneseLocalCompanion copyWith(
      {Value<String>? patientId,
      Value<String>? responsesJson,
      Value<DateTime>? lastUpdated,
      Value<bool>? isSynced,
      Value<int>? rowid}) {
    return AnamneseLocalCompanion(
      patientId: patientId ?? this.patientId,
      responsesJson: responsesJson ?? this.responsesJson,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (responsesJson.present) {
      map['responses_json'] = Variable<String>(responsesJson.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnamneseLocalCompanion(')
          ..write('patientId: $patientId, ')
          ..write('responsesJson: $responsesJson, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppointmentsLocalTable extends AppointmentsLocal
    with TableInfo<$AppointmentsLocalTable, AppointmentsLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppointmentsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _patientNameMeta =
      const VerificationMeta('patientName');
  @override
  late final GeneratedColumn<String> patientName = GeneratedColumn<String>(
      'patient_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _doctorIdMeta =
      const VerificationMeta('doctorId');
  @override
  late final GeneratedColumn<String> doctorId = GeneratedColumn<String>(
      'doctor_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _doctorNameMeta =
      const VerificationMeta('doctorName');
  @override
  late final GeneratedColumn<String> doctorName = GeneratedColumn<String>(
      'doctor_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _procedureNameMeta =
      const VerificationMeta('procedureName');
  @override
  late final GeneratedColumn<String> procedureName = GeneratedColumn<String>(
      'procedure_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _clinicIdMeta =
      const VerificationMeta('clinicId');
  @override
  late final GeneratedColumn<String> clinicId = GeneratedColumn<String>(
      'clinic_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        patientId,
        patientName,
        doctorId,
        doctorName,
        startTime,
        endTime,
        status,
        procedureName,
        notes,
        clinicId,
        isSynced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'appointments_local';
  @override
  VerificationContext validateIntegrity(
      Insertable<AppointmentsLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    }
    if (data.containsKey('patient_name')) {
      context.handle(
          _patientNameMeta,
          patientName.isAcceptableOrUnknown(
              data['patient_name']!, _patientNameMeta));
    } else if (isInserting) {
      context.missing(_patientNameMeta);
    }
    if (data.containsKey('doctor_id')) {
      context.handle(_doctorIdMeta,
          doctorId.isAcceptableOrUnknown(data['doctor_id']!, _doctorIdMeta));
    }
    if (data.containsKey('doctor_name')) {
      context.handle(
          _doctorNameMeta,
          doctorName.isAcceptableOrUnknown(
              data['doctor_name']!, _doctorNameMeta));
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('procedure_name')) {
      context.handle(
          _procedureNameMeta,
          procedureName.isAcceptableOrUnknown(
              data['procedure_name']!, _procedureNameMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('clinic_id')) {
      context.handle(_clinicIdMeta,
          clinicId.isAcceptableOrUnknown(data['clinic_id']!, _clinicIdMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppointmentsLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppointmentsLocalData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_id'])!,
      patientName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_name'])!,
      doctorId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}doctor_id'])!,
      doctorName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}doctor_name'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      procedureName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}procedure_name']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      clinicId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}clinic_id'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $AppointmentsLocalTable createAlias(String alias) {
    return $AppointmentsLocalTable(attachedDatabase, alias);
  }
}

class AppointmentsLocalData extends DataClass
    implements Insertable<AppointmentsLocalData> {
  final String id;
  final String patientId;
  final String patientName;
  final String doctorId;
  final String doctorName;
  final DateTime startTime;
  final DateTime endTime;
  final String status;
  final String? procedureName;
  final String? notes;
  final String clinicId;
  final bool isSynced;
  const AppointmentsLocalData(
      {required this.id,
      required this.patientId,
      required this.patientName,
      required this.doctorId,
      required this.doctorName,
      required this.startTime,
      required this.endTime,
      required this.status,
      this.procedureName,
      this.notes,
      required this.clinicId,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['patient_name'] = Variable<String>(patientName);
    map['doctor_id'] = Variable<String>(doctorId);
    map['doctor_name'] = Variable<String>(doctorName);
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || procedureName != null) {
      map['procedure_name'] = Variable<String>(procedureName);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['clinic_id'] = Variable<String>(clinicId);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  AppointmentsLocalCompanion toCompanion(bool nullToAbsent) {
    return AppointmentsLocalCompanion(
      id: Value(id),
      patientId: Value(patientId),
      patientName: Value(patientName),
      doctorId: Value(doctorId),
      doctorName: Value(doctorName),
      startTime: Value(startTime),
      endTime: Value(endTime),
      status: Value(status),
      procedureName: procedureName == null && nullToAbsent
          ? const Value.absent()
          : Value(procedureName),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      clinicId: Value(clinicId),
      isSynced: Value(isSynced),
    );
  }

  factory AppointmentsLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppointmentsLocalData(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      patientName: serializer.fromJson<String>(json['patientName']),
      doctorId: serializer.fromJson<String>(json['doctorId']),
      doctorName: serializer.fromJson<String>(json['doctorName']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      status: serializer.fromJson<String>(json['status']),
      procedureName: serializer.fromJson<String?>(json['procedureName']),
      notes: serializer.fromJson<String?>(json['notes']),
      clinicId: serializer.fromJson<String>(json['clinicId']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'patientName': serializer.toJson<String>(patientName),
      'doctorId': serializer.toJson<String>(doctorId),
      'doctorName': serializer.toJson<String>(doctorName),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'status': serializer.toJson<String>(status),
      'procedureName': serializer.toJson<String?>(procedureName),
      'notes': serializer.toJson<String?>(notes),
      'clinicId': serializer.toJson<String>(clinicId),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  AppointmentsLocalData copyWith(
          {String? id,
          String? patientId,
          String? patientName,
          String? doctorId,
          String? doctorName,
          DateTime? startTime,
          DateTime? endTime,
          String? status,
          Value<String?> procedureName = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          String? clinicId,
          bool? isSynced}) =>
      AppointmentsLocalData(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        patientName: patientName ?? this.patientName,
        doctorId: doctorId ?? this.doctorId,
        doctorName: doctorName ?? this.doctorName,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        status: status ?? this.status,
        procedureName:
            procedureName.present ? procedureName.value : this.procedureName,
        notes: notes.present ? notes.value : this.notes,
        clinicId: clinicId ?? this.clinicId,
        isSynced: isSynced ?? this.isSynced,
      );
  AppointmentsLocalData copyWithCompanion(AppointmentsLocalCompanion data) {
    return AppointmentsLocalData(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      patientName:
          data.patientName.present ? data.patientName.value : this.patientName,
      doctorId: data.doctorId.present ? data.doctorId.value : this.doctorId,
      doctorName:
          data.doctorName.present ? data.doctorName.value : this.doctorName,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      status: data.status.present ? data.status.value : this.status,
      procedureName: data.procedureName.present
          ? data.procedureName.value
          : this.procedureName,
      notes: data.notes.present ? data.notes.value : this.notes,
      clinicId: data.clinicId.present ? data.clinicId.value : this.clinicId,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppointmentsLocalData(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('patientName: $patientName, ')
          ..write('doctorId: $doctorId, ')
          ..write('doctorName: $doctorName, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('status: $status, ')
          ..write('procedureName: $procedureName, ')
          ..write('notes: $notes, ')
          ..write('clinicId: $clinicId, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      patientId,
      patientName,
      doctorId,
      doctorName,
      startTime,
      endTime,
      status,
      procedureName,
      notes,
      clinicId,
      isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppointmentsLocalData &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.patientName == this.patientName &&
          other.doctorId == this.doctorId &&
          other.doctorName == this.doctorName &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.status == this.status &&
          other.procedureName == this.procedureName &&
          other.notes == this.notes &&
          other.clinicId == this.clinicId &&
          other.isSynced == this.isSynced);
}

class AppointmentsLocalCompanion
    extends UpdateCompanion<AppointmentsLocalData> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String> patientName;
  final Value<String> doctorId;
  final Value<String> doctorName;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<String> status;
  final Value<String?> procedureName;
  final Value<String?> notes;
  final Value<String> clinicId;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const AppointmentsLocalCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.patientName = const Value.absent(),
    this.doctorId = const Value.absent(),
    this.doctorName = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.status = const Value.absent(),
    this.procedureName = const Value.absent(),
    this.notes = const Value.absent(),
    this.clinicId = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppointmentsLocalCompanion.insert({
    required String id,
    this.patientId = const Value.absent(),
    required String patientName,
    this.doctorId = const Value.absent(),
    this.doctorName = const Value.absent(),
    required DateTime startTime,
    required DateTime endTime,
    required String status,
    this.procedureName = const Value.absent(),
    this.notes = const Value.absent(),
    this.clinicId = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        patientName = Value(patientName),
        startTime = Value(startTime),
        endTime = Value(endTime),
        status = Value(status);
  static Insertable<AppointmentsLocalData> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? patientName,
    Expression<String>? doctorId,
    Expression<String>? doctorName,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? status,
    Expression<String>? procedureName,
    Expression<String>? notes,
    Expression<String>? clinicId,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (patientName != null) 'patient_name': patientName,
      if (doctorId != null) 'doctor_id': doctorId,
      if (doctorName != null) 'doctor_name': doctorName,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (status != null) 'status': status,
      if (procedureName != null) 'procedure_name': procedureName,
      if (notes != null) 'notes': notes,
      if (clinicId != null) 'clinic_id': clinicId,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppointmentsLocalCompanion copyWith(
      {Value<String>? id,
      Value<String>? patientId,
      Value<String>? patientName,
      Value<String>? doctorId,
      Value<String>? doctorName,
      Value<DateTime>? startTime,
      Value<DateTime>? endTime,
      Value<String>? status,
      Value<String?>? procedureName,
      Value<String?>? notes,
      Value<String>? clinicId,
      Value<bool>? isSynced,
      Value<int>? rowid}) {
    return AppointmentsLocalCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      procedureName: procedureName ?? this.procedureName,
      notes: notes ?? this.notes,
      clinicId: clinicId ?? this.clinicId,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (patientName.present) {
      map['patient_name'] = Variable<String>(patientName.value);
    }
    if (doctorId.present) {
      map['doctor_id'] = Variable<String>(doctorId.value);
    }
    if (doctorName.present) {
      map['doctor_name'] = Variable<String>(doctorName.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (procedureName.present) {
      map['procedure_name'] = Variable<String>(procedureName.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (clinicId.present) {
      map['clinic_id'] = Variable<String>(clinicId.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppointmentsLocalCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('patientName: $patientName, ')
          ..write('doctorId: $doctorId, ')
          ..write('doctorName: $doctorName, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('status: $status, ')
          ..write('procedureName: $procedureName, ')
          ..write('notes: $notes, ')
          ..write('clinicId: $clinicId, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EvolutionsLocalTable extends EvolutionsLocal
    with TableInfo<$EvolutionsLocalTable, EvolutionsLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EvolutionsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _professorIdMeta =
      const VerificationMeta('professorId');
  @override
  late final GeneratedColumn<String> professorId = GeneratedColumn<String>(
      'professor_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, patientId, description, professorId, createdAt, isSynced];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'evolutions_local';
  @override
  VerificationContext validateIntegrity(
      Insertable<EvolutionsLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('professor_id')) {
      context.handle(
          _professorIdMeta,
          professorId.isAcceptableOrUnknown(
              data['professor_id']!, _professorIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EvolutionsLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EvolutionsLocalData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_id'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      professorId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}professor_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $EvolutionsLocalTable createAlias(String alias) {
    return $EvolutionsLocalTable(attachedDatabase, alias);
  }
}

class EvolutionsLocalData extends DataClass
    implements Insertable<EvolutionsLocalData> {
  final String id;
  final String patientId;
  final String description;
  final String? professorId;
  final DateTime createdAt;
  final bool isSynced;
  const EvolutionsLocalData(
      {required this.id,
      required this.patientId,
      required this.description,
      this.professorId,
      required this.createdAt,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || professorId != null) {
      map['professor_id'] = Variable<String>(professorId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  EvolutionsLocalCompanion toCompanion(bool nullToAbsent) {
    return EvolutionsLocalCompanion(
      id: Value(id),
      patientId: Value(patientId),
      description: Value(description),
      professorId: professorId == null && nullToAbsent
          ? const Value.absent()
          : Value(professorId),
      createdAt: Value(createdAt),
      isSynced: Value(isSynced),
    );
  }

  factory EvolutionsLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EvolutionsLocalData(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      description: serializer.fromJson<String>(json['description']),
      professorId: serializer.fromJson<String?>(json['professorId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'description': serializer.toJson<String>(description),
      'professorId': serializer.toJson<String?>(professorId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  EvolutionsLocalData copyWith(
          {String? id,
          String? patientId,
          String? description,
          Value<String?> professorId = const Value.absent(),
          DateTime? createdAt,
          bool? isSynced}) =>
      EvolutionsLocalData(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        description: description ?? this.description,
        professorId: professorId.present ? professorId.value : this.professorId,
        createdAt: createdAt ?? this.createdAt,
        isSynced: isSynced ?? this.isSynced,
      );
  EvolutionsLocalData copyWithCompanion(EvolutionsLocalCompanion data) {
    return EvolutionsLocalData(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      description:
          data.description.present ? data.description.value : this.description,
      professorId:
          data.professorId.present ? data.professorId.value : this.professorId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EvolutionsLocalData(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('description: $description, ')
          ..write('professorId: $professorId, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, patientId, description, professorId, createdAt, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EvolutionsLocalData &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.description == this.description &&
          other.professorId == this.professorId &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced);
}

class EvolutionsLocalCompanion extends UpdateCompanion<EvolutionsLocalData> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String> description;
  final Value<String?> professorId;
  final Value<DateTime> createdAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const EvolutionsLocalCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.description = const Value.absent(),
    this.professorId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EvolutionsLocalCompanion.insert({
    required String id,
    required String patientId,
    required String description,
    this.professorId = const Value.absent(),
    required DateTime createdAt,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        patientId = Value(patientId),
        description = Value(description),
        createdAt = Value(createdAt);
  static Insertable<EvolutionsLocalData> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? description,
    Expression<String>? professorId,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (description != null) 'description': description,
      if (professorId != null) 'professor_id': professorId,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EvolutionsLocalCompanion copyWith(
      {Value<String>? id,
      Value<String>? patientId,
      Value<String>? description,
      Value<String?>? professorId,
      Value<DateTime>? createdAt,
      Value<bool>? isSynced,
      Value<int>? rowid}) {
    return EvolutionsLocalCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      description: description ?? this.description,
      professorId: professorId ?? this.professorId,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (professorId.present) {
      map['professor_id'] = Variable<String>(professorId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EvolutionsLocalCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('description: $description, ')
          ..write('professorId: $professorId, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TreatmentItemsLocalTable extends TreatmentItemsLocal
    with TableInfo<$TreatmentItemsLocalTable, TreatmentItemsLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TreatmentItemsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
      'plan_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _procedureNameMeta =
      const VerificationMeta('procedureName');
  @override
  late final GeneratedColumn<String> procedureName = GeneratedColumn<String>(
      'procedure_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _toothNumberMeta =
      const VerificationMeta('toothNumber');
  @override
  late final GeneratedColumn<int> toothNumber = GeneratedColumn<int>(
      'tooth_number', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, planId, procedureName, value, toothNumber, status, isSynced];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'treatment_items_local';
  @override
  VerificationContext validateIntegrity(
      Insertable<TreatmentItemsLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(_planIdMeta,
          planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta));
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('procedure_name')) {
      context.handle(
          _procedureNameMeta,
          procedureName.isAcceptableOrUnknown(
              data['procedure_name']!, _procedureNameMeta));
    } else if (isInserting) {
      context.missing(_procedureNameMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('tooth_number')) {
      context.handle(
          _toothNumberMeta,
          toothNumber.isAcceptableOrUnknown(
              data['tooth_number']!, _toothNumberMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TreatmentItemsLocalData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TreatmentItemsLocalData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      planId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plan_id'])!,
      procedureName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}procedure_name'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value'])!,
      toothNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tooth_number']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $TreatmentItemsLocalTable createAlias(String alias) {
    return $TreatmentItemsLocalTable(attachedDatabase, alias);
  }
}

class TreatmentItemsLocalData extends DataClass
    implements Insertable<TreatmentItemsLocalData> {
  final String id;
  final String planId;
  final String procedureName;
  final double value;
  final int? toothNumber;
  final String status;
  final bool isSynced;
  const TreatmentItemsLocalData(
      {required this.id,
      required this.planId,
      required this.procedureName,
      required this.value,
      this.toothNumber,
      required this.status,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['plan_id'] = Variable<String>(planId);
    map['procedure_name'] = Variable<String>(procedureName);
    map['value'] = Variable<double>(value);
    if (!nullToAbsent || toothNumber != null) {
      map['tooth_number'] = Variable<int>(toothNumber);
    }
    map['status'] = Variable<String>(status);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  TreatmentItemsLocalCompanion toCompanion(bool nullToAbsent) {
    return TreatmentItemsLocalCompanion(
      id: Value(id),
      planId: Value(planId),
      procedureName: Value(procedureName),
      value: Value(value),
      toothNumber: toothNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(toothNumber),
      status: Value(status),
      isSynced: Value(isSynced),
    );
  }

  factory TreatmentItemsLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TreatmentItemsLocalData(
      id: serializer.fromJson<String>(json['id']),
      planId: serializer.fromJson<String>(json['planId']),
      procedureName: serializer.fromJson<String>(json['procedureName']),
      value: serializer.fromJson<double>(json['value']),
      toothNumber: serializer.fromJson<int?>(json['toothNumber']),
      status: serializer.fromJson<String>(json['status']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'planId': serializer.toJson<String>(planId),
      'procedureName': serializer.toJson<String>(procedureName),
      'value': serializer.toJson<double>(value),
      'toothNumber': serializer.toJson<int?>(toothNumber),
      'status': serializer.toJson<String>(status),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  TreatmentItemsLocalData copyWith(
          {String? id,
          String? planId,
          String? procedureName,
          double? value,
          Value<int?> toothNumber = const Value.absent(),
          String? status,
          bool? isSynced}) =>
      TreatmentItemsLocalData(
        id: id ?? this.id,
        planId: planId ?? this.planId,
        procedureName: procedureName ?? this.procedureName,
        value: value ?? this.value,
        toothNumber: toothNumber.present ? toothNumber.value : this.toothNumber,
        status: status ?? this.status,
        isSynced: isSynced ?? this.isSynced,
      );
  TreatmentItemsLocalData copyWithCompanion(TreatmentItemsLocalCompanion data) {
    return TreatmentItemsLocalData(
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      procedureName: data.procedureName.present
          ? data.procedureName.value
          : this.procedureName,
      value: data.value.present ? data.value.value : this.value,
      toothNumber:
          data.toothNumber.present ? data.toothNumber.value : this.toothNumber,
      status: data.status.present ? data.status.value : this.status,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TreatmentItemsLocalData(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('procedureName: $procedureName, ')
          ..write('value: $value, ')
          ..write('toothNumber: $toothNumber, ')
          ..write('status: $status, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, planId, procedureName, value, toothNumber, status, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TreatmentItemsLocalData &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.procedureName == this.procedureName &&
          other.value == this.value &&
          other.toothNumber == this.toothNumber &&
          other.status == this.status &&
          other.isSynced == this.isSynced);
}

class TreatmentItemsLocalCompanion
    extends UpdateCompanion<TreatmentItemsLocalData> {
  final Value<String> id;
  final Value<String> planId;
  final Value<String> procedureName;
  final Value<double> value;
  final Value<int?> toothNumber;
  final Value<String> status;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const TreatmentItemsLocalCompanion({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.procedureName = const Value.absent(),
    this.value = const Value.absent(),
    this.toothNumber = const Value.absent(),
    this.status = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TreatmentItemsLocalCompanion.insert({
    required String id,
    required String planId,
    required String procedureName,
    required double value,
    this.toothNumber = const Value.absent(),
    required String status,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        planId = Value(planId),
        procedureName = Value(procedureName),
        value = Value(value),
        status = Value(status);
  static Insertable<TreatmentItemsLocalData> custom({
    Expression<String>? id,
    Expression<String>? planId,
    Expression<String>? procedureName,
    Expression<double>? value,
    Expression<int>? toothNumber,
    Expression<String>? status,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (procedureName != null) 'procedure_name': procedureName,
      if (value != null) 'value': value,
      if (toothNumber != null) 'tooth_number': toothNumber,
      if (status != null) 'status': status,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TreatmentItemsLocalCompanion copyWith(
      {Value<String>? id,
      Value<String>? planId,
      Value<String>? procedureName,
      Value<double>? value,
      Value<int?>? toothNumber,
      Value<String>? status,
      Value<bool>? isSynced,
      Value<int>? rowid}) {
    return TreatmentItemsLocalCompanion(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      procedureName: procedureName ?? this.procedureName,
      value: value ?? this.value,
      toothNumber: toothNumber ?? this.toothNumber,
      status: status ?? this.status,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (procedureName.present) {
      map['procedure_name'] = Variable<String>(procedureName.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (toothNumber.present) {
      map['tooth_number'] = Variable<int>(toothNumber.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TreatmentItemsLocalCompanion(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('procedureName: $procedureName, ')
          ..write('value: $value, ')
          ..write('toothNumber: $toothNumber, ')
          ..write('status: $status, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PatientsTable patients = $PatientsTable(this);
  late final $UsersLocalTable usersLocal = $UsersLocalTable(this);
  late final $AttachmentsLocalTable attachmentsLocal =
      $AttachmentsLocalTable(this);
  late final $OdontogramLocalTable odontogramLocal =
      $OdontogramLocalTable(this);
  late final $WaitListLocalTable waitListLocal = $WaitListLocalTable(this);
  late final $AuditLocalTable auditLocal = $AuditLocalTable(this);
  late final $AnamneseLocalTable anamneseLocal = $AnamneseLocalTable(this);
  late final $AppointmentsLocalTable appointmentsLocal =
      $AppointmentsLocalTable(this);
  late final $EvolutionsLocalTable evolutionsLocal =
      $EvolutionsLocalTable(this);
  late final $TreatmentItemsLocalTable treatmentItemsLocal =
      $TreatmentItemsLocalTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        patients,
        usersLocal,
        attachmentsLocal,
        odontogramLocal,
        waitListLocal,
        auditLocal,
        anamneseLocal,
        appointmentsLocal,
        evolutionsLocal,
        treatmentItemsLocal
      ];
}

typedef $$PatientsTableCreateCompanionBuilder = PatientsCompanion Function({
  required String id,
  required String fullName,
  required String cpf,
  required DateTime birthDate,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> gender,
  Value<bool> lgpdConsent,
  Value<bool> isSynced,
  Value<String?> street,
  Value<String?> number,
  Value<String?> neighborhood,
  Value<String?> city,
  Value<String?> state,
  Value<String?> zipCode,
  Value<int> rowid,
});
typedef $$PatientsTableUpdateCompanionBuilder = PatientsCompanion Function({
  Value<String> id,
  Value<String> fullName,
  Value<String> cpf,
  Value<DateTime> birthDate,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> gender,
  Value<bool> lgpdConsent,
  Value<bool> isSynced,
  Value<String?> street,
  Value<String?> number,
  Value<String?> neighborhood,
  Value<String?> city,
  Value<String?> state,
  Value<String?> zipCode,
  Value<int> rowid,
});

class $$PatientsTableFilterComposer
    extends Composer<_$AppDatabase, $PatientsTable> {
  $$PatientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cpf => $composableBuilder(
      column: $table.cpf, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get birthDate => $composableBuilder(
      column: $table.birthDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get lgpdConsent => $composableBuilder(
      column: $table.lgpdConsent, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get street => $composableBuilder(
      column: $table.street, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get number => $composableBuilder(
      column: $table.number, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get neighborhood => $composableBuilder(
      column: $table.neighborhood, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get zipCode => $composableBuilder(
      column: $table.zipCode, builder: (column) => ColumnFilters(column));
}

class $$PatientsTableOrderingComposer
    extends Composer<_$AppDatabase, $PatientsTable> {
  $$PatientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cpf => $composableBuilder(
      column: $table.cpf, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get birthDate => $composableBuilder(
      column: $table.birthDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get lgpdConsent => $composableBuilder(
      column: $table.lgpdConsent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get street => $composableBuilder(
      column: $table.street, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get number => $composableBuilder(
      column: $table.number, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get neighborhood => $composableBuilder(
      column: $table.neighborhood,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get zipCode => $composableBuilder(
      column: $table.zipCode, builder: (column) => ColumnOrderings(column));
}

class $$PatientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PatientsTable> {
  $$PatientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get cpf =>
      $composableBuilder(column: $table.cpf, builder: (column) => column);

  GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<bool> get lgpdConsent => $composableBuilder(
      column: $table.lgpdConsent, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<String> get street =>
      $composableBuilder(column: $table.street, builder: (column) => column);

  GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get neighborhood => $composableBuilder(
      column: $table.neighborhood, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get zipCode =>
      $composableBuilder(column: $table.zipCode, builder: (column) => column);
}

class $$PatientsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PatientsTable,
    Patient,
    $$PatientsTableFilterComposer,
    $$PatientsTableOrderingComposer,
    $$PatientsTableAnnotationComposer,
    $$PatientsTableCreateCompanionBuilder,
    $$PatientsTableUpdateCompanionBuilder,
    (Patient, BaseReferences<_$AppDatabase, $PatientsTable, Patient>),
    Patient,
    PrefetchHooks Function()> {
  $$PatientsTableTableManager(_$AppDatabase db, $PatientsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PatientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PatientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PatientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> fullName = const Value.absent(),
            Value<String> cpf = const Value.absent(),
            Value<DateTime> birthDate = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<bool> lgpdConsent = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<String?> street = const Value.absent(),
            Value<String?> number = const Value.absent(),
            Value<String?> neighborhood = const Value.absent(),
            Value<String?> city = const Value.absent(),
            Value<String?> state = const Value.absent(),
            Value<String?> zipCode = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PatientsCompanion(
            id: id,
            fullName: fullName,
            cpf: cpf,
            birthDate: birthDate,
            email: email,
            phone: phone,
            gender: gender,
            lgpdConsent: lgpdConsent,
            isSynced: isSynced,
            street: street,
            number: number,
            neighborhood: neighborhood,
            city: city,
            state: state,
            zipCode: zipCode,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String fullName,
            required String cpf,
            required DateTime birthDate,
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<bool> lgpdConsent = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<String?> street = const Value.absent(),
            Value<String?> number = const Value.absent(),
            Value<String?> neighborhood = const Value.absent(),
            Value<String?> city = const Value.absent(),
            Value<String?> state = const Value.absent(),
            Value<String?> zipCode = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PatientsCompanion.insert(
            id: id,
            fullName: fullName,
            cpf: cpf,
            birthDate: birthDate,
            email: email,
            phone: phone,
            gender: gender,
            lgpdConsent: lgpdConsent,
            isSynced: isSynced,
            street: street,
            number: number,
            neighborhood: neighborhood,
            city: city,
            state: state,
            zipCode: zipCode,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PatientsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PatientsTable,
    Patient,
    $$PatientsTableFilterComposer,
    $$PatientsTableOrderingComposer,
    $$PatientsTableAnnotationComposer,
    $$PatientsTableCreateCompanionBuilder,
    $$PatientsTableUpdateCompanionBuilder,
    (Patient, BaseReferences<_$AppDatabase, $PatientsTable, Patient>),
    Patient,
    PrefetchHooks Function()>;
typedef $$UsersLocalTableCreateCompanionBuilder = UsersLocalCompanion Function({
  required String id,
  required String name,
  required String email,
  required String role,
  Value<bool> isActive,
  Value<int> rowid,
});
typedef $$UsersLocalTableUpdateCompanionBuilder = UsersLocalCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> email,
  Value<String> role,
  Value<bool> isActive,
  Value<int> rowid,
});

class $$UsersLocalTableFilterComposer
    extends Composer<_$AppDatabase, $UsersLocalTable> {
  $$UsersLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));
}

class $$UsersLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersLocalTable> {
  $$UsersLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));
}

class $$UsersLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersLocalTable> {
  $$UsersLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$UsersLocalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersLocalTable,
    UsersLocalData,
    $$UsersLocalTableFilterComposer,
    $$UsersLocalTableOrderingComposer,
    $$UsersLocalTableAnnotationComposer,
    $$UsersLocalTableCreateCompanionBuilder,
    $$UsersLocalTableUpdateCompanionBuilder,
    (
      UsersLocalData,
      BaseReferences<_$AppDatabase, $UsersLocalTable, UsersLocalData>
    ),
    UsersLocalData,
    PrefetchHooks Function()> {
  $$UsersLocalTableTableManager(_$AppDatabase db, $UsersLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersLocalCompanion(
            id: id,
            name: name,
            email: email,
            role: role,
            isActive: isActive,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String email,
            required String role,
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersLocalCompanion.insert(
            id: id,
            name: name,
            email: email,
            role: role,
            isActive: isActive,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsersLocalTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersLocalTable,
    UsersLocalData,
    $$UsersLocalTableFilterComposer,
    $$UsersLocalTableOrderingComposer,
    $$UsersLocalTableAnnotationComposer,
    $$UsersLocalTableCreateCompanionBuilder,
    $$UsersLocalTableUpdateCompanionBuilder,
    (
      UsersLocalData,
      BaseReferences<_$AppDatabase, $UsersLocalTable, UsersLocalData>
    ),
    UsersLocalData,
    PrefetchHooks Function()>;
typedef $$AttachmentsLocalTableCreateCompanionBuilder
    = AttachmentsLocalCompanion Function({
  required String id,
  required String patientId,
  required String localPath,
  required String type,
  Value<String?> description,
  required DateTime createdAt,
  Value<bool> isSynced,
  Value<int> rowid,
});
typedef $$AttachmentsLocalTableUpdateCompanionBuilder
    = AttachmentsLocalCompanion Function({
  Value<String> id,
  Value<String> patientId,
  Value<String> localPath,
  Value<String> type,
  Value<String?> description,
  Value<DateTime> createdAt,
  Value<bool> isSynced,
  Value<int> rowid,
});

class $$AttachmentsLocalTableFilterComposer
    extends Composer<_$AppDatabase, $AttachmentsLocalTable> {
  $$AttachmentsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$AttachmentsLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $AttachmentsLocalTable> {
  $$AttachmentsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$AttachmentsLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttachmentsLocalTable> {
  $$AttachmentsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$AttachmentsLocalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AttachmentsLocalTable,
    AttachmentsLocalData,
    $$AttachmentsLocalTableFilterComposer,
    $$AttachmentsLocalTableOrderingComposer,
    $$AttachmentsLocalTableAnnotationComposer,
    $$AttachmentsLocalTableCreateCompanionBuilder,
    $$AttachmentsLocalTableUpdateCompanionBuilder,
    (
      AttachmentsLocalData,
      BaseReferences<_$AppDatabase, $AttachmentsLocalTable,
          AttachmentsLocalData>
    ),
    AttachmentsLocalData,
    PrefetchHooks Function()> {
  $$AttachmentsLocalTableTableManager(
      _$AppDatabase db, $AttachmentsLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttachmentsLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttachmentsLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttachmentsLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> patientId = const Value.absent(),
            Value<String> localPath = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AttachmentsLocalCompanion(
            id: id,
            patientId: patientId,
            localPath: localPath,
            type: type,
            description: description,
            createdAt: createdAt,
            isSynced: isSynced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String patientId,
            required String localPath,
            required String type,
            Value<String?> description = const Value.absent(),
            required DateTime createdAt,
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AttachmentsLocalCompanion.insert(
            id: id,
            patientId: patientId,
            localPath: localPath,
            type: type,
            description: description,
            createdAt: createdAt,
            isSynced: isSynced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AttachmentsLocalTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AttachmentsLocalTable,
    AttachmentsLocalData,
    $$AttachmentsLocalTableFilterComposer,
    $$AttachmentsLocalTableOrderingComposer,
    $$AttachmentsLocalTableAnnotationComposer,
    $$AttachmentsLocalTableCreateCompanionBuilder,
    $$AttachmentsLocalTableUpdateCompanionBuilder,
    (
      AttachmentsLocalData,
      BaseReferences<_$AppDatabase, $AttachmentsLocalTable,
          AttachmentsLocalData>
    ),
    AttachmentsLocalData,
    PrefetchHooks Function()>;
typedef $$OdontogramLocalTableCreateCompanionBuilder = OdontogramLocalCompanion
    Function({
  required String patientId,
  required String dataJson,
  required DateTime lastUpdated,
  Value<bool> isSynced,
  Value<int> rowid,
});
typedef $$OdontogramLocalTableUpdateCompanionBuilder = OdontogramLocalCompanion
    Function({
  Value<String> patientId,
  Value<String> dataJson,
  Value<DateTime> lastUpdated,
  Value<bool> isSynced,
  Value<int> rowid,
});

class $$OdontogramLocalTableFilterComposer
    extends Composer<_$AppDatabase, $OdontogramLocalTable> {
  $$OdontogramLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dataJson => $composableBuilder(
      column: $table.dataJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$OdontogramLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $OdontogramLocalTable> {
  $$OdontogramLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dataJson => $composableBuilder(
      column: $table.dataJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$OdontogramLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $OdontogramLocalTable> {
  $$OdontogramLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get dataJson =>
      $composableBuilder(column: $table.dataJson, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$OdontogramLocalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OdontogramLocalTable,
    OdontogramLocalData,
    $$OdontogramLocalTableFilterComposer,
    $$OdontogramLocalTableOrderingComposer,
    $$OdontogramLocalTableAnnotationComposer,
    $$OdontogramLocalTableCreateCompanionBuilder,
    $$OdontogramLocalTableUpdateCompanionBuilder,
    (
      OdontogramLocalData,
      BaseReferences<_$AppDatabase, $OdontogramLocalTable, OdontogramLocalData>
    ),
    OdontogramLocalData,
    PrefetchHooks Function()> {
  $$OdontogramLocalTableTableManager(
      _$AppDatabase db, $OdontogramLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OdontogramLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OdontogramLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OdontogramLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> patientId = const Value.absent(),
            Value<String> dataJson = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OdontogramLocalCompanion(
            patientId: patientId,
            dataJson: dataJson,
            lastUpdated: lastUpdated,
            isSynced: isSynced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String patientId,
            required String dataJson,
            required DateTime lastUpdated,
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OdontogramLocalCompanion.insert(
            patientId: patientId,
            dataJson: dataJson,
            lastUpdated: lastUpdated,
            isSynced: isSynced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OdontogramLocalTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OdontogramLocalTable,
    OdontogramLocalData,
    $$OdontogramLocalTableFilterComposer,
    $$OdontogramLocalTableOrderingComposer,
    $$OdontogramLocalTableAnnotationComposer,
    $$OdontogramLocalTableCreateCompanionBuilder,
    $$OdontogramLocalTableUpdateCompanionBuilder,
    (
      OdontogramLocalData,
      BaseReferences<_$AppDatabase, $OdontogramLocalTable, OdontogramLocalData>
    ),
    OdontogramLocalData,
    PrefetchHooks Function()>;
typedef $$WaitListLocalTableCreateCompanionBuilder = WaitListLocalCompanion
    Function({
  required String id,
  required String patientId,
  required String patientName,
  required String clinicId,
  required String priority,
  required String specialty,
  Value<String?> observation,
  required DateTime createdAt,
  Value<bool> isSynced,
  Value<int> rowid,
});
typedef $$WaitListLocalTableUpdateCompanionBuilder = WaitListLocalCompanion
    Function({
  Value<String> id,
  Value<String> patientId,
  Value<String> patientName,
  Value<String> clinicId,
  Value<String> priority,
  Value<String> specialty,
  Value<String?> observation,
  Value<DateTime> createdAt,
  Value<bool> isSynced,
  Value<int> rowid,
});

class $$WaitListLocalTableFilterComposer
    extends Composer<_$AppDatabase, $WaitListLocalTable> {
  $$WaitListLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patientName => $composableBuilder(
      column: $table.patientName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clinicId => $composableBuilder(
      column: $table.clinicId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get specialty => $composableBuilder(
      column: $table.specialty, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$WaitListLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $WaitListLocalTable> {
  $$WaitListLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patientName => $composableBuilder(
      column: $table.patientName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clinicId => $composableBuilder(
      column: $table.clinicId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get specialty => $composableBuilder(
      column: $table.specialty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$WaitListLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $WaitListLocalTable> {
  $$WaitListLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get patientName => $composableBuilder(
      column: $table.patientName, builder: (column) => column);

  GeneratedColumn<String> get clinicId =>
      $composableBuilder(column: $table.clinicId, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get specialty =>
      $composableBuilder(column: $table.specialty, builder: (column) => column);

  GeneratedColumn<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$WaitListLocalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WaitListLocalTable,
    WaitListLocalData,
    $$WaitListLocalTableFilterComposer,
    $$WaitListLocalTableOrderingComposer,
    $$WaitListLocalTableAnnotationComposer,
    $$WaitListLocalTableCreateCompanionBuilder,
    $$WaitListLocalTableUpdateCompanionBuilder,
    (
      WaitListLocalData,
      BaseReferences<_$AppDatabase, $WaitListLocalTable, WaitListLocalData>
    ),
    WaitListLocalData,
    PrefetchHooks Function()> {
  $$WaitListLocalTableTableManager(_$AppDatabase db, $WaitListLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WaitListLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WaitListLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WaitListLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> patientId = const Value.absent(),
            Value<String> patientName = const Value.absent(),
            Value<String> clinicId = const Value.absent(),
            Value<String> priority = const Value.absent(),
            Value<String> specialty = const Value.absent(),
            Value<String?> observation = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WaitListLocalCompanion(
            id: id,
            patientId: patientId,
            patientName: patientName,
            clinicId: clinicId,
            priority: priority,
            specialty: specialty,
            observation: observation,
            createdAt: createdAt,
            isSynced: isSynced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String patientId,
            required String patientName,
            required String clinicId,
            required String priority,
            required String specialty,
            Value<String?> observation = const Value.absent(),
            required DateTime createdAt,
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WaitListLocalCompanion.insert(
            id: id,
            patientId: patientId,
            patientName: patientName,
            clinicId: clinicId,
            priority: priority,
            specialty: specialty,
            observation: observation,
            createdAt: createdAt,
            isSynced: isSynced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WaitListLocalTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WaitListLocalTable,
    WaitListLocalData,
    $$WaitListLocalTableFilterComposer,
    $$WaitListLocalTableOrderingComposer,
    $$WaitListLocalTableAnnotationComposer,
    $$WaitListLocalTableCreateCompanionBuilder,
    $$WaitListLocalTableUpdateCompanionBuilder,
    (
      WaitListLocalData,
      BaseReferences<_$AppDatabase, $WaitListLocalTable, WaitListLocalData>
    ),
    WaitListLocalData,
    PrefetchHooks Function()>;
typedef $$AuditLocalTableCreateCompanionBuilder = AuditLocalCompanion Function({
  Value<int> id,
  required String resourceId,
  required String action,
  required DateTime timestamp,
  Value<bool> isSynced,
});
typedef $$AuditLocalTableUpdateCompanionBuilder = AuditLocalCompanion Function({
  Value<int> id,
  Value<String> resourceId,
  Value<String> action,
  Value<DateTime> timestamp,
  Value<bool> isSynced,
});

class $$AuditLocalTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLocalTable> {
  $$AuditLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get resourceId => $composableBuilder(
      column: $table.resourceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get action => $composableBuilder(
      column: $table.action, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$AuditLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLocalTable> {
  $$AuditLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get resourceId => $composableBuilder(
      column: $table.resourceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get action => $composableBuilder(
      column: $table.action, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$AuditLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLocalTable> {
  $$AuditLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get resourceId => $composableBuilder(
      column: $table.resourceId, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$AuditLocalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AuditLocalTable,
    AuditLocalData,
    $$AuditLocalTableFilterComposer,
    $$AuditLocalTableOrderingComposer,
    $$AuditLocalTableAnnotationComposer,
    $$AuditLocalTableCreateCompanionBuilder,
    $$AuditLocalTableUpdateCompanionBuilder,
    (
      AuditLocalData,
      BaseReferences<_$AppDatabase, $AuditLocalTable, AuditLocalData>
    ),
    AuditLocalData,
    PrefetchHooks Function()> {
  $$AuditLocalTableTableManager(_$AppDatabase db, $AuditLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> resourceId = const Value.absent(),
            Value<String> action = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
          }) =>
              AuditLocalCompanion(
            id: id,
            resourceId: resourceId,
            action: action,
            timestamp: timestamp,
            isSynced: isSynced,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String resourceId,
            required String action,
            required DateTime timestamp,
            Value<bool> isSynced = const Value.absent(),
          }) =>
              AuditLocalCompanion.insert(
            id: id,
            resourceId: resourceId,
            action: action,
            timestamp: timestamp,
            isSynced: isSynced,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AuditLocalTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AuditLocalTable,
    AuditLocalData,
    $$AuditLocalTableFilterComposer,
    $$AuditLocalTableOrderingComposer,
    $$AuditLocalTableAnnotationComposer,
    $$AuditLocalTableCreateCompanionBuilder,
    $$AuditLocalTableUpdateCompanionBuilder,
    (
      AuditLocalData,
      BaseReferences<_$AppDatabase, $AuditLocalTable, AuditLocalData>
    ),
    AuditLocalData,
    PrefetchHooks Function()>;
typedef $$AnamneseLocalTableCreateCompanionBuilder = AnamneseLocalCompanion
    Function({
  required String patientId,
  required String responsesJson,
  required DateTime lastUpdated,
  Value<bool> isSynced,
  Value<int> rowid,
});
typedef $$AnamneseLocalTableUpdateCompanionBuilder = AnamneseLocalCompanion
    Function({
  Value<String> patientId,
  Value<String> responsesJson,
  Value<DateTime> lastUpdated,
  Value<bool> isSynced,
  Value<int> rowid,
});

class $$AnamneseLocalTableFilterComposer
    extends Composer<_$AppDatabase, $AnamneseLocalTable> {
  $$AnamneseLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get responsesJson => $composableBuilder(
      column: $table.responsesJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$AnamneseLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $AnamneseLocalTable> {
  $$AnamneseLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get responsesJson => $composableBuilder(
      column: $table.responsesJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$AnamneseLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnamneseLocalTable> {
  $$AnamneseLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get responsesJson => $composableBuilder(
      column: $table.responsesJson, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$AnamneseLocalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AnamneseLocalTable,
    AnamneseLocalData,
    $$AnamneseLocalTableFilterComposer,
    $$AnamneseLocalTableOrderingComposer,
    $$AnamneseLocalTableAnnotationComposer,
    $$AnamneseLocalTableCreateCompanionBuilder,
    $$AnamneseLocalTableUpdateCompanionBuilder,
    (
      AnamneseLocalData,
      BaseReferences<_$AppDatabase, $AnamneseLocalTable, AnamneseLocalData>
    ),
    AnamneseLocalData,
    PrefetchHooks Function()> {
  $$AnamneseLocalTableTableManager(_$AppDatabase db, $AnamneseLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnamneseLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnamneseLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnamneseLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> patientId = const Value.absent(),
            Value<String> responsesJson = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AnamneseLocalCompanion(
            patientId: patientId,
            responsesJson: responsesJson,
            lastUpdated: lastUpdated,
            isSynced: isSynced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String patientId,
            required String responsesJson,
            required DateTime lastUpdated,
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AnamneseLocalCompanion.insert(
            patientId: patientId,
            responsesJson: responsesJson,
            lastUpdated: lastUpdated,
            isSynced: isSynced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AnamneseLocalTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AnamneseLocalTable,
    AnamneseLocalData,
    $$AnamneseLocalTableFilterComposer,
    $$AnamneseLocalTableOrderingComposer,
    $$AnamneseLocalTableAnnotationComposer,
    $$AnamneseLocalTableCreateCompanionBuilder,
    $$AnamneseLocalTableUpdateCompanionBuilder,
    (
      AnamneseLocalData,
      BaseReferences<_$AppDatabase, $AnamneseLocalTable, AnamneseLocalData>
    ),
    AnamneseLocalData,
    PrefetchHooks Function()>;
typedef $$AppointmentsLocalTableCreateCompanionBuilder
    = AppointmentsLocalCompanion Function({
  required String id,
  Value<String> patientId,
  required String patientName,
  Value<String> doctorId,
  Value<String> doctorName,
  required DateTime startTime,
  required DateTime endTime,
  required String status,
  Value<String?> procedureName,
  Value<String?> notes,
  Value<String> clinicId,
  Value<bool> isSynced,
  Value<int> rowid,
});
typedef $$AppointmentsLocalTableUpdateCompanionBuilder
    = AppointmentsLocalCompanion Function({
  Value<String> id,
  Value<String> patientId,
  Value<String> patientName,
  Value<String> doctorId,
  Value<String> doctorName,
  Value<DateTime> startTime,
  Value<DateTime> endTime,
  Value<String> status,
  Value<String?> procedureName,
  Value<String?> notes,
  Value<String> clinicId,
  Value<bool> isSynced,
  Value<int> rowid,
});

class $$AppointmentsLocalTableFilterComposer
    extends Composer<_$AppDatabase, $AppointmentsLocalTable> {
  $$AppointmentsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patientName => $composableBuilder(
      column: $table.patientName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get doctorId => $composableBuilder(
      column: $table.doctorId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get doctorName => $composableBuilder(
      column: $table.doctorName, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get procedureName => $composableBuilder(
      column: $table.procedureName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clinicId => $composableBuilder(
      column: $table.clinicId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$AppointmentsLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $AppointmentsLocalTable> {
  $$AppointmentsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patientName => $composableBuilder(
      column: $table.patientName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get doctorId => $composableBuilder(
      column: $table.doctorId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get doctorName => $composableBuilder(
      column: $table.doctorName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get procedureName => $composableBuilder(
      column: $table.procedureName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clinicId => $composableBuilder(
      column: $table.clinicId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$AppointmentsLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppointmentsLocalTable> {
  $$AppointmentsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get patientName => $composableBuilder(
      column: $table.patientName, builder: (column) => column);

  GeneratedColumn<String> get doctorId =>
      $composableBuilder(column: $table.doctorId, builder: (column) => column);

  GeneratedColumn<String> get doctorName => $composableBuilder(
      column: $table.doctorName, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get procedureName => $composableBuilder(
      column: $table.procedureName, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get clinicId =>
      $composableBuilder(column: $table.clinicId, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$AppointmentsLocalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppointmentsLocalTable,
    AppointmentsLocalData,
    $$AppointmentsLocalTableFilterComposer,
    $$AppointmentsLocalTableOrderingComposer,
    $$AppointmentsLocalTableAnnotationComposer,
    $$AppointmentsLocalTableCreateCompanionBuilder,
    $$AppointmentsLocalTableUpdateCompanionBuilder,
    (
      AppointmentsLocalData,
      BaseReferences<_$AppDatabase, $AppointmentsLocalTable,
          AppointmentsLocalData>
    ),
    AppointmentsLocalData,
    PrefetchHooks Function()> {
  $$AppointmentsLocalTableTableManager(
      _$AppDatabase db, $AppointmentsLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppointmentsLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppointmentsLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppointmentsLocalTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> patientId = const Value.absent(),
            Value<String> patientName = const Value.absent(),
            Value<String> doctorId = const Value.absent(),
            Value<String> doctorName = const Value.absent(),
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime> endTime = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> procedureName = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> clinicId = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppointmentsLocalCompanion(
            id: id,
            patientId: patientId,
            patientName: patientName,
            doctorId: doctorId,
            doctorName: doctorName,
            startTime: startTime,
            endTime: endTime,
            status: status,
            procedureName: procedureName,
            notes: notes,
            clinicId: clinicId,
            isSynced: isSynced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String> patientId = const Value.absent(),
            required String patientName,
            Value<String> doctorId = const Value.absent(),
            Value<String> doctorName = const Value.absent(),
            required DateTime startTime,
            required DateTime endTime,
            required String status,
            Value<String?> procedureName = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> clinicId = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppointmentsLocalCompanion.insert(
            id: id,
            patientId: patientId,
            patientName: patientName,
            doctorId: doctorId,
            doctorName: doctorName,
            startTime: startTime,
            endTime: endTime,
            status: status,
            procedureName: procedureName,
            notes: notes,
            clinicId: clinicId,
            isSynced: isSynced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppointmentsLocalTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppointmentsLocalTable,
    AppointmentsLocalData,
    $$AppointmentsLocalTableFilterComposer,
    $$AppointmentsLocalTableOrderingComposer,
    $$AppointmentsLocalTableAnnotationComposer,
    $$AppointmentsLocalTableCreateCompanionBuilder,
    $$AppointmentsLocalTableUpdateCompanionBuilder,
    (
      AppointmentsLocalData,
      BaseReferences<_$AppDatabase, $AppointmentsLocalTable,
          AppointmentsLocalData>
    ),
    AppointmentsLocalData,
    PrefetchHooks Function()>;
typedef $$EvolutionsLocalTableCreateCompanionBuilder = EvolutionsLocalCompanion
    Function({
  required String id,
  required String patientId,
  required String description,
  Value<String?> professorId,
  required DateTime createdAt,
  Value<bool> isSynced,
  Value<int> rowid,
});
typedef $$EvolutionsLocalTableUpdateCompanionBuilder = EvolutionsLocalCompanion
    Function({
  Value<String> id,
  Value<String> patientId,
  Value<String> description,
  Value<String?> professorId,
  Value<DateTime> createdAt,
  Value<bool> isSynced,
  Value<int> rowid,
});

class $$EvolutionsLocalTableFilterComposer
    extends Composer<_$AppDatabase, $EvolutionsLocalTable> {
  $$EvolutionsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get professorId => $composableBuilder(
      column: $table.professorId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$EvolutionsLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $EvolutionsLocalTable> {
  $$EvolutionsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get professorId => $composableBuilder(
      column: $table.professorId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$EvolutionsLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $EvolutionsLocalTable> {
  $$EvolutionsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get professorId => $composableBuilder(
      column: $table.professorId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$EvolutionsLocalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EvolutionsLocalTable,
    EvolutionsLocalData,
    $$EvolutionsLocalTableFilterComposer,
    $$EvolutionsLocalTableOrderingComposer,
    $$EvolutionsLocalTableAnnotationComposer,
    $$EvolutionsLocalTableCreateCompanionBuilder,
    $$EvolutionsLocalTableUpdateCompanionBuilder,
    (
      EvolutionsLocalData,
      BaseReferences<_$AppDatabase, $EvolutionsLocalTable, EvolutionsLocalData>
    ),
    EvolutionsLocalData,
    PrefetchHooks Function()> {
  $$EvolutionsLocalTableTableManager(
      _$AppDatabase db, $EvolutionsLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EvolutionsLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EvolutionsLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EvolutionsLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> patientId = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String?> professorId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EvolutionsLocalCompanion(
            id: id,
            patientId: patientId,
            description: description,
            professorId: professorId,
            createdAt: createdAt,
            isSynced: isSynced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String patientId,
            required String description,
            Value<String?> professorId = const Value.absent(),
            required DateTime createdAt,
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EvolutionsLocalCompanion.insert(
            id: id,
            patientId: patientId,
            description: description,
            professorId: professorId,
            createdAt: createdAt,
            isSynced: isSynced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EvolutionsLocalTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EvolutionsLocalTable,
    EvolutionsLocalData,
    $$EvolutionsLocalTableFilterComposer,
    $$EvolutionsLocalTableOrderingComposer,
    $$EvolutionsLocalTableAnnotationComposer,
    $$EvolutionsLocalTableCreateCompanionBuilder,
    $$EvolutionsLocalTableUpdateCompanionBuilder,
    (
      EvolutionsLocalData,
      BaseReferences<_$AppDatabase, $EvolutionsLocalTable, EvolutionsLocalData>
    ),
    EvolutionsLocalData,
    PrefetchHooks Function()>;
typedef $$TreatmentItemsLocalTableCreateCompanionBuilder
    = TreatmentItemsLocalCompanion Function({
  required String id,
  required String planId,
  required String procedureName,
  required double value,
  Value<int?> toothNumber,
  required String status,
  Value<bool> isSynced,
  Value<int> rowid,
});
typedef $$TreatmentItemsLocalTableUpdateCompanionBuilder
    = TreatmentItemsLocalCompanion Function({
  Value<String> id,
  Value<String> planId,
  Value<String> procedureName,
  Value<double> value,
  Value<int?> toothNumber,
  Value<String> status,
  Value<bool> isSynced,
  Value<int> rowid,
});

class $$TreatmentItemsLocalTableFilterComposer
    extends Composer<_$AppDatabase, $TreatmentItemsLocalTable> {
  $$TreatmentItemsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get planId => $composableBuilder(
      column: $table.planId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get procedureName => $composableBuilder(
      column: $table.procedureName, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get toothNumber => $composableBuilder(
      column: $table.toothNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$TreatmentItemsLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $TreatmentItemsLocalTable> {
  $$TreatmentItemsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get planId => $composableBuilder(
      column: $table.planId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get procedureName => $composableBuilder(
      column: $table.procedureName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get toothNumber => $composableBuilder(
      column: $table.toothNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$TreatmentItemsLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $TreatmentItemsLocalTable> {
  $$TreatmentItemsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<String> get procedureName => $composableBuilder(
      column: $table.procedureName, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<int> get toothNumber => $composableBuilder(
      column: $table.toothNumber, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$TreatmentItemsLocalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TreatmentItemsLocalTable,
    TreatmentItemsLocalData,
    $$TreatmentItemsLocalTableFilterComposer,
    $$TreatmentItemsLocalTableOrderingComposer,
    $$TreatmentItemsLocalTableAnnotationComposer,
    $$TreatmentItemsLocalTableCreateCompanionBuilder,
    $$TreatmentItemsLocalTableUpdateCompanionBuilder,
    (
      TreatmentItemsLocalData,
      BaseReferences<_$AppDatabase, $TreatmentItemsLocalTable,
          TreatmentItemsLocalData>
    ),
    TreatmentItemsLocalData,
    PrefetchHooks Function()> {
  $$TreatmentItemsLocalTableTableManager(
      _$AppDatabase db, $TreatmentItemsLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TreatmentItemsLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TreatmentItemsLocalTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TreatmentItemsLocalTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> planId = const Value.absent(),
            Value<String> procedureName = const Value.absent(),
            Value<double> value = const Value.absent(),
            Value<int?> toothNumber = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TreatmentItemsLocalCompanion(
            id: id,
            planId: planId,
            procedureName: procedureName,
            value: value,
            toothNumber: toothNumber,
            status: status,
            isSynced: isSynced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String planId,
            required String procedureName,
            required double value,
            Value<int?> toothNumber = const Value.absent(),
            required String status,
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TreatmentItemsLocalCompanion.insert(
            id: id,
            planId: planId,
            procedureName: procedureName,
            value: value,
            toothNumber: toothNumber,
            status: status,
            isSynced: isSynced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TreatmentItemsLocalTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TreatmentItemsLocalTable,
    TreatmentItemsLocalData,
    $$TreatmentItemsLocalTableFilterComposer,
    $$TreatmentItemsLocalTableOrderingComposer,
    $$TreatmentItemsLocalTableAnnotationComposer,
    $$TreatmentItemsLocalTableCreateCompanionBuilder,
    $$TreatmentItemsLocalTableUpdateCompanionBuilder,
    (
      TreatmentItemsLocalData,
      BaseReferences<_$AppDatabase, $TreatmentItemsLocalTable,
          TreatmentItemsLocalData>
    ),
    TreatmentItemsLocalData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PatientsTableTableManager get patients =>
      $$PatientsTableTableManager(_db, _db.patients);
  $$UsersLocalTableTableManager get usersLocal =>
      $$UsersLocalTableTableManager(_db, _db.usersLocal);
  $$AttachmentsLocalTableTableManager get attachmentsLocal =>
      $$AttachmentsLocalTableTableManager(_db, _db.attachmentsLocal);
  $$OdontogramLocalTableTableManager get odontogramLocal =>
      $$OdontogramLocalTableTableManager(_db, _db.odontogramLocal);
  $$WaitListLocalTableTableManager get waitListLocal =>
      $$WaitListLocalTableTableManager(_db, _db.waitListLocal);
  $$AuditLocalTableTableManager get auditLocal =>
      $$AuditLocalTableTableManager(_db, _db.auditLocal);
  $$AnamneseLocalTableTableManager get anamneseLocal =>
      $$AnamneseLocalTableTableManager(_db, _db.anamneseLocal);
  $$AppointmentsLocalTableTableManager get appointmentsLocal =>
      $$AppointmentsLocalTableTableManager(_db, _db.appointmentsLocal);
  $$EvolutionsLocalTableTableManager get evolutionsLocal =>
      $$EvolutionsLocalTableTableManager(_db, _db.evolutionsLocal);
  $$TreatmentItemsLocalTableTableManager get treatmentItemsLocal =>
      $$TreatmentItemsLocalTableTableManager(_db, _db.treatmentItemsLocal);
}
