import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secure_pass/services/cloud/cloud_storage_constants.dart';
import 'package:flutter/foundation.dart';

@immutable
class CloudPassword {
  final String documentId;
  final String ownerUserId;
  final String title;
  final String email;
  final String userpassword;
  final String url;
  const CloudPassword({
    required this.documentId,
    required this.ownerUserId,
    required this.title,
    required this.email,
    required this.userpassword,
    required this.url,
  });

  CloudPassword.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        title = snapshot.data()[titleFieldName] as String,
        email = snapshot.data()[emailFieldName] as String,
        userpassword = snapshot.data()[userpasswordFieldName] as String,
        url = snapshot.data()[urlFieldName] as String;
        
}
