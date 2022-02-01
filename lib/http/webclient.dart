import 'package:bytebank/http/interceptors/logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';


class WebClient {
  Uri baseUrl(String route) => Uri.parse('http://192.168.2.12:8080/$route');

  final Client client = InterceptedClient.build(interceptors: [
    LoggingInterceptor(),
  ]);


}
