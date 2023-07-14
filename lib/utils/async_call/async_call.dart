import 'dart:convert';
import 'dart:io';
import 'package:coffee_base_app/utils/async_call/async_call_debug_environment.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

typedef AsyncFile = (String name, File file);

///
/// AsyncCall
///

class AsyncCall {
  final AsyncCallDebugEnvironment? _testEnvironment;

  final Map<String, dynamic> _queries = {};
  final Map<String, dynamic> _headers = {};

  final List<AsyncFile> _files = [];

  final void Function(String?)? _logFunction;

  dynamic _body;
  dynamic _multipartBody;

  String? _host;
  String? _scheme = "https";

  Map<String, dynamic>? _mockedData;

  ///
  /// Constructor
  ///

  AsyncCall({
    AsyncCallDebugEnvironment? testEnvironment,
    void Function(String?)? logFunction,
  })  : _testEnvironment = testEnvironment,
        _logFunction = logFunction ?? debugPrint;

  ///
  /// Functions
  ///

  AsyncCall mock(String mock) {
    if (kDebugMode) {
      _mockedData = jsonDecode(mock);
    }
    return this;
  }

  AsyncCall mockMap(Map<String, dynamic> mock) {
    if (kDebugMode) {
      _mockedData = mock;
    }
    return this;
  }

  AsyncCall host(String hostStr) {
    _host = hostStr;
    return this;
  }

  AsyncCall query(String key, String? value) {
    if (value != null) {
      _queries[key] = value;
    }
    return this;
  }

  AsyncCall header(String key, String? value) {
    if (value != null) {
      _queries[key] = value;
    }
    return this;
  }

  AsyncCall body(dynamic body) {
    _body = body;
    return this;
  }

  AsyncCall file(String name, File file) {
    _files.add((name, file));
    return this;
  }

  AsyncCall multipartBody(dynamic body) {
    _multipartBody = body;
    return this;
  }

  AsyncCall setConnectionScheme(String scheme) {
    _scheme = scheme;
    return this;
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    return Future(
      () async {
        if (kDebugMode) {
          var queryString = _generateQuery();
          if (queryString.isNotEmpty) {
            _logFunction?.call("AsyncCall: GET $_host/$endpoint?$queryString");
          } else {
            _logFunction?.call("AsyncCall: GET $_host/$endpoint");
          }
          if (_headers.isNotEmpty) {
            _logFunction?.call("AsyncCall: Headers ${_headers.toString()}");
          }

          if (await _hasMockEnvironment() && _hasMockedEndpoint(endpoint)) {
            final responses = await _getMockedResponse(endpoint);
            _logFunction?.call("AsyncCall: Response ${responses.toString()}");
            return responses;
          }
        }

        try {
          return _validateResponse(
            await http.get(
              Uri(
                scheme: _scheme,
                host: _host,
                path: endpoint,
                query: _generateQuery(),
              ),
              headers: Map.from(_headers),
            ),
          );
        } catch (e) {
          return {
            "http_success": false,
            "body": {
              "message": e,
            }
          };
        }
      },
    );
  }

  Future<Map<String, dynamic>> post(String endpoint) async {
    return Future(() async {
      if (kDebugMode) {
        var queryString = _generateQuery();
        if (queryString.isNotEmpty) {
          _logFunction?.call("AsyncCall: POST $_host/$endpoint?$queryString");
        } else {
          _logFunction?.call("AsyncCall: POST $_host/$endpoint");
        }
        if (_headers.isNotEmpty) {
          _logFunction?.call("AsyncCall: Headers ${_headers.toString()}");
        }

        if (await _hasMockEnvironment() && _hasMockedEndpoint(endpoint)) {
          if (_body != null) _logFunction?.call("AsyncCall: body ${jsonEncode(_body)}");
          if (_multipartBody != null) _logFunction?.call("AsyncCall: multipart body ${jsonEncode(_multipartBody)}");

          final responses = await _getMockedResponse(endpoint);
          _logFunction?.call("AsyncCall: Response ${responses.toString()}");
          return responses;
        }
      }

      _processMultipartForm(endpoint);

      try {
        return _validateResponse(
          await http.post(
            Uri(
              scheme: _scheme,
              host: _host,
              path: endpoint,
              query: _generateQuery(),
            ),
            headers: Map.from(_headers),
            body: _body,
            encoding: Encoding.getByName("utf-8"),
          ),
        );
      } catch (e) {
        return {
          "http_success": false,
          "body": {
            "message": e,
          }
        };
      }
    });
  }

