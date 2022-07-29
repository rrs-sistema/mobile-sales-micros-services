import 'package:http/http.dart';

import '../../../infra/http/http.dart';
import '../../../data/http/http.dart';

HttpClient makeHttpAdapter<ResponseType>() => HttpAdapter<ResponseType>(Client());