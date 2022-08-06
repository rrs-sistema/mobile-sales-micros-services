import 'package:mocktail/mocktail.dart';

import 'package:delivery_micros_services/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient {

  When mockRequestCall() => when(() => request(
    url: any(named: 'url'), 
    method: any(named: 'method'), 
    body: any(named: 'body',),
    headers: any(named: 'headers',)
  ));

  void mockRequest(dynamic data) => this.mockRequestCall().thenAnswer((_) async => data);
  void mockRequestError(HttpError error) => this.mockRequestCall().thenThrow(error);
}