  Future<Map<String, dynamic>> put(String endpoint) async {
    return Future(() async {
      if (kDebugMode) {
        var queryString = _generateQuery();
        if (queryString.isNotEmpty) {
          _logFunction?.call("AsyncCall: PUT $_host/$endpoint?$queryString");
        } else {
          _logFunction?.call("AsyncCall: PUT $_host/$endpoint");
        }
        if (_headers.isNotEmpty) {
          _logFunction?.call("AsyncCall: Headers ${_headers.toString()}");
        }

        if (await _hasMockEnvironment() && _hasMockedEndpoint(endpoint)) {
          if (_body != null) _logFunction?.call("AsyncCall: body ${jsonEncode(_body)}");
          if (_multipartBody != null) _logFunction?.call("AsyncCall: multipart body ${jsonEncode(_multipartBody)}");

          final responses = await _getMockedResponse(endpoint);
          _logFunction?.call("AsyncCall: Response ${responses.toString()}");
          return responses;
        }
      }

      _processMultipartForm(endpoint);

      try {
        return _validateResponse(
          await http.put(
            Uri(
              scheme: _scheme,
              host: _host,
              path: endpoint,
              query: _generateQuery(),
            ),
            headers: Map.from(_headers),
            body: _multipartBody ?? _body,
            encoding: Encoding.getByName("utf-8"),
          ),
        );
      } catch (e) {
        return {
          "http_success": false,
          "body": {
            "message": e,
          }
        };
      }
    });
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    return Future(() async {
      if (kDebugMode) {
        var queryString = _generateQuery();
        if (queryString.isNotEmpty) {
          _logFunction?.call("AsyncCall: DELETE $_host/$endpoint?$queryString");
        } else {
          _logFunction?.call("AsyncCall: DELETE $_host/$endpoint");
        }
        if (_headers.isNotEmpty) {
          _logFunction?.call("AsyncCall: Headers ${_headers.toString()}");
        }

        if (await _hasMockEnvironment() && _hasMockedEndpoint(endpoint)) {
          if (_body != null) _logFunction?.call("AsyncCall: body ${jsonEncode(_body)}");
          if (_multipartBody != null) _logFunction?.call("AsyncCall: multipart body ${jsonEncode(_multipartBody)}");

          final responses = await _getMockedResponse(endpoint);
          _logFunction?.call("AsyncCall: Response ${responses.toString()}");
          return responses;
        }
      }

      _processMultipartForm(endpoint);

      try {
        return _validateResponse(
          await http.delete(
            Uri(
              scheme: _scheme,
              host: _host,
              path: endpoint,
              query: _generateQuery(),
            ),
            headers: Map.from(_headers),
            body: _multipartBody ?? _body,
            encoding: Encoding.getByName("utf-8"),
          ),
        );
      } catch (e) {
        return {
          "http_success": false,
          "body": {
            "message": e,
          }
        };
      }
    });
  }

  Future<bool> _hasMockEnvironment() async {
    return _mockedData != null || _testEnvironment != null;
  }

  bool _hasMockedEndpoint(String endpoint) {
    final containMockedData = _mockedData?.containsKey(endpoint) == true;
    final hasMockedEndpoint = _testEnvironment?.hasEndpoint(endpoint);
    return containMockedData || hasMockedEndpoint == true;
  }

  Future<Map<String, dynamic>> _getMockedResponse(endpoint) {
    return Future(() {
      return _mockedData?[endpoint] ?? _testEnvironment?.getEndpoint(endpoint) ?? {};
    });
  }

  Map<String, dynamic> _validateResponse(http.Response response) {
    var http.Response(:int statusCode, :String body) = response;
    return switch (statusCode) {
      HttpStatus.ok || HttpStatus.accepted => jsonDecode(body),
      _ => {
          "http_success": false,
          "body": {"message": body}
        },
    };
  }

  String _generateQuery() {
    String queryString = "";
    _queries.forEach((key, value) {
      queryString += "$key=$value";
    });
    return queryString;
  }

  void _processMultipartForm(String endpoint) {
    if (_multipartBody != null || _files.isNotEmpty) {
      final uri = Uri(
        scheme: _scheme,
        host: _host,
        path: endpoint,
        query: _generateQuery(),
      );

      final multipartRequest = http.MultipartRequest('POST', uri);
      _multipartBody.forEach((key, value) {
        multipartRequest.fields[key] = value;
      });

      for (var i = 0; i < _files.length; i++) {
        final file = _files[i];
        multipartRequest.files.add(http.MultipartFile.fromBytes(
          file.$1,
          file.$2.readAsBytesSync(),
        ));
      }
    }
  }
}
