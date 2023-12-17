abstract class Env {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'evento-qo6d.onrender.com',
  );
}
