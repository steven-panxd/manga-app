class ApiException implements FormatException {
  final String message;

  ApiException({this.message});

  @override
  int get offset => null;

  @override
  get source => null;

}