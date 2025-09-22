// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TripItemsTable extends TripItems
    with TableInfo<$TripItemsTable, TripItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TripItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
  destinations = GeneratedColumn<String>(
    'destinations',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<List<String>>($TripItemsTable.$converterdestinations);
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defaultCurrencyMeta = const VerificationMeta(
    'defaultCurrency',
  );
  @override
  late final GeneratedColumn<String> defaultCurrency = GeneratedColumn<String>(
    'default_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    name,
    destinations,
    startDate,
    endDate,
    defaultCurrency,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trip_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<TripItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('default_currency')) {
      context.handle(
        _defaultCurrencyMeta,
        defaultCurrency.isAcceptableOrUnknown(
          data['default_currency']!,
          _defaultCurrencyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_defaultCurrencyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TripItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TripItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      destinations: $TripItemsTable.$converterdestinations.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}destinations'],
        )!,
      ),
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      )!,
      defaultCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_currency'],
      )!,
    );
  }

  @override
  $TripItemsTable createAlias(String alias) {
    return $TripItemsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterdestinations =
      StringListTypeConverter();
}

class TripItem extends DataClass implements Insertable<TripItem> {
  final int id;
  final DateTime createdAt;
  final String name;
  final List<String> destinations;
  final DateTime startDate;
  final DateTime endDate;
  final String defaultCurrency;
  const TripItem({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.destinations,
    required this.startDate,
    required this.endDate,
    required this.defaultCurrency,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['name'] = Variable<String>(name);
    {
      map['destinations'] = Variable<String>(
        $TripItemsTable.$converterdestinations.toSql(destinations),
      );
    }
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    map['default_currency'] = Variable<String>(defaultCurrency);
    return map;
  }

  TripItemsCompanion toCompanion(bool nullToAbsent) {
    return TripItemsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      name: Value(name),
      destinations: Value(destinations),
      startDate: Value(startDate),
      endDate: Value(endDate),
      defaultCurrency: Value(defaultCurrency),
    );
  }

