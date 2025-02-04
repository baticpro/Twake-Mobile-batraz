// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_summary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageSummaryAdapter extends TypeAdapter<MessageSummary> {
  @override
  final int typeId = 15;

  @override
  MessageSummary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageSummary(
      date: fields[0] as int,
      sender: fields[1] == null ? '0' : fields[1] as String,
      senderName: fields[2] == null ? 'Guest' : fields[2] as String,
      title: fields[3] as String,
      text: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MessageSummary obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.sender)
      ..writeByte(2)
      ..write(obj.senderName)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageSummaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageSummary _$MessageSummaryFromJson(Map<String, dynamic> json) {
  return MessageSummary(
    date: json['date'] as int,
    sender: json['sender'] as String? ?? '0',
    senderName: json['sender_name'] as String? ?? 'Guest',
    title: json['title'] as String,
    text: json['text'] as String?,
  );
}

Map<String, dynamic> _$MessageSummaryToJson(MessageSummary instance) =>
    <String, dynamic>{
      'date': instance.date,
      'sender': instance.sender,
      'sender_name': instance.senderName,
      'title': instance.title,
      'text': instance.text,
    };
