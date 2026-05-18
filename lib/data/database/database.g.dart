// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $RecipesTable extends Recipes with TableInfo<$RecipesTable, RecipeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'UNIQUE',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 5),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _ingredientsMeta = const VerificationMeta(
    'ingredients',
  );
  @override
  late final GeneratedColumn<String> ingredients = GeneratedColumn<String>(
    'ingredients',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<String> steps = GeneratedColumn<String>(
    'steps',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoriesJsonMeta = const VerificationMeta(
    'categoriesJson',
  );
  @override
  late final GeneratedColumn<String> categoriesJson = GeneratedColumn<String>(
    'categories_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsJsonMeta = const VerificationMeta(
    'tagsJson',
  );
  @override
  late final GeneratedColumn<String> tagsJson = GeneratedColumn<String>(
    'tags_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cuisineMeta = const VerificationMeta(
    'cuisine',
  );
  @override
  late final GeneratedColumn<String> cuisine = GeneratedColumn<String>(
    'cuisine',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _youtubeUrlMeta = const VerificationMeta(
    'youtubeUrl',
  );
  @override
  late final GeneratedColumn<String> youtubeUrl = GeneratedColumn<String>(
    'youtube_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSharedMeta = const VerificationMeta(
    'isShared',
  );
  @override
  late final GeneratedColumn<bool> isShared = GeneratedColumn<bool>(
    'is_shared',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_shared" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sharedWithGroupIdsJsonMeta =
      const VerificationMeta('sharedWithGroupIdsJson');
  @override
  late final GeneratedColumn<String> sharedWithGroupIdsJson =
      GeneratedColumn<String>(
        'shared_with_group_ids_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    language,
    createdAt,
    updatedAt,
    isDeleted,
    ingredients,
    steps,
    notes,
    categoriesJson,
    tagsJson,
    cuisine,
    youtubeUrl,
    ownerId,
    isShared,
    sharedWithGroupIdsJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('ingredients')) {
      context.handle(
        _ingredientsMeta,
        ingredients.isAcceptableOrUnknown(
          data['ingredients']!,
          _ingredientsMeta,
        ),
      );
    }
    if (data.containsKey('steps')) {
      context.handle(
        _stepsMeta,
        steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('categories_json')) {
      context.handle(
        _categoriesJsonMeta,
        categoriesJson.isAcceptableOrUnknown(
          data['categories_json']!,
          _categoriesJsonMeta,
        ),
      );
    }
    if (data.containsKey('tags_json')) {
      context.handle(
        _tagsJsonMeta,
        tagsJson.isAcceptableOrUnknown(data['tags_json']!, _tagsJsonMeta),
      );
    }
    if (data.containsKey('cuisine')) {
      context.handle(
        _cuisineMeta,
        cuisine.isAcceptableOrUnknown(data['cuisine']!, _cuisineMeta),
      );
    }
    if (data.containsKey('youtube_url')) {
      context.handle(
        _youtubeUrlMeta,
        youtubeUrl.isAcceptableOrUnknown(data['youtube_url']!, _youtubeUrlMeta),
      );
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    }
    if (data.containsKey('is_shared')) {
      context.handle(
        _isSharedMeta,
        isShared.isAcceptableOrUnknown(data['is_shared']!, _isSharedMeta),
      );
    }
    if (data.containsKey('shared_with_group_ids_json')) {
      context.handle(
        _sharedWithGroupIdsJsonMeta,
        sharedWithGroupIdsJson.isAcceptableOrUnknown(
          data['shared_with_group_ids_json']!,
          _sharedWithGroupIdsJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      ingredients: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredients'],
      ),
      steps: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}steps'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      categoriesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}categories_json'],
      ),
      tagsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags_json'],
      ),
      cuisine: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cuisine'],
      ),
      youtubeUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}youtube_url'],
      ),
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      ),
      isShared: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_shared'],
      )!,
      sharedWithGroupIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shared_with_group_ids_json'],
      ),
    );
  }

  @override
  $RecipesTable createAlias(String alias) {
    return $RecipesTable(attachedDatabase, alias);
  }
}

