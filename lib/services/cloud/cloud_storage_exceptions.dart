class CloudStorageException implements Exception {
  const CloudStorageException();
}

// C in CRUD
class CouldNotCreatePasswordException extends CloudStorageException {}

// R in CRUD
class CouldNotGetAllPasswordsException extends CloudStorageException {}

// U in CRUD
class CouldNotUpdatePasswordException extends CloudStorageException {}

// D in CRUD
class CouldNotDeletePasswordException extends CloudStorageException {}
