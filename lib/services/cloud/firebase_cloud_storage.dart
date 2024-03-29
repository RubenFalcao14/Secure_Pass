import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secure_pass/services/cloud/cloud_password.dart';
import 'package:secure_pass/services/cloud/cloud_storage_constants.dart';
import 'package:secure_pass/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final passwords = FirebaseFirestore.instance.collection('passwords');

  Future<void> deletePassword({required String documentId}) async {
    try {
      await passwords.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeletePasswordException();
    }
  }

  Future<void> updatePasswordTitle({
    required String documentId,
    required String title,
  }) async {
    try {
      await passwords.doc(documentId).update({titleFieldName: title});
    } catch (e) {
      throw CouldNotUpdatePasswordException();
    }
  }

  Future<void> updatePasswordEmail({
    required String documentId,
    required String email,
  }) async {
    try {
      await passwords.doc(documentId).update({emailFieldName: email});
    } catch (e) {
      throw CouldNotUpdatePasswordException();
    }
  }

  Future<void> updatePasswordUserpassword({
    required String documentId,
    required String userpassword,
  }) async {
    try {
      await passwords.doc(documentId).update({userpasswordFieldName: userpassword});
    } catch (e) {
      throw CouldNotUpdatePasswordException();
    }
  }

  Future<void> updatePasswordUrl({
    required String documentId,
    required String url,
  }) async {
    try {
      await passwords.doc(documentId).update({urlFieldName: url});
    } catch (e) {
      throw CouldNotUpdatePasswordException();
    }
  }
  

  Stream<Iterable<CloudPassword>> allPasswords({required String ownerUserId}) =>
      passwords.snapshots().map((event) => event.docs
          .map((doc) => CloudPassword.fromSnapshot(doc))
          .where((password) => password.ownerUserId == ownerUserId));

  Future<Iterable<CloudPassword>> getPasswords({required String ownerUserId}) async {
    try {
      return await passwords
          .where(
            ownerUserIdFieldName,
            isEqualTo: ownerUserId,
          )
          .get()
          .then(
            (value) => value.docs.map((doc) => CloudPassword.fromSnapshot(doc)),
          );
    } catch (e) {
      throw CouldNotGetAllPasswordsException();
    }
  }

  Future<CloudPassword> createNewPassword({required String ownerUserId}) async {
    final document = await passwords.add({
      ownerUserIdFieldName: ownerUserId,
      titleFieldName: '',
      emailFieldName: '',
      userpasswordFieldName: '',
      urlFieldName: '',
    });
    final fetchedPassword = await document.get();
    return CloudPassword(
      documentId: fetchedPassword.id,
      ownerUserId: ownerUserId,
      title: '',
      email: '',
      userpassword: '',
      url: '',
    );
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
