// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audiotrack_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAudioTrackCollection on Isar {
  IsarCollection<AudioTrack> get audioTracks => this.collection();
}

const AudioTrackSchema = CollectionSchema(
  name: r'AudioTrack',
  id: -931389713124530459,
  properties: {
    r'path': PropertySchema(
      id: 0,
      name: r'path',
      type: IsarType.string,
    ),
    r'playListId': PropertySchema(
      id: 1,
      name: r'playListId',
      type: IsarType.long,
    ),
    r'sourceType': PropertySchema(
      id: 2,
      name: r'sourceType',
      type: IsarType.byte,
      enumMap: _AudioTracksourceTypeEnumValueMap,
    )
  },
  estimateSize: _audioTrackEstimateSize,
  serialize: _audioTrackSerialize,
  deserialize: _audioTrackDeserialize,
  deserializeProp: _audioTrackDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _audioTrackGetId,
  getLinks: _audioTrackGetLinks,
  attach: _audioTrackAttach,
  version: '3.1.0+1',
);

int _audioTrackEstimateSize(
  AudioTrack object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.path.length * 3;
  return bytesCount;
}

void _audioTrackSerialize(
  AudioTrack object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.path);
  writer.writeLong(offsets[1], object.playListId);
  writer.writeByte(offsets[2], object.sourceType.index);
}

AudioTrack _audioTrackDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AudioTrack();
  object.id = id;
  object.path = reader.readString(offsets[0]);
  object.playListId = reader.readLong(offsets[1]);
  object.sourceType =
      _AudioTracksourceTypeValueEnumMap[reader.readByteOrNull(offsets[2])] ??
          AudioSourceType.assets;
  return object;
}

P _audioTrackDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (_AudioTracksourceTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          AudioSourceType.assets) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AudioTracksourceTypeEnumValueMap = {
  'assets': 0,
  'file': 1,
  'url': 2,
};
const _AudioTracksourceTypeValueEnumMap = {
  0: AudioSourceType.assets,
  1: AudioSourceType.file,
  2: AudioSourceType.url,
};

Id _audioTrackGetId(AudioTrack object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _audioTrackGetLinks(AudioTrack object) {
  return [];
}

void _audioTrackAttach(IsarCollection<dynamic> col, Id id, AudioTrack object) {
  object.id = id;
}

extension AudioTrackQueryWhereSort
    on QueryBuilder<AudioTrack, AudioTrack, QWhere> {
  QueryBuilder<AudioTrack, AudioTrack, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AudioTrackQueryWhere
    on QueryBuilder<AudioTrack, AudioTrack, QWhereClause> {
  QueryBuilder<AudioTrack, AudioTrack, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<AudioTrack, AudioTrack, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterWhereClause> idBetween(
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

extension AudioTrackQueryFilter
    on QueryBuilder<AudioTrack, AudioTrack, QFilterCondition> {
  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> idGreaterThan(
    Id value, {
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

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> idLessThan(
    Id value, {
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

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
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

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> pathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> pathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> pathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> pathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'path',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> pathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> pathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> pathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> pathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'path',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> pathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> pathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> playListIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playListId',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      playListIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playListId',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      playListIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playListId',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> playListIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playListId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> sourceTypeEqualTo(
      AudioSourceType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceType',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      sourceTypeGreaterThan(
    AudioSourceType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sourceType',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      sourceTypeLessThan(
    AudioSourceType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sourceType',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> sourceTypeBetween(
    AudioSourceType lower,
    AudioSourceType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sourceType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AudioTrackQueryObject
    on QueryBuilder<AudioTrack, AudioTrack, QFilterCondition> {}

extension AudioTrackQueryLinks
    on QueryBuilder<AudioTrack, AudioTrack, QFilterCondition> {}

extension AudioTrackQuerySortBy
    on QueryBuilder<AudioTrack, AudioTrack, QSortBy> {
  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> sortByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> sortByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> sortByPlayListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListId', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> sortByPlayListIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListId', Sort.desc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> sortBySourceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceType', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> sortBySourceTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceType', Sort.desc);
    });
  }
}

extension AudioTrackQuerySortThenBy
    on QueryBuilder<AudioTrack, AudioTrack, QSortThenBy> {
  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenByPlayListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListId', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenByPlayListIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListId', Sort.desc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenBySourceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceType', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenBySourceTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceType', Sort.desc);
    });
  }
}

extension AudioTrackQueryWhereDistinct
    on QueryBuilder<AudioTrack, AudioTrack, QDistinct> {
  QueryBuilder<AudioTrack, AudioTrack, QDistinct> distinctByPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'path', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QDistinct> distinctByPlayListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playListId');
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QDistinct> distinctBySourceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceType');
    });
  }
}

extension AudioTrackQueryProperty
    on QueryBuilder<AudioTrack, AudioTrack, QQueryProperty> {
  QueryBuilder<AudioTrack, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AudioTrack, String, QQueryOperations> pathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'path');
    });
  }

  QueryBuilder<AudioTrack, int, QQueryOperations> playListIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playListId');
    });
  }

  QueryBuilder<AudioTrack, AudioSourceType, QQueryOperations>
      sourceTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceType');
    });
  }
}
