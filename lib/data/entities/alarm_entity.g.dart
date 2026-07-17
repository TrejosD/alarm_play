// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAlarmCollection on Isar {
  IsarCollection<Alarm> get alarms => this.collection();
}

const AlarmSchema = CollectionSchema(
  name: r'Alarm',
  id: -6172094888861729789,
  properties: {
    r'ascendingVolume': PropertySchema(
      id: 0,
      name: r'ascendingVolume',
      type: IsarType.bool,
    ),
    r'autoStop': PropertySchema(
      id: 1,
      name: r'autoStop',
      type: IsarType.bool,
    ),
    r'autoStopAfterMinutes': PropertySchema(
      id: 2,
      name: r'autoStopAfterMinutes',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'defaultSound': PropertySchema(
      id: 4,
      name: r'defaultSound',
      type: IsarType.string,
    ),
    r'hour': PropertySchema(
      id: 5,
      name: r'hour',
      type: IsarType.long,
    ),
    r'isActive': PropertySchema(
      id: 6,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'label': PropertySchema(
      id: 7,
      name: r'label',
      type: IsarType.string,
    ),
    r'minute': PropertySchema(
      id: 8,
      name: r'minute',
      type: IsarType.long,
    ),
    r'nextTrigger': PropertySchema(
      id: 9,
      name: r'nextTrigger',
      type: IsarType.dateTime,
    ),
    r'playOnce': PropertySchema(
      id: 10,
      name: r'playOnce',
      type: IsarType.bool,
    ),
    r'playbackMode': PropertySchema(
      id: 11,
      name: r'playbackMode',
      type: IsarType.byte,
      enumMap: _AlarmplaybackModeEnumValueMap,
    ),
    r'playlistId': PropertySchema(
      id: 12,
      name: r'playlistId',
      type: IsarType.long,
    ),
    r'repeatDays': PropertySchema(
      id: 13,
      name: r'repeatDays',
      type: IsarType.longList,
    ),
    r'snoozeMinutes': PropertySchema(
      id: 14,
      name: r'snoozeMinutes',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 15,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'vibrateEnabled': PropertySchema(
      id: 16,
      name: r'vibrateEnabled',
      type: IsarType.bool,
    ),
    r'volume': PropertySchema(
      id: 17,
      name: r'volume',
      type: IsarType.double,
    )
  },
  estimateSize: _alarmEstimateSize,
  serialize: _alarmSerialize,
  deserialize: _alarmDeserialize,
  deserializeProp: _alarmDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _alarmGetId,
  getLinks: _alarmGetLinks,
  attach: _alarmAttach,
  version: '3.1.0+1',
);

int _alarmEstimateSize(
  Alarm object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.defaultSound;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.label;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.repeatDays.length * 8;
  return bytesCount;
}

void _alarmSerialize(
  Alarm object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.ascendingVolume);
  writer.writeBool(offsets[1], object.autoStop);
  writer.writeLong(offsets[2], object.autoStopAfterMinutes);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.defaultSound);
  writer.writeLong(offsets[5], object.hour);
  writer.writeBool(offsets[6], object.isActive);
  writer.writeString(offsets[7], object.label);
  writer.writeLong(offsets[8], object.minute);
  writer.writeDateTime(offsets[9], object.nextTrigger);
  writer.writeBool(offsets[10], object.playOnce);
  writer.writeByte(offsets[11], object.playbackMode.index);
  writer.writeLong(offsets[12], object.playlistId);
  writer.writeLongList(offsets[13], object.repeatDays);
  writer.writeLong(offsets[14], object.snoozeMinutes);
  writer.writeDateTime(offsets[15], object.updatedAt);
  writer.writeBool(offsets[16], object.vibrateEnabled);
  writer.writeDouble(offsets[17], object.volume);
}

Alarm _alarmDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Alarm(
    ascendingVolume: reader.readBool(offsets[0]),
    autoStop: reader.readBool(offsets[1]),
    autoStopAfterMinutes: reader.readLong(offsets[2]),
    createdAt: reader.readDateTime(offsets[3]),
    defaultSound: reader.readStringOrNull(offsets[4]),
    hour: reader.readLong(offsets[5]),
    id: id,
    isActive: reader.readBool(offsets[6]),
    label: reader.readStringOrNull(offsets[7]),
    minute: reader.readLong(offsets[8]),
    nextTrigger: reader.readDateTimeOrNull(offsets[9]),
    playOnce: reader.readBool(offsets[10]),
    playbackMode:
        _AlarmplaybackModeValueEnumMap[reader.readByteOrNull(offsets[11])] ??
            PlaybackMode.shuffle,
    playlistId: reader.readLong(offsets[12]),
    repeatDays: reader.readLongList(offsets[13]) ?? [],
    snoozeMinutes: reader.readLong(offsets[14]),
    updatedAt: reader.readDateTime(offsets[15]),
    vibrateEnabled: reader.readBool(offsets[16]),
    volume: reader.readDouble(offsets[17]),
  );
  return object;
}

