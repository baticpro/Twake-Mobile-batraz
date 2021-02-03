// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_workspace_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddWorkspaceRepository _$AddWorkspaceRepositoryFromJson(
    Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['company_id', 'workspace_id', 'name']);
  return AddWorkspaceRepository(
    json['name'] as String,
    companyId: json['company_id'] as String,
    workspaceId: json['workspace_id'] as String,
    members: (json['members'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$AddWorkspaceRepositoryToJson(
        AddWorkspaceRepository instance) =>
    <String, dynamic>{
      'company_id': instance.companyId,
      'workspace_id': instance.workspaceId,
      'name': instance.name,
      'members': instance.members,
    };
