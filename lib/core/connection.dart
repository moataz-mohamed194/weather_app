abstract class Connection {
  Connection._();

  static const base = 'api.weatherapi.com';
  static const baseWithHTTP = 'https://$base/';
  static const baseURL = '${baseWithHTTP}v1/';
}