P _alarmDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (_AlarmplaybackModeValueEnumMap[reader.readByteOrNull(offset)] ??
          PlaybackMode.shuffle) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    case 13:
      return (reader.readLongList(offset) ?? []) as P;
    case 14:
      return (reader.readLong(offset)) as P;
    case 15:
      return (reader.readDateTime(offset)) as P;
    case 16:
      return (reader.readBool(offset)) as P;
    case 17:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AlarmplaybackModeEnumValueMap = {
  'shuffle': 0,
  'sequential': 1,
};
const _AlarmplaybackModeValueEnumMap = {
  0: PlaybackMode.shuffle,
  1: PlaybackMode.sequential,
};

Id _alarmGetId(Alarm object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _alarmGetLinks(Alarm object) {
  return [];
}

void _alarmAttach(IsarCollection<dynamic> col, Id id, Alarm object) {
  object.id = id;
}

extension AlarmQueryWhereSort on QueryBuilder<Alarm, Alarm, QWhere> {
  QueryBuilder<Alarm, Alarm, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AlarmQueryWhere on QueryBuilder<Alarm, Alarm, QWhereClause> {
  QueryBuilder<Alarm, Alarm, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AlarmQueryFilter on QueryBuilder<Alarm, Alarm, QFilterCondition> {
  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> ascendingVolumeEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ascendingVolume',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> autoStopEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autoStop',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> autoStopAfterMinutesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autoStopAfterMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition>
      autoStopAfterMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'autoStopAfterMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition>
      autoStopAfterMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'autoStopAfterMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> autoStopAfterMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'autoStopAfterMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> defaultSoundIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'defaultSound',
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> defaultSoundIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'defaultSound',
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> defaultSoundEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> defaultSoundGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> defaultSoundLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> defaultSoundBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultSound',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> defaultSoundStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'defaultSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> defaultSoundEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'defaultSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> defaultSoundContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'defaultSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> defaultSoundMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'defaultSound',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> defaultSoundIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultSound',
        value: '',
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> defaultSoundIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'defaultSound',
        value: '',
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> hourEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hour',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> hourGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hour',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> hourLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hour',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> hourBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hour',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> isActiveEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> labelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'label',
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> labelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'label',
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> labelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> labelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> labelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> labelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'label',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> labelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> labelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> labelContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> labelMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'label',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> labelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> labelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> minuteEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minute',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> minuteGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minute',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> minuteLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minute',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> minuteBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minute',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> nextTriggerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nextTrigger',
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> nextTriggerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nextTrigger',
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> nextTriggerEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextTrigger',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> nextTriggerGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextTrigger',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> nextTriggerLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextTrigger',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> nextTriggerBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextTrigger',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> playOnceEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playOnce',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> playbackModeEqualTo(
      PlaybackMode value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playbackMode',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> playbackModeGreaterThan(
    PlaybackMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playbackMode',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> playbackModeLessThan(
    PlaybackMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playbackMode',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> playbackModeBetween(
    PlaybackMode lower,
    PlaybackMode upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playbackMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> playlistIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playlistId',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> playlistIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playlistId',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> playlistIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playlistId',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> playlistIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playlistId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> repeatDaysElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeatDays',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition>
      repeatDaysElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'repeatDays',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> repeatDaysElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'repeatDays',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> repeatDaysElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'repeatDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> repeatDaysLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDays',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> repeatDaysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDays',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> repeatDaysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDays',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> repeatDaysLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDays',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> repeatDaysLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDays',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> repeatDaysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDays',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> snoozeMinutesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'snoozeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> snoozeMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'snoozeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> snoozeMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'snoozeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> snoozeMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'snoozeMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> vibrateEnabledEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vibrateEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> volumeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'volume',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> volumeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'volume',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> volumeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'volume',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterFilterCondition> volumeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'volume',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension AlarmQueryObject on QueryBuilder<Alarm, Alarm, QFilterCondition> {}

extension AlarmQueryLinks on QueryBuilder<Alarm, Alarm, QFilterCondition> {}

extension AlarmQuerySortBy on QueryBuilder<Alarm, Alarm, QSortBy> {
  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByAscendingVolume() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ascendingVolume', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByAscendingVolumeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ascendingVolume', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByAutoStop() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoStop', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByAutoStopDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoStop', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByAutoStopAfterMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoStopAfterMinutes', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByAutoStopAfterMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoStopAfterMinutes', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByDefaultSound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultSound', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByDefaultSoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultSound', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hour', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hour', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minute', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minute', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByNextTrigger() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextTrigger', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByNextTriggerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextTrigger', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByPlayOnce() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playOnce', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByPlayOnceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playOnce', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByPlaybackMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playbackMode', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByPlaybackModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playbackMode', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByPlaylistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playlistId', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByPlaylistIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playlistId', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortBySnoozeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snoozeMinutes', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortBySnoozeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snoozeMinutes', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByVibrateEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibrateEnabled', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByVibrateEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibrateEnabled', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByVolume() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volume', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> sortByVolumeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volume', Sort.desc);
    });
  }
}

