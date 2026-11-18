/// Error de validación de reglas de negocio, con mensaje apto para el usuario.
class ValidationFailure implements Exception {
  const ValidationFailure(this.message);
  final String message;

  @override
  String toString() => 'ValidationFailure: $message';
}

class NotFoundFailure implements Exception {
  const NotFoundFailure(this.message);
  final String message;

  @override
  String toString() => 'NotFoundFailure: $message';
}