  factory TripItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TripItem(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      name: serializer.fromJson<String>(json['name']),
      destinations: serializer.fromJson<List<String>>(json['destinations']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      defaultCurrency: serializer.fromJson<String>(json['defaultCurrency']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'name': serializer.toJson<String>(name),
      'destinations': serializer.toJson<List<String>>(destinations),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'defaultCurrency': serializer.toJson<String>(defaultCurrency),
    };
  }

  TripItem copyWith({
    int? id,
    DateTime? createdAt,
    String? name,
    List<String>? destinations,
    DateTime? startDate,
    DateTime? endDate,
    String? defaultCurrency,
  }) => TripItem(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    name: name ?? this.name,
    destinations: destinations ?? this.destinations,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    defaultCurrency: defaultCurrency ?? this.defaultCurrency,
  );
  TripItem copyWithCompanion(TripItemsCompanion data) {
    return TripItem(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      name: data.name.present ? data.name.value : this.name,
      destinations: data.destinations.present
          ? data.destinations.value
          : this.destinations,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      defaultCurrency: data.defaultCurrency.present
          ? data.defaultCurrency.value
          : this.defaultCurrency,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TripItem(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('name: $name, ')
          ..write('destinations: $destinations, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('defaultCurrency: $defaultCurrency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    name,
    destinations,
    startDate,
    endDate,
    defaultCurrency,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TripItem &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.name == this.name &&
          other.destinations == this.destinations &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.defaultCurrency == this.defaultCurrency);
}

class TripItemsCompanion extends UpdateCompanion<TripItem> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<String> name;
  final Value<List<String>> destinations;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<String> defaultCurrency;
  const TripItemsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.name = const Value.absent(),
    this.destinations = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.defaultCurrency = const Value.absent(),
  });
  TripItemsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    required String name,
    required List<String> destinations,
    required DateTime startDate,
    required DateTime endDate,
    required String defaultCurrency,
  }) : name = Value(name),
       destinations = Value(destinations),
       startDate = Value(startDate),
       endDate = Value(endDate),
       defaultCurrency = Value(defaultCurrency);
  static Insertable<TripItem> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? name,
    Expression<String>? destinations,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? defaultCurrency,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (name != null) 'name': name,
      if (destinations != null) 'destinations': destinations,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (defaultCurrency != null) 'default_currency': defaultCurrency,
    });
  }

  TripItemsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<String>? name,
    Value<List<String>>? destinations,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<String>? defaultCurrency,
  }) {
    return TripItemsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      destinations: destinations ?? this.destinations,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (destinations.present) {
      map['destinations'] = Variable<String>(
        $TripItemsTable.$converterdestinations.toSql(destinations.value),
      );
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (defaultCurrency.present) {
      map['default_currency'] = Variable<String>(defaultCurrency.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TripItemsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('name: $name, ')
          ..write('destinations: $destinations, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('defaultCurrency: $defaultCurrency')
          ..write(')'))
        .toString();
  }
}

class $BudgetItemsTable extends BudgetItems
    with TableInfo<$BudgetItemsTable, BudgetItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descMeta = const VerificationMeta('desc');
  @override
  late final GeneratedColumn<String> desc = GeneratedColumn<String>(
    'desc',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _periodDaysMeta = const VerificationMeta(
    'periodDays',
  );
  @override
  late final GeneratedColumn<int> periodDays = GeneratedColumn<int>(
    'period_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tripMeta = const VerificationMeta('trip');
  @override
  late final GeneratedColumn<int> trip = GeneratedColumn<int>(
    'trip',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trip_items (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    name,
    desc,
    amount,
    periodDays,
    trip,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('desc')) {
      context.handle(
        _descMeta,
        desc.isAcceptableOrUnknown(data['desc']!, _descMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('period_days')) {
      context.handle(
        _periodDaysMeta,
        periodDays.isAcceptableOrUnknown(data['period_days']!, _periodDaysMeta),
      );
    } else if (isInserting) {
      context.missing(_periodDaysMeta);
    }
    if (data.containsKey('trip')) {
      context.handle(
        _tripMeta,
        trip.isAcceptableOrUnknown(data['trip']!, _tripMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      desc: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}desc'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      periodDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}period_days'],
      )!,
      trip: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trip'],
      ),
    );
  }

  @override
  $BudgetItemsTable createAlias(String alias) {
    return $BudgetItemsTable(attachedDatabase, alias);
  }
}

class BudgetItem extends DataClass implements Insertable<BudgetItem> {
  final int id;
  final DateTime createdAt;
  final String name;
  final String? desc;
  final int amount;
  final int periodDays;
  final int? trip;
  const BudgetItem({
    required this.id,
    required this.createdAt,
    required this.name,
    this.desc,
    required this.amount,
    required this.periodDays,
    this.trip,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || desc != null) {
      map['desc'] = Variable<String>(desc);
    }
    map['amount'] = Variable<int>(amount);
    map['period_days'] = Variable<int>(periodDays);
    if (!nullToAbsent || trip != null) {
      map['trip'] = Variable<int>(trip);
    }
    return map;
  }

  BudgetItemsCompanion toCompanion(bool nullToAbsent) {
    return BudgetItemsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      name: Value(name),
      desc: desc == null && nullToAbsent ? const Value.absent() : Value(desc),
      amount: Value(amount),
      periodDays: Value(periodDays),
      trip: trip == null && nullToAbsent ? const Value.absent() : Value(trip),
    );
  }

  factory BudgetItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetItem(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      name: serializer.fromJson<String>(json['name']),
      desc: serializer.fromJson<String?>(json['desc']),
      amount: serializer.fromJson<int>(json['amount']),
      periodDays: serializer.fromJson<int>(json['periodDays']),
      trip: serializer.fromJson<int?>(json['trip']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'name': serializer.toJson<String>(name),
      'desc': serializer.toJson<String?>(desc),
      'amount': serializer.toJson<int>(amount),
      'periodDays': serializer.toJson<int>(periodDays),
      'trip': serializer.toJson<int?>(trip),
    };
  }

  BudgetItem copyWith({
    int? id,
    DateTime? createdAt,
    String? name,
    Value<String?> desc = const Value.absent(),
    int? amount,
    int? periodDays,
    Value<int?> trip = const Value.absent(),
  }) => BudgetItem(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    name: name ?? this.name,
    desc: desc.present ? desc.value : this.desc,
    amount: amount ?? this.amount,
    periodDays: periodDays ?? this.periodDays,
    trip: trip.present ? trip.value : this.trip,
  );
  BudgetItem copyWithCompanion(BudgetItemsCompanion data) {
    return BudgetItem(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      name: data.name.present ? data.name.value : this.name,
      desc: data.desc.present ? data.desc.value : this.desc,
      amount: data.amount.present ? data.amount.value : this.amount,
      periodDays: data.periodDays.present
          ? data.periodDays.value
          : this.periodDays,
      trip: data.trip.present ? data.trip.value : this.trip,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetItem(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('name: $name, ')
          ..write('desc: $desc, ')
          ..write('amount: $amount, ')
          ..write('periodDays: $periodDays, ')
          ..write('trip: $trip')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, name, desc, amount, periodDays, trip);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetItem &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.name == this.name &&
          other.desc == this.desc &&
          other.amount == this.amount &&
          other.periodDays == this.periodDays &&
          other.trip == this.trip);
}

class BudgetItemsCompanion extends UpdateCompanion<BudgetItem> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<String> name;
  final Value<String?> desc;
  final Value<int> amount;
  final Value<int> periodDays;
  final Value<int?> trip;
  const BudgetItemsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.name = const Value.absent(),
    this.desc = const Value.absent(),
    this.amount = const Value.absent(),
    this.periodDays = const Value.absent(),
    this.trip = const Value.absent(),
  });
  BudgetItemsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    required String name,
    this.desc = const Value.absent(),
    required int amount,
    required int periodDays,
    this.trip = const Value.absent(),
  }) : name = Value(name),
       amount = Value(amount),
       periodDays = Value(periodDays);
  static Insertable<BudgetItem> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? name,
    Expression<String>? desc,
    Expression<int>? amount,
    Expression<int>? periodDays,
    Expression<int>? trip,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (name != null) 'name': name,
      if (desc != null) 'desc': desc,
      if (amount != null) 'amount': amount,
      if (periodDays != null) 'period_days': periodDays,
      if (trip != null) 'trip': trip,
    });
  }

  BudgetItemsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<String>? name,
    Value<String?>? desc,
    Value<int>? amount,
    Value<int>? periodDays,
    Value<int?>? trip,
  }) {
    return BudgetItemsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      amount: amount ?? this.amount,
      periodDays: periodDays ?? this.periodDays,
      trip: trip ?? this.trip,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (desc.present) {
      map['desc'] = Variable<String>(desc.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (periodDays.present) {
      map['period_days'] = Variable<int>(periodDays.value);
    }
    if (trip.present) {
      map['trip'] = Variable<int>(trip.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetItemsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('name: $name, ')
          ..write('desc: $desc, ')
          ..write('amount: $amount, ')
          ..write('periodDays: $periodDays, ')
          ..write('trip: $trip')
          ..write(')'))
        .toString();
  }
}

class $ExpenseItemsTable extends ExpenseItems
    with TableInfo<$ExpenseItemsTable, ExpenseItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descMeta = const VerificationMeta('desc');
  @override
  late final GeneratedColumn<String> desc = GeneratedColumn<String>(
    'desc',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tripIdMeta = const VerificationMeta('tripId');
  @override
  late final GeneratedColumn<int> tripId = GeneratedColumn<int>(
    'trip_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trip_items (id)',
    ),
  );
  static const VerificationMeta _budgetIdMeta = const VerificationMeta(
    'budgetId',
  );
  @override
  late final GeneratedColumn<int> budgetId = GeneratedColumn<int>(
    'budget_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES budget_items (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    amount,
    desc,
    time,
    currency,
    tripId,
    budgetId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('desc')) {
      context.handle(
        _descMeta,
        desc.isAcceptableOrUnknown(data['desc']!, _descMeta),
      );
    } else if (isInserting) {
      context.missing(_descMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('trip_id')) {
      context.handle(
        _tripIdMeta,
        tripId.isAcceptableOrUnknown(data['trip_id']!, _tripIdMeta),
      );
    }
    if (data.containsKey('budget_id')) {
      context.handle(
        _budgetIdMeta,
        budgetId.isAcceptableOrUnknown(data['budget_id']!, _budgetIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      desc: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}desc'],
      )!,
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}time'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      tripId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trip_id'],
      ),
      budgetId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}budget_id'],
      ),
    );
  }

  @override
  $ExpenseItemsTable createAlias(String alias) {
    return $ExpenseItemsTable(attachedDatabase, alias);
  }
}