class RecipeData extends DataClass implements Insertable<RecipeData> {
  final String id;
  final String title;
  final String language;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;
  final String? ingredients;
  final String? steps;
  final String? notes;
  final String? categoriesJson;
  final String? tagsJson;
  final String? cuisine;
  final String? youtubeUrl;
  final String? ownerId;
  final bool isShared;
  final String? sharedWithGroupIdsJson;
  const RecipeData({
    required this.id,
    required this.title,
    required this.language,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    this.ingredients,
    this.steps,
    this.notes,
    this.categoriesJson,
    this.tagsJson,
    this.cuisine,
    this.youtubeUrl,
    this.ownerId,
    required this.isShared,
    this.sharedWithGroupIdsJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['language'] = Variable<String>(language);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    if (!nullToAbsent || ingredients != null) {
      map['ingredients'] = Variable<String>(ingredients);
    }
    if (!nullToAbsent || steps != null) {
      map['steps'] = Variable<String>(steps);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || categoriesJson != null) {
      map['categories_json'] = Variable<String>(categoriesJson);
    }
    if (!nullToAbsent || tagsJson != null) {
      map['tags_json'] = Variable<String>(tagsJson);
    }
    if (!nullToAbsent || cuisine != null) {
      map['cuisine'] = Variable<String>(cuisine);
    }
    if (!nullToAbsent || youtubeUrl != null) {
      map['youtube_url'] = Variable<String>(youtubeUrl);
    }
    if (!nullToAbsent || ownerId != null) {
      map['owner_id'] = Variable<String>(ownerId);
    }
    map['is_shared'] = Variable<bool>(isShared);
    if (!nullToAbsent || sharedWithGroupIdsJson != null) {
      map['shared_with_group_ids_json'] = Variable<String>(
        sharedWithGroupIdsJson,
      );
    }
    return map;
  }

  RecipesCompanion toCompanion(bool nullToAbsent) {
    return RecipesCompanion(
      id: Value(id),
      title: Value(title),
      language: Value(language),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      ingredients: ingredients == null && nullToAbsent
          ? const Value.absent()
          : Value(ingredients),
      steps: steps == null && nullToAbsent
          ? const Value.absent()
          : Value(steps),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      categoriesJson: categoriesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(categoriesJson),
      tagsJson: tagsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(tagsJson),
      cuisine: cuisine == null && nullToAbsent
          ? const Value.absent()
          : Value(cuisine),
      youtubeUrl: youtubeUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(youtubeUrl),
      ownerId: ownerId == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerId),
      isShared: Value(isShared),
      sharedWithGroupIdsJson: sharedWithGroupIdsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(sharedWithGroupIdsJson),
    );
  }