extension AlarmQuerySortThenBy on QueryBuilder<Alarm, Alarm, QSortThenBy> {
  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByAscendingVolume() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ascendingVolume', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByAscendingVolumeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ascendingVolume', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByAutoStop() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoStop', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByAutoStopDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoStop', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByAutoStopAfterMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoStopAfterMinutes', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByAutoStopAfterMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoStopAfterMinutes', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByDefaultSound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultSound', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByDefaultSoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultSound', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hour', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hour', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minute', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minute', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByNextTrigger() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextTrigger', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByNextTriggerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextTrigger', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByPlayOnce() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playOnce', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByPlayOnceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playOnce', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByPlaybackMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playbackMode', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByPlaybackModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playbackMode', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByPlaylistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playlistId', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByPlaylistIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playlistId', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenBySnoozeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snoozeMinutes', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenBySnoozeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snoozeMinutes', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByVibrateEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibrateEnabled', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByVibrateEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibrateEnabled', Sort.desc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByVolume() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volume', Sort.asc);
    });
  }

  QueryBuilder<Alarm, Alarm, QAfterSortBy> thenByVolumeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volume', Sort.desc);
    });
  }
}

extension AlarmQueryWhereDistinct on QueryBuilder<Alarm, Alarm, QDistinct> {
  QueryBuilder<Alarm, Alarm, QDistinct> distinctByAscendingVolume() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ascendingVolume');
    });
  }

  QueryBuilder<Alarm, Alarm, QDistinct> distinctByAutoStop() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'autoStop');
    });
  }

  QueryBuilder<Alarm, Alarm, QDistinct> distinctByAutoStopAfterMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'autoStopAfterMinutes');
    });
  }

  QueryBuilder<Alarm, Alarm, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Alarm, Alarm, QDistinct> distinctByDefaultSound(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'defaultSound', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Alarm, Alarm, QDistinct> distinctByHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hour');
    });
  }

  QueryBuilder<Alarm, Alarm, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<Alarm, Alarm, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'label', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Alarm, Alarm, QDistinct> distinctByMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minute');
    });
  }

  QueryBuilder<Alarm, Alarm, QDistinct> distinctByNextTrigger() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextTrigger');
    });
  }

  QueryBuilder<Alarm, Alarm, QDistinct> distinctByPlayOnce() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playOnce');
    });
  }

  QueryBuilder<Alarm, Alarm, QDistinct> distinctByPlaybackMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playbackMode');
    });
  }

  QueryBuilder<Alarm, Alarm, QDistinct> distinctByPlaylistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playlistId');
    });
  }

  QueryBuilder<Alarm, Alarm, QDistinct> distinctByRepeatDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repeatDays');
    });
  }

  QueryBuilder<Alarm, Alarm, QDistinct> distinctBySnoozeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'snoozeMinutes');
    });
  }

  QueryBuilder<Alarm, Alarm, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<Alarm, Alarm, QDistinct> distinctByVibrateEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vibrateEnabled');
    });
  }

  QueryBuilder<Alarm, Alarm, QDistinct> distinctByVolume() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'volume');
    });
  }
}

extension AlarmQueryProperty on QueryBuilder<Alarm, Alarm, QQueryProperty> {
  QueryBuilder<Alarm, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Alarm, bool, QQueryOperations> ascendingVolumeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ascendingVolume');
    });
  }

  QueryBuilder<Alarm, bool, QQueryOperations> autoStopProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'autoStop');
    });
  }

  QueryBuilder<Alarm, int, QQueryOperations> autoStopAfterMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'autoStopAfterMinutes');
    });
  }

  QueryBuilder<Alarm, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Alarm, String?, QQueryOperations> defaultSoundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultSound');
    });
  }

  QueryBuilder<Alarm, int, QQueryOperations> hourProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hour');
    });
  }

  QueryBuilder<Alarm, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<Alarm, String?, QQueryOperations> labelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'label');
    });
  }

  QueryBuilder<Alarm, int, QQueryOperations> minuteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minute');
    });
  }

  QueryBuilder<Alarm, DateTime?, QQueryOperations> nextTriggerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextTrigger');
    });
  }

  QueryBuilder<Alarm, bool, QQueryOperations> playOnceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playOnce');
    });
  }

  QueryBuilder<Alarm, PlaybackMode, QQueryOperations> playbackModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playbackMode');
    });
  }

  QueryBuilder<Alarm, int, QQueryOperations> playlistIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playlistId');
    });
  }

  QueryBuilder<Alarm, List<int>, QQueryOperations> repeatDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repeatDays');
    });
  }

  QueryBuilder<Alarm, int, QQueryOperations> snoozeMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'snoozeMinutes');
    });
  }

  QueryBuilder<Alarm, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<Alarm, bool, QQueryOperations> vibrateEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vibrateEnabled');
    });
  }

  QueryBuilder<Alarm, double, QQueryOperations> volumeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'volume');
    });
  }
}