class ExpenseItem extends DataClass implements Insertable<ExpenseItem> {
  final int id;
  final DateTime createdAt;
  final double amount;
  final String desc;
  final DateTime time;
  final String currency;
  final int? tripId;
  final int? budgetId;
  const ExpenseItem({
    required this.id,
    required this.createdAt,
    required this.amount,
    required this.desc,
    required this.time,
    required this.currency,
    this.tripId,
    this.budgetId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['amount'] = Variable<double>(amount);
    map['desc'] = Variable<String>(desc);
    map['time'] = Variable<DateTime>(time);
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || tripId != null) {
      map['trip_id'] = Variable<int>(tripId);
    }
    if (!nullToAbsent || budgetId != null) {
      map['budget_id'] = Variable<int>(budgetId);
    }
    return map;
  }

  ExpenseItemsCompanion toCompanion(bool nullToAbsent) {
    return ExpenseItemsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      amount: Value(amount),
      desc: Value(desc),
      time: Value(time),
      currency: Value(currency),
      tripId: tripId == null && nullToAbsent
          ? const Value.absent()
          : Value(tripId),
      budgetId: budgetId == null && nullToAbsent
          ? const Value.absent()
          : Value(budgetId),
    );
  }

  factory ExpenseItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseItem(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      amount: serializer.fromJson<double>(json['amount']),
      desc: serializer.fromJson<String>(json['desc']),
      time: serializer.fromJson<DateTime>(json['time']),
      currency: serializer.fromJson<String>(json['currency']),
      tripId: serializer.fromJson<int?>(json['tripId']),
      budgetId: serializer.fromJson<int?>(json['budgetId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'amount': serializer.toJson<double>(amount),
      'desc': serializer.toJson<String>(desc),
      'time': serializer.toJson<DateTime>(time),
      'currency': serializer.toJson<String>(currency),
      'tripId': serializer.toJson<int?>(tripId),
      'budgetId': serializer.toJson<int?>(budgetId),
    };
  }

  ExpenseItem copyWith({
    int? id,
    DateTime? createdAt,
    double? amount,
    String? desc,
    DateTime? time,
    String? currency,
    Value<int?> tripId = const Value.absent(),
    Value<int?> budgetId = const Value.absent(),
  }) => ExpenseItem(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    amount: amount ?? this.amount,
    desc: desc ?? this.desc,
    time: time ?? this.time,
    currency: currency ?? this.currency,
    tripId: tripId.present ? tripId.value : this.tripId,
    budgetId: budgetId.present ? budgetId.value : this.budgetId,
  );
  ExpenseItem copyWithCompanion(ExpenseItemsCompanion data) {
    return ExpenseItem(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      amount: data.amount.present ? data.amount.value : this.amount,
      desc: data.desc.present ? data.desc.value : this.desc,
      time: data.time.present ? data.time.value : this.time,
      currency: data.currency.present ? data.currency.value : this.currency,
      tripId: data.tripId.present ? data.tripId.value : this.tripId,
      budgetId: data.budgetId.present ? data.budgetId.value : this.budgetId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseItem(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('amount: $amount, ')
          ..write('desc: $desc, ')
          ..write('time: $time, ')
          ..write('currency: $currency, ')
          ..write('tripId: $tripId, ')
          ..write('budgetId: $budgetId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    amount,
    desc,
    time,
    currency,
    tripId,
    budgetId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseItem &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.amount == this.amount &&
          other.desc == this.desc &&
          other.time == this.time &&
          other.currency == this.currency &&
          other.tripId == this.tripId &&
          other.budgetId == this.budgetId);
}

class ExpenseItemsCompanion extends UpdateCompanion<ExpenseItem> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<double> amount;
  final Value<String> desc;
  final Value<DateTime> time;
  final Value<String> currency;
  final Value<int?> tripId;
  final Value<int?> budgetId;
  const ExpenseItemsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.amount = const Value.absent(),
    this.desc = const Value.absent(),
    this.time = const Value.absent(),
    this.currency = const Value.absent(),
    this.tripId = const Value.absent(),
    this.budgetId = const Value.absent(),
  });
  ExpenseItemsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    required double amount,
    required String desc,
    required DateTime time,
    required String currency,
    this.tripId = const Value.absent(),
    this.budgetId = const Value.absent(),
  }) : amount = Value(amount),
       desc = Value(desc),
       time = Value(time),
       currency = Value(currency);
  static Insertable<ExpenseItem> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<double>? amount,
    Expression<String>? desc,
    Expression<DateTime>? time,
    Expression<String>? currency,
    Expression<int>? tripId,
    Expression<int>? budgetId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (amount != null) 'amount': amount,
      if (desc != null) 'desc': desc,
      if (time != null) 'time': time,
      if (currency != null) 'currency': currency,
      if (tripId != null) 'trip_id': tripId,
      if (budgetId != null) 'budget_id': budgetId,
    });
  }

  ExpenseItemsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<double>? amount,
    Value<String>? desc,
    Value<DateTime>? time,
    Value<String>? currency,
    Value<int?>? tripId,
    Value<int?>? budgetId,
  }) {
    return ExpenseItemsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      amount: amount ?? this.amount,
      desc: desc ?? this.desc,
      time: time ?? this.time,
      currency: currency ?? this.currency,
      tripId: tripId ?? this.tripId,
      budgetId: budgetId ?? this.budgetId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (desc.present) {
      map['desc'] = Variable<String>(desc.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (tripId.present) {
      map['trip_id'] = Variable<int>(tripId.value);
    }
    if (budgetId.present) {
      map['budget_id'] = Variable<int>(budgetId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseItemsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('amount: $amount, ')
          ..write('desc: $desc, ')
          ..write('time: $time, ')
          ..write('currency: $currency, ')
          ..write('tripId: $tripId, ')
          ..write('budgetId: $budgetId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TripItemsTable tripItems = $TripItemsTable(this);
  late final $BudgetItemsTable budgetItems = $BudgetItemsTable(this);
  late final $ExpenseItemsTable expenseItems = $ExpenseItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    tripItems,
    budgetItems,
    expenseItems,
  ];
}

typedef $$TripItemsTableCreateCompanionBuilder =
    TripItemsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      required String name,
      required List<String> destinations,
      required DateTime startDate,
      required DateTime endDate,
      required String defaultCurrency,
    });
typedef $$TripItemsTableUpdateCompanionBuilder =
    TripItemsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<String> name,
      Value<List<String>> destinations,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<String> defaultCurrency,
    });

