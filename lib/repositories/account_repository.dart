import 'dart:convert' show jsonEncode, jsonDecode;

import 'package:json_annotation/json_annotation.dart';
import 'package:twake/models/account_field.dart';
import 'package:twake/models/language_field.dart';
import 'package:twake/models/password_field.dart';
// import 'package:twake/models/base_channel.dart';
// import 'package:twake/models/company.dart';
// import 'package:twake/models/workspace.dart';
import 'package:twake/services/service_bundle.dart';

part 'account_repository.g.dart';

const _ACCOUNT_STORE_KEY = 'account';

@JsonSerializable(explicitToJson: true)
class AccountRepository extends JsonSerializable {
  @JsonKey(required: true, name: 'username')
  AccountField userName;
  @JsonKey(required: true, name: 'firstname')
  AccountField firstName;
  @JsonKey(required: true, name: 'lastname')
  AccountField lastName;
  @JsonKey(required: false)
  LanguageField language;
  @JsonKey(required: false)
  AccountField picture;
  @JsonKey(required: false)
  PasswordField password;

  AccountRepository({
    this.userName,
    this.firstName,
    this.lastName,
    this.language,
    this.picture,
    this.password,
  });

  @JsonKey(ignore: true)
  static final _logger = Logger();
  @JsonKey(ignore: true)
  static final _api = Api();
  @JsonKey(ignore: true)
  static final _storage = Storage();

  // Pseudo constructor for loading profile from storage or api
  static Future<AccountRepository> load() async {
    // _logger.w("Loading account:");
    var accountMap = await _storage.load(
      type: StorageType.Account,
      key: _ACCOUNT_STORE_KEY,
    );
    if (accountMap == null) {
      // _logger.d('No account in storage, requesting from api...');
      accountMap = await _api.get(Endpoint.account);
      // _logger.d('RECEIVED ACCOUNT: $accountMap');
    } else {
      accountMap = jsonDecode(accountMap[_storage.settingsField]);
      // _logger.d('RETRIEVED ACCOUNT: $accountMap');
    }
    // Get repository instance
    final account = AccountRepository.fromJson(accountMap);
    // Save it to store
    // if (loadedFromNetwork) account.save();
    // return it
    return account;
  }

  Future<void> reload() async {
    final profileMap = await _api.get(Endpoint.account);
    _update(profileMap);
  }

  Future<void> clean() async {
    await _storage.delete(
      type: StorageType.Account,
      key: _ACCOUNT_STORE_KEY,
    );
  }

  Future<void> save() async {
    await _storage.store(
      item: {
        'id': _ACCOUNT_STORE_KEY,
        _storage.settingsField: jsonEncode(this.toJson())
      },
      type: StorageType.Account,
    );
  }

  void _update(Map<String, dynamic> json) {
    firstName.value = json['firstname'] as String;
    lastName.value = json['lastname'] as String;
    picture.value = json['picture'] as String;
  }

  Future<AccountRepository> patch({
    String newFirstName,
    String newLastName,
    String newLanguage,
    String oldPassword,
    String newPassword,
  }) async {
    final Map<String, dynamic> accountMap = <String, dynamic>{};
    if (newFirstName != null) {
      firstName.value = newFirstName;
      accountMap['firstname'] = newFirstName;
    }
    if (newLastName != null) {
      lastName.value = newLastName;
      accountMap['lastname'] = newLastName;
    }
    final result = await _api.patch(Endpoint.account, body: toJson());
    if (result != null) {
      print('Account updated: $accountMap');
      save();
    }
    return this;
  }

  /// Convenience methods to avoid deserializing this class from JSON
  /// https://flutter.dev/docs/development/data-and-backend/json#code-generation
  factory AccountRepository.fromJson(Map<String, dynamic> json) {
    // json = Map.from(json);
    // if (json['notification_rooms'] is String) {
    // json['notification_rooms'] = jsonDecode(json['notification_rooms']);
    // }
    return _$AccountRepositoryFromJson(json);
  }

  /// Convenience methods to avoid serializing this class to JSON
  /// https://flutter.dev/docs/development/data-and-backend/json#code-generation
  Map<String, dynamic> toJson() {
    var map = _$AccountRepositoryToJson(this);
    // map['notification_rooms'] = jsonEncode(map['notification_rooms']);
    return map;
  }
}