  factory RecipeData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      language: serializer.fromJson<String>(json['language']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      ingredients: serializer.fromJson<String?>(json['ingredients']),
      steps: serializer.fromJson<String?>(json['steps']),
      notes: serializer.fromJson<String?>(json['notes']),
      categoriesJson: serializer.fromJson<String?>(json['categoriesJson']),
      tagsJson: serializer.fromJson<String?>(json['tagsJson']),
      cuisine: serializer.fromJson<String?>(json['cuisine']),
      youtubeUrl: serializer.fromJson<String?>(json['youtubeUrl']),
      ownerId: serializer.fromJson<String?>(json['ownerId']),
      isShared: serializer.fromJson<bool>(json['isShared']),
      sharedWithGroupIdsJson: serializer.fromJson<String?>(
        json['sharedWithGroupIdsJson'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'language': serializer.toJson<String>(language),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'ingredients': serializer.toJson<String?>(ingredients),
      'steps': serializer.toJson<String?>(steps),
      'notes': serializer.toJson<String?>(notes),
      'categoriesJson': serializer.toJson<String?>(categoriesJson),
      'tagsJson': serializer.toJson<String?>(tagsJson),
      'cuisine': serializer.toJson<String?>(cuisine),
      'youtubeUrl': serializer.toJson<String?>(youtubeUrl),
      'ownerId': serializer.toJson<String?>(ownerId),
      'isShared': serializer.toJson<bool>(isShared),
      'sharedWithGroupIdsJson': serializer.toJson<String?>(
        sharedWithGroupIdsJson,
      ),
    };
  }

  RecipeData copyWith({
    String? id,
    String? title,
    String? language,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
    Value<String?> ingredients = const Value.absent(),
    Value<String?> steps = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> categoriesJson = const Value.absent(),
    Value<String?> tagsJson = const Value.absent(),
    Value<String?> cuisine = const Value.absent(),
    Value<String?> youtubeUrl = const Value.absent(),
    Value<String?> ownerId = const Value.absent(),
    bool? isShared,
    Value<String?> sharedWithGroupIdsJson = const Value.absent(),
  }) => RecipeData(
    id: id ?? this.id,
    title: title ?? this.title,
    language: language ?? this.language,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    ingredients: ingredients.present ? ingredients.value : this.ingredients,
    steps: steps.present ? steps.value : this.steps,
    notes: notes.present ? notes.value : this.notes,
    categoriesJson: categoriesJson.present
        ? categoriesJson.value
        : this.categoriesJson,
    tagsJson: tagsJson.present ? tagsJson.value : this.tagsJson,
    cuisine: cuisine.present ? cuisine.value : this.cuisine,
    youtubeUrl: youtubeUrl.present ? youtubeUrl.value : this.youtubeUrl,
    ownerId: ownerId.present ? ownerId.value : this.ownerId,
    isShared: isShared ?? this.isShared,
    sharedWithGroupIdsJson: sharedWithGroupIdsJson.present
        ? sharedWithGroupIdsJson.value
        : this.sharedWithGroupIdsJson,
  );
  RecipeData copyWithCompanion(RecipesCompanion data) {
    return RecipeData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      language: data.language.present ? data.language.value : this.language,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      ingredients: data.ingredients.present
          ? data.ingredients.value
          : this.ingredients,
      steps: data.steps.present ? data.steps.value : this.steps,
      notes: data.notes.present ? data.notes.value : this.notes,
      categoriesJson: data.categoriesJson.present
          ? data.categoriesJson.value
          : this.categoriesJson,
      tagsJson: data.tagsJson.present ? data.tagsJson.value : this.tagsJson,
      cuisine: data.cuisine.present ? data.cuisine.value : this.cuisine,
      youtubeUrl: data.youtubeUrl.present
          ? data.youtubeUrl.value
          : this.youtubeUrl,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      isShared: data.isShared.present ? data.isShared.value : this.isShared,
      sharedWithGroupIdsJson: data.sharedWithGroupIdsJson.present
          ? data.sharedWithGroupIdsJson.value
          : this.sharedWithGroupIdsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('language: $language, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('ingredients: $ingredients, ')
          ..write('steps: $steps, ')
          ..write('notes: $notes, ')
          ..write('categoriesJson: $categoriesJson, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('cuisine: $cuisine, ')
          ..write('youtubeUrl: $youtubeUrl, ')
          ..write('ownerId: $ownerId, ')
          ..write('isShared: $isShared, ')
          ..write('sharedWithGroupIdsJson: $sharedWithGroupIdsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    language,
    createdAt,
    updatedAt,
    isDeleted,
    ingredients,
    steps,
    notes,
    categoriesJson,
    tagsJson,
    cuisine,
    youtubeUrl,
    ownerId,
    isShared,
    sharedWithGroupIdsJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeData &&
          other.id == this.id &&
          other.title == this.title &&
          other.language == this.language &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.ingredients == this.ingredients &&
          other.steps == this.steps &&
          other.notes == this.notes &&
          other.categoriesJson == this.categoriesJson &&
          other.tagsJson == this.tagsJson &&
          other.cuisine == this.cuisine &&
          other.youtubeUrl == this.youtubeUrl &&
          other.ownerId == this.ownerId &&
          other.isShared == this.isShared &&
          other.sharedWithGroupIdsJson == this.sharedWithGroupIdsJson);
}

class RecipesCompanion extends UpdateCompanion<RecipeData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> language;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<String?> ingredients;
  final Value<String?> steps;
  final Value<String?> notes;
  final Value<String?> categoriesJson;
  final Value<String?> tagsJson;
  final Value<String?> cuisine;
  final Value<String?> youtubeUrl;
  final Value<String?> ownerId;
  final Value<bool> isShared;
  final Value<String?> sharedWithGroupIdsJson;
  final Value<int> rowid;
  const RecipesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.language = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.ingredients = const Value.absent(),
    this.steps = const Value.absent(),
    this.notes = const Value.absent(),
    this.categoriesJson = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.cuisine = const Value.absent(),
    this.youtubeUrl = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.isShared = const Value.absent(),
    this.sharedWithGroupIdsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecipesCompanion.insert({
    required String id,
    required String title,
    required String language,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.ingredients = const Value.absent(),
    this.steps = const Value.absent(),
    this.notes = const Value.absent(),
    this.categoriesJson = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.cuisine = const Value.absent(),
    this.youtubeUrl = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.isShared = const Value.absent(),
    this.sharedWithGroupIdsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       language = Value(language);
  static Insertable<RecipeData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? language,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<String>? ingredients,
    Expression<String>? steps,
    Expression<String>? notes,
    Expression<String>? categoriesJson,
    Expression<String>? tagsJson,
    Expression<String>? cuisine,
    Expression<String>? youtubeUrl,
    Expression<String>? ownerId,
    Expression<bool>? isShared,
    Expression<String>? sharedWithGroupIdsJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (language != null) 'language': language,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (ingredients != null) 'ingredients': ingredients,
      if (steps != null) 'steps': steps,
      if (notes != null) 'notes': notes,
      if (categoriesJson != null) 'categories_json': categoriesJson,
      if (tagsJson != null) 'tags_json': tagsJson,
      if (cuisine != null) 'cuisine': cuisine,
      if (youtubeUrl != null) 'youtube_url': youtubeUrl,
      if (ownerId != null) 'owner_id': ownerId,
      if (isShared != null) 'is_shared': isShared,
      if (sharedWithGroupIdsJson != null)
        'shared_with_group_ids_json': sharedWithGroupIdsJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecipesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? language,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<String?>? ingredients,
    Value<String?>? steps,
    Value<String?>? notes,
    Value<String?>? categoriesJson,
    Value<String?>? tagsJson,
    Value<String?>? cuisine,
    Value<String?>? youtubeUrl,
    Value<String?>? ownerId,
    Value<bool>? isShared,
    Value<String?>? sharedWithGroupIdsJson,
    Value<int>? rowid,
  }) {
    return RecipesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      notes: notes ?? this.notes,
      categoriesJson: categoriesJson ?? this.categoriesJson,
      tagsJson: tagsJson ?? this.tagsJson,
      cuisine: cuisine ?? this.cuisine,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      ownerId: ownerId ?? this.ownerId,
      isShared: isShared ?? this.isShared,
      sharedWithGroupIdsJson:
          sharedWithGroupIdsJson ?? this.sharedWithGroupIdsJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (ingredients.present) {
      map['ingredients'] = Variable<String>(ingredients.value);
    }
    if (steps.present) {
      map['steps'] = Variable<String>(steps.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (categoriesJson.present) {
      map['categories_json'] = Variable<String>(categoriesJson.value);
    }
    if (tagsJson.present) {
      map['tags_json'] = Variable<String>(tagsJson.value);
    }
    if (cuisine.present) {
      map['cuisine'] = Variable<String>(cuisine.value);
    }
    if (youtubeUrl.present) {
      map['youtube_url'] = Variable<String>(youtubeUrl.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (isShared.present) {
      map['is_shared'] = Variable<bool>(isShared.value);
    }
    if (sharedWithGroupIdsJson.present) {
      map['shared_with_group_ids_json'] = Variable<String>(
        sharedWithGroupIdsJson.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('language: $language, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('ingredients: $ingredients, ')
          ..write('steps: $steps, ')
          ..write('notes: $notes, ')
          ..write('categoriesJson: $categoriesJson, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('cuisine: $cuisine, ')
          ..write('youtubeUrl: $youtubeUrl, ')
          ..write('ownerId: $ownerId, ')
          ..write('isShared: $isShared, ')
          ..write('sharedWithGroupIdsJson: $sharedWithGroupIdsJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RecipesTable recipes = $RecipesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [recipes];
}

typedef $$RecipesTableCreateCompanionBuilder =
    RecipesCompanion Function({
      required String id,
      required String title,
      required String language,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<String?> ingredients,
      Value<String?> steps,
      Value<String?> notes,
      Value<String?> categoriesJson,
      Value<String?> tagsJson,
      Value<String?> cuisine,
      Value<String?> youtubeUrl,
      Value<String?> ownerId,
      Value<bool> isShared,
      Value<String?> sharedWithGroupIdsJson,
      Value<int> rowid,
    });
typedef $$RecipesTableUpdateCompanionBuilder =
    RecipesCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> language,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<String?> ingredients,
      Value<String?> steps,
      Value<String?> notes,
      Value<String?> categoriesJson,
      Value<String?> tagsJson,
      Value<String?> cuisine,
      Value<String?> youtubeUrl,
      Value<String?> ownerId,
      Value<bool> isShared,
      Value<String?> sharedWithGroupIdsJson,
      Value<int> rowid,
    });

class $$RecipesTableFilterComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoriesJson => $composableBuilder(
    column: $table.categoriesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagsJson => $composableBuilder(
    column: $table.tagsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cuisine => $composableBuilder(
    column: $table.cuisine,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get youtubeUrl => $composableBuilder(
    column: $table.youtubeUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isShared => $composableBuilder(
    column: $table.isShared,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sharedWithGroupIdsJson => $composableBuilder(
    column: $table.sharedWithGroupIdsJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecipesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoriesJson => $composableBuilder(
    column: $table.categoriesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagsJson => $composableBuilder(
    column: $table.tagsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cuisine => $composableBuilder(
    column: $table.cuisine,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get youtubeUrl => $composableBuilder(
    column: $table.youtubeUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isShared => $composableBuilder(
    column: $table.isShared,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sharedWithGroupIdsJson => $composableBuilder(
    column: $table.sharedWithGroupIdsJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => column,
  );

  GeneratedColumn<String> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get categoriesJson => $composableBuilder(
    column: $table.categoriesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tagsJson =>
      $composableBuilder(column: $table.tagsJson, builder: (column) => column);

  GeneratedColumn<String> get cuisine =>
      $composableBuilder(column: $table.cuisine, builder: (column) => column);

  GeneratedColumn<String> get youtubeUrl => $composableBuilder(
    column: $table.youtubeUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<bool> get isShared =>
      $composableBuilder(column: $table.isShared, builder: (column) => column);

  GeneratedColumn<String> get sharedWithGroupIdsJson => $composableBuilder(
    column: $table.sharedWithGroupIdsJson,
    builder: (column) => column,
  );
}

class $$RecipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipesTable,
          RecipeData,
          $$RecipesTableFilterComposer,
          $$RecipesTableOrderingComposer,
          $$RecipesTableAnnotationComposer,
          $$RecipesTableCreateCompanionBuilder,
          $$RecipesTableUpdateCompanionBuilder,
          (
            RecipeData,
            BaseReferences<_$AppDatabase, $RecipesTable, RecipeData>,
          ),
          RecipeData,
          PrefetchHooks Function()
        > {
  $$RecipesTableTableManager(_$AppDatabase db, $RecipesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String?> ingredients = const Value.absent(),
                Value<String?> steps = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> categoriesJson = const Value.absent(),
                Value<String?> tagsJson = const Value.absent(),
                Value<String?> cuisine = const Value.absent(),
                Value<String?> youtubeUrl = const Value.absent(),
                Value<String?> ownerId = const Value.absent(),
                Value<bool> isShared = const Value.absent(),
                Value<String?> sharedWithGroupIdsJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecipesCompanion(
                id: id,
                title: title,
                language: language,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                ingredients: ingredients,
                steps: steps,
                notes: notes,
                categoriesJson: categoriesJson,
                tagsJson: tagsJson,
                cuisine: cuisine,
                youtubeUrl: youtubeUrl,
                ownerId: ownerId,
                isShared: isShared,
                sharedWithGroupIdsJson: sharedWithGroupIdsJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String language,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String?> ingredients = const Value.absent(),
                Value<String?> steps = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> categoriesJson = const Value.absent(),
                Value<String?> tagsJson = const Value.absent(),
                Value<String?> cuisine = const Value.absent(),
                Value<String?> youtubeUrl = const Value.absent(),
                Value<String?> ownerId = const Value.absent(),
                Value<bool> isShared = const Value.absent(),
                Value<String?> sharedWithGroupIdsJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecipesCompanion.insert(
                id: id,
                title: title,
                language: language,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                ingredients: ingredients,
                steps: steps,
                notes: notes,
                categoriesJson: categoriesJson,
                tagsJson: tagsJson,
                cuisine: cuisine,
                youtubeUrl: youtubeUrl,
                ownerId: ownerId,
                isShared: isShared,
                sharedWithGroupIdsJson: sharedWithGroupIdsJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipesTable,
      RecipeData,
      $$RecipesTableFilterComposer,
      $$RecipesTableOrderingComposer,
      $$RecipesTableAnnotationComposer,
      $$RecipesTableCreateCompanionBuilder,
      $$RecipesTableUpdateCompanionBuilder,
      (RecipeData, BaseReferences<_$AppDatabase, $RecipesTable, RecipeData>),
      RecipeData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RecipesTableTableManager get recipes =>
      $$RecipesTableTableManager(_db, _db.recipes);
}
