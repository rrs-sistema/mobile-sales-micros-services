enum DomainError {
  unexpected,
  invalidCredential
}

extension DomainErrorExtension on DomainError {
  String get description {
    switch (this) {
      case DomainError.invalidCredential: 
        return 'Credenciais inválidas';
      default: 
        return '';
    }
  }
}