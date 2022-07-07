import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secure_pass/services/cloud/cloud_storage_constants.dart';
import 'package:flutter/foundation.dart';

@immutable
class CloudPassword {
  final String documentId;
  final String ownerUserId;
  final String text;
  const CloudPassword({
    required this.documentId,
    required this.ownerUserId,
    required this.text,
  });

  CloudPassword.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        text = snapshot.data()[textFieldName] as String;
}