final class $$TripItemsTableReferences
    extends BaseReferences<_$AppDatabase, $TripItemsTable, TripItem> {
  $$TripItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BudgetItemsTable, List<BudgetItem>>
  _budgetItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.budgetItems,
    aliasName: $_aliasNameGenerator(db.tripItems.id, db.budgetItems.trip),
  );

  $$BudgetItemsTableProcessedTableManager get budgetItemsRefs {
    final manager = $$BudgetItemsTableTableManager(
      $_db,
      $_db.budgetItems,
    ).filter((f) => f.trip.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_budgetItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExpenseItemsTable, List<ExpenseItem>>
  _expenseItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.expenseItems,
    aliasName: $_aliasNameGenerator(db.tripItems.id, db.expenseItems.tripId),
  );

  $$ExpenseItemsTableProcessedTableManager get expenseItemsRefs {
    final manager = $$ExpenseItemsTableTableManager(
      $_db,
      $_db.expenseItems,
    ).filter((f) => f.tripId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_expenseItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TripItemsTableFilterComposer
    extends Composer<_$AppDatabase, $TripItemsTable> {
  $$TripItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get destinations => $composableBuilder(
    column: $table.destinations,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> budgetItemsRefs(
    Expression<bool> Function($$BudgetItemsTableFilterComposer f) f,
  ) {
    final $$BudgetItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetItems,
      getReferencedColumn: (t) => t.trip,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetItemsTableFilterComposer(
            $db: $db,
            $table: $db.budgetItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> expenseItemsRefs(
    Expression<bool> Function($$ExpenseItemsTableFilterComposer f) f,
  ) {
    final $$ExpenseItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenseItems,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpenseItemsTableFilterComposer(
            $db: $db,
            $table: $db.expenseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TripItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $TripItemsTable> {
  $$TripItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get destinations => $composableBuilder(
    column: $table.destinations,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TripItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TripItemsTable> {
  $$TripItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get destinations =>
      $composableBuilder(
        column: $table.destinations,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => column,
  );

  Expression<T> budgetItemsRefs<T extends Object>(
    Expression<T> Function($$BudgetItemsTableAnnotationComposer a) f,
  ) {
    final $$BudgetItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetItems,
      getReferencedColumn: (t) => t.trip,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> expenseItemsRefs<T extends Object>(
    Expression<T> Function($$ExpenseItemsTableAnnotationComposer a) f,
  ) {
    final $$ExpenseItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenseItems,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpenseItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.expenseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TripItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TripItemsTable,
          TripItem,
          $$TripItemsTableFilterComposer,
          $$TripItemsTableOrderingComposer,
          $$TripItemsTableAnnotationComposer,
          $$TripItemsTableCreateCompanionBuilder,
          $$TripItemsTableUpdateCompanionBuilder,
          (TripItem, $$TripItemsTableReferences),
          TripItem,
          PrefetchHooks Function({bool budgetItemsRefs, bool expenseItemsRefs})
        > {
  $$TripItemsTableTableManager(_$AppDatabase db, $TripItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TripItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TripItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TripItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<List<String>> destinations = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<String> defaultCurrency = const Value.absent(),
              }) => TripItemsCompanion(
                id: id,
                createdAt: createdAt,
                name: name,
                destinations: destinations,
                startDate: startDate,
                endDate: endDate,
                defaultCurrency: defaultCurrency,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                required String name,
                required List<String> destinations,
                required DateTime startDate,
                required DateTime endDate,
                required String defaultCurrency,
              }) => TripItemsCompanion.insert(
                id: id,
                createdAt: createdAt,
                name: name,
                destinations: destinations,
                startDate: startDate,
                endDate: endDate,
                defaultCurrency: defaultCurrency,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TripItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({budgetItemsRefs = false, expenseItemsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (budgetItemsRefs) db.budgetItems,
                    if (expenseItemsRefs) db.expenseItems,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (budgetItemsRefs)
                        await $_getPrefetchedData<
                          TripItem,
                          $TripItemsTable,
                          BudgetItem
                        >(
                          currentTable: table,
                          referencedTable: $$TripItemsTableReferences
                              ._budgetItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TripItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).budgetItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.trip == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (expenseItemsRefs)
                        await $_getPrefetchedData<
                          TripItem,
                          $TripItemsTable,
                          ExpenseItem
                        >(
                          currentTable: table,
                          referencedTable: $$TripItemsTableReferences
                              ._expenseItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TripItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).expenseItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tripId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TripItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TripItemsTable,
      TripItem,
      $$TripItemsTableFilterComposer,
      $$TripItemsTableOrderingComposer,
      $$TripItemsTableAnnotationComposer,
      $$TripItemsTableCreateCompanionBuilder,
      $$TripItemsTableUpdateCompanionBuilder,
      (TripItem, $$TripItemsTableReferences),
      TripItem,
      PrefetchHooks Function({bool budgetItemsRefs, bool expenseItemsRefs})
    >;
typedef $$BudgetItemsTableCreateCompanionBuilder =
    BudgetItemsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      required String name,
      Value<String?> desc,
      required int amount,
      required int periodDays,
      Value<int?> trip,
    });
typedef $$BudgetItemsTableUpdateCompanionBuilder =
    BudgetItemsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<String> name,
      Value<String?> desc,
      Value<int> amount,
      Value<int> periodDays,
      Value<int?> trip,
    });

final class $$BudgetItemsTableReferences
    extends BaseReferences<_$AppDatabase, $BudgetItemsTable, BudgetItem> {
  $$BudgetItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TripItemsTable _tripTable(_$AppDatabase db) => db.tripItems
      .createAlias($_aliasNameGenerator(db.budgetItems.trip, db.tripItems.id));

  $$TripItemsTableProcessedTableManager? get trip {
    final $_column = $_itemColumn<int>('trip');
    if ($_column == null) return null;
    final manager = $$TripItemsTableTableManager(
      $_db,
      $_db.tripItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tripTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ExpenseItemsTable, List<ExpenseItem>>
  _expenseItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.expenseItems,
    aliasName: $_aliasNameGenerator(
      db.budgetItems.id,
      db.expenseItems.budgetId,
    ),
  );

  $$ExpenseItemsTableProcessedTableManager get expenseItemsRefs {
    final manager = $$ExpenseItemsTableTableManager(
      $_db,
      $_db.expenseItems,
    ).filter((f) => f.budgetId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_expenseItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BudgetItemsTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetItemsTable> {
  $$BudgetItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get desc => $composableBuilder(
    column: $table.desc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get periodDays => $composableBuilder(
    column: $table.periodDays,
    builder: (column) => ColumnFilters(column),
  );

  $$TripItemsTableFilterComposer get trip {
    final $$TripItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trip,
      referencedTable: $db.tripItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripItemsTableFilterComposer(
            $db: $db,
            $table: $db.tripItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> expenseItemsRefs(
    Expression<bool> Function($$ExpenseItemsTableFilterComposer f) f,
  ) {
    final $$ExpenseItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenseItems,
      getReferencedColumn: (t) => t.budgetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpenseItemsTableFilterComposer(
            $db: $db,
            $table: $db.expenseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BudgetItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetItemsTable> {
  $$BudgetItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get desc => $composableBuilder(
    column: $table.desc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get periodDays => $composableBuilder(
    column: $table.periodDays,
    builder: (column) => ColumnOrderings(column),
  );

  $$TripItemsTableOrderingComposer get trip {
    final $$TripItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trip,
      referencedTable: $db.tripItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripItemsTableOrderingComposer(
            $db: $db,
            $table: $db.tripItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetItemsTable> {
  $$BudgetItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get desc =>
      $composableBuilder(column: $table.desc, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<int> get periodDays => $composableBuilder(
    column: $table.periodDays,
    builder: (column) => column,
  );

  $$TripItemsTableAnnotationComposer get trip {
    final $$TripItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trip,
      referencedTable: $db.tripItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.tripItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> expenseItemsRefs<T extends Object>(
    Expression<T> Function($$ExpenseItemsTableAnnotationComposer a) f,
  ) {
    final $$ExpenseItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenseItems,
      getReferencedColumn: (t) => t.budgetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpenseItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.expenseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BudgetItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BudgetItemsTable,
          BudgetItem,
          $$BudgetItemsTableFilterComposer,
          $$BudgetItemsTableOrderingComposer,
          $$BudgetItemsTableAnnotationComposer,
          $$BudgetItemsTableCreateCompanionBuilder,
          $$BudgetItemsTableUpdateCompanionBuilder,
          (BudgetItem, $$BudgetItemsTableReferences),
          BudgetItem,
          PrefetchHooks Function({bool trip, bool expenseItemsRefs})
        > {
  $$BudgetItemsTableTableManager(_$AppDatabase db, $BudgetItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> desc = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<int> periodDays = const Value.absent(),
                Value<int?> trip = const Value.absent(),
              }) => BudgetItemsCompanion(
                id: id,
                createdAt: createdAt,
                name: name,
                desc: desc,
                amount: amount,
                periodDays: periodDays,
                trip: trip,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                required String name,
                Value<String?> desc = const Value.absent(),
                required int amount,
                required int periodDays,
                Value<int?> trip = const Value.absent(),
              }) => BudgetItemsCompanion.insert(
                id: id,
                createdAt: createdAt,
                name: name,
                desc: desc,
                amount: amount,
                periodDays: periodDays,
                trip: trip,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BudgetItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({trip = false, expenseItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (expenseItemsRefs) db.expenseItems],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (trip) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.trip,
                                referencedTable: $$BudgetItemsTableReferences
                                    ._tripTable(db),
                                referencedColumn: $$BudgetItemsTableReferences
                                    ._tripTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (expenseItemsRefs)
                    await $_getPrefetchedData<
                      BudgetItem,
                      $BudgetItemsTable,
                      ExpenseItem
                    >(
                      currentTable: table,
                      referencedTable: $$BudgetItemsTableReferences
                          ._expenseItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$BudgetItemsTableReferences(
                            db,
                            table,
                            p0,
                          ).expenseItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.budgetId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BudgetItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BudgetItemsTable,
      BudgetItem,
      $$BudgetItemsTableFilterComposer,
      $$BudgetItemsTableOrderingComposer,
      $$BudgetItemsTableAnnotationComposer,
      $$BudgetItemsTableCreateCompanionBuilder,
      $$BudgetItemsTableUpdateCompanionBuilder,
      (BudgetItem, $$BudgetItemsTableReferences),
      BudgetItem,
      PrefetchHooks Function({bool trip, bool expenseItemsRefs})
    >;
typedef $$ExpenseItemsTableCreateCompanionBuilder =
    ExpenseItemsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      required double amount,
      required String desc,
      required DateTime time,
      required String currency,
      Value<int?> tripId,
      Value<int?> budgetId,
    });
typedef $$ExpenseItemsTableUpdateCompanionBuilder =
    ExpenseItemsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<double> amount,
      Value<String> desc,
      Value<DateTime> time,
      Value<String> currency,
      Value<int?> tripId,
      Value<int?> budgetId,
    });

final class $$ExpenseItemsTableReferences
    extends BaseReferences<_$AppDatabase, $ExpenseItemsTable, ExpenseItem> {
  $$ExpenseItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TripItemsTable _tripIdTable(_$AppDatabase db) =>
      db.tripItems.createAlias(
        $_aliasNameGenerator(db.expenseItems.tripId, db.tripItems.id),
      );

  $$TripItemsTableProcessedTableManager? get tripId {
    final $_column = $_itemColumn<int>('trip_id');
    if ($_column == null) return null;
    final manager = $$TripItemsTableTableManager(
      $_db,
      $_db.tripItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tripIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BudgetItemsTable _budgetIdTable(_$AppDatabase db) =>
      db.budgetItems.createAlias(
        $_aliasNameGenerator(db.expenseItems.budgetId, db.budgetItems.id),
      );

  $$BudgetItemsTableProcessedTableManager? get budgetId {
    final $_column = $_itemColumn<int>('budget_id');
    if ($_column == null) return null;
    final manager = $$BudgetItemsTableTableManager(
      $_db,
      $_db.budgetItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_budgetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExpenseItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ExpenseItemsTable> {
  $$ExpenseItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get desc => $composableBuilder(
    column: $table.desc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  $$TripItemsTableFilterComposer get tripId {
    final $$TripItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.tripItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripItemsTableFilterComposer(
            $db: $db,
            $table: $db.tripItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BudgetItemsTableFilterComposer get budgetId {
    final $$BudgetItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.budgetId,
      referencedTable: $db.budgetItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetItemsTableFilterComposer(
            $db: $db,
            $table: $db.budgetItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpenseItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpenseItemsTable> {
  $$ExpenseItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get desc => $composableBuilder(
    column: $table.desc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  $$TripItemsTableOrderingComposer get tripId {
    final $$TripItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.tripItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripItemsTableOrderingComposer(
            $db: $db,
            $table: $db.tripItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BudgetItemsTableOrderingComposer get budgetId {
    final $$BudgetItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.budgetId,
      referencedTable: $db.budgetItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetItemsTableOrderingComposer(
            $db: $db,
            $table: $db.budgetItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpenseItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpenseItemsTable> {
  $$ExpenseItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get desc =>
      $composableBuilder(column: $table.desc, builder: (column) => column);

  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  $$TripItemsTableAnnotationComposer get tripId {
    final $$TripItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.tripItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.tripItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BudgetItemsTableAnnotationComposer get budgetId {
    final $$BudgetItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.budgetId,
      referencedTable: $db.budgetItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpenseItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpenseItemsTable,
          ExpenseItem,
          $$ExpenseItemsTableFilterComposer,
          $$ExpenseItemsTableOrderingComposer,
          $$ExpenseItemsTableAnnotationComposer,
          $$ExpenseItemsTableCreateCompanionBuilder,
          $$ExpenseItemsTableUpdateCompanionBuilder,
          (ExpenseItem, $$ExpenseItemsTableReferences),
          ExpenseItem,
          PrefetchHooks Function({bool tripId, bool budgetId})
        > {
  $$ExpenseItemsTableTableManager(_$AppDatabase db, $ExpenseItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpenseItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpenseItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpenseItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> desc = const Value.absent(),
                Value<DateTime> time = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int?> tripId = const Value.absent(),
                Value<int?> budgetId = const Value.absent(),
              }) => ExpenseItemsCompanion(
                id: id,
                createdAt: createdAt,
                amount: amount,
                desc: desc,
                time: time,
                currency: currency,
                tripId: tripId,
                budgetId: budgetId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                required double amount,
                required String desc,
                required DateTime time,
                required String currency,
                Value<int?> tripId = const Value.absent(),
                Value<int?> budgetId = const Value.absent(),
              }) => ExpenseItemsCompanion.insert(
                id: id,
                createdAt: createdAt,
                amount: amount,
                desc: desc,
                time: time,
                currency: currency,
                tripId: tripId,
                budgetId: budgetId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExpenseItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tripId = false, budgetId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tripId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tripId,
                                referencedTable: $$ExpenseItemsTableReferences
                                    ._tripIdTable(db),
                                referencedColumn: $$ExpenseItemsTableReferences
                                    ._tripIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (budgetId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.budgetId,
                                referencedTable: $$ExpenseItemsTableReferences
                                    ._budgetIdTable(db),
                                referencedColumn: $$ExpenseItemsTableReferences
                                    ._budgetIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExpenseItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpenseItemsTable,
      ExpenseItem,
      $$ExpenseItemsTableFilterComposer,
      $$ExpenseItemsTableOrderingComposer,
      $$ExpenseItemsTableAnnotationComposer,
      $$ExpenseItemsTableCreateCompanionBuilder,
      $$ExpenseItemsTableUpdateCompanionBuilder,
      (ExpenseItem, $$ExpenseItemsTableReferences),
      ExpenseItem,
      PrefetchHooks Function({bool tripId, bool budgetId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TripItemsTableTableManager get tripItems =>
      $$TripItemsTableTableManager(_db, _db.tripItems);
  $$BudgetItemsTableTableManager get budgetItems =>
      $$BudgetItemsTableTableManager(_db, _db.budgetItems);
  $$ExpenseItemsTableTableManager get expenseItems =>
      $$ExpenseItemsTableTableManager(_db, _db.expenseItems);
}
