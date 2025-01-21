import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';
import 'package:test/test.dart';

import 'utils/test_request_samples.dart';
import 'utils/test_response_samples.dart';

void main() {
  group('network log tests', () {
    group('TRACE', () {
      test('start', () {
        final log = NetworkLogTrace.start();

        expect(
          log.type,
          'TRACE',
          reason: 'log type should be TRACE',
        );

        expect(
          log.message,
          contains('START'),
          reason: 'log message should contain START label',
        );

        expect(
          log.message,
          contains('main'),
          reason: 'log message should contain caller function name',
        );
      });

      test('end', () {
        final log = NetworkLogTrace.end();

        expect(
          log.type,
          'TRACE',
          reason: 'log type should be TRACE',
        );

        expect(
          log.message,
          contains('END'),
          reason: 'log message should contain END label',
        );

        expect(
          log.message,
          contains('main'),
          reason: 'log message should contain caller function name',
        );
      });

      test('unspecified', () {
        final log = NetworkLogTrace.unspecified();

        expect(
          log.type,
          'TRACE',
          reason: 'log type should be TRACE',
        );

        expect(
          log.message,
          contains('TRACE'),
          reason: 'log message should contain TRACE label',
        );

        expect(
          log.message,
          contains('main'),
          reason: 'log message should contain caller function name',
        );
      });
    });

    group('RES_S', () {
      test('test 1', () {
        final log = NetworkLogSuccessResponse(
          statusCode: 200,
          data: const ResponseTest1(field1: 'value1'),
        );

        expect(
          log.type,
          'RES_S',
          reason: 'log type should be RES_S',
        );

        expect(
          log.message,
          contains('Response Succeeded'),
          reason: 'log message should contain response data',
        );

        expect(
          log.message,
          contains('200'),
          reason: 'log message should contain response data',
        );

        expect(
          log.message,
          contains('field1'),
          reason: 'log message should contain response data',
        );

        expect(
          log.message,
          contains('value1'),
          reason: 'log message should contain response data',
        );
      });
    });

    group('RES_E', () {
      test('test 1', () {
        final log = NetworkLogErrorResponse(
          error: NetworkErrorResponse(
            statusCode: 400,
            message: 'Bad Request',
            stackTrace: StackTrace.current,
          ),
        );

        expect(
          log.type,
          'RES_E',
          reason: 'log type should be RES_E',
        );

        expect(
          log.message,
          contains('Response Failed'),
          reason: 'log message should contain response data',
        );

        expect(
          log.message,
          contains('400'),
          reason: 'log message should contain response data',
        );

        expect(
          log.message,
          contains('Bad Request'),
          reason: 'log message should contain response data',
        );
      });
    });

    group('REQ', () {
      test('test 1', () {
        final log = NetworkLogRequest(
          request: RequestTest1(field1: 'value1'),
        );

        expect(
          log.type,
          'REQ',
          reason: 'log type should be REQ',
        );

        expect(
          log.message,
          contains('Request'),
          reason: 'log message should contain request label',
        );

        expect(
          log.message,
          contains('field1'),
          reason: 'log message should contain request payload',
        );

        expect(
          log.message,
          contains('value1'),
          reason: 'log message should contain request payload',
        );

        expect(
          log.message,
          contains('GET'),
          reason: 'log message should contain request method',
        );

        expect(
          log.message,
          contains('basic_test'),
          reason: 'log message should contain request queue',
        );
      });
    });

    group('INIT', () {
      test('test 1: no additional message', () {
        const baseUrl = 'https://example.com';

        final log = NetworkLogInit(baseUrl: baseUrl);

        expect(
          log.type,
          'INIT',
          reason: 'log type should be INIT',
        );

        expect(
          log.message,
          contains(baseUrl),
          reason: 'log message should contain base url',
        );

        expect(
          log.message,
          isNot(contains('null')),
          reason: 'log message should not contain something null',
        );
      });

      test('test 2: with additional message', () {
        const baseUrl = 'https://example.com';
        const additionalMessage = 'sample additional message';

        final log = NetworkLogInit(
          baseUrl: baseUrl,
          additionalMessage: additionalMessage,
        );

        expect(
          log.type,
          'INIT',
          reason: 'log type should be INIT',
        );

        expect(
          log.message,
          contains(baseUrl),
          reason: 'log message should contain base url',
        );

        expect(
          log.message,
          contains(additionalMessage),
          reason: 'log message should contain additional message',
        );
      });
    });

    group('ERROR', () {
      test('test 1', () {
        final error = NetworkErrorResponse(
          statusCode: 500,
          message: 'Internal error message',
          stackTrace: StackTrace.current,
        );

        final log = NetworkLogInternalError(error: error);

        expect(
          log.type,
          'ERROR',
          reason: 'log type should be ERROR',
        );

        expect(
          log.message,
          contains(error.toString()),
          reason: 'log message should contain error message',
        );
      });
    });

    group('CUSTOM', () {
      test('test 1', () {
        const type = 'CUSTOM';
        const message = 'Custom log message';
        final log = NetworkLogCustom(type: type, message: message);

        expect(
          log.type,
          type,
          reason: 'log type should be $type',
        );

        expect(
          log.message,
          contains(message),
          reason: 'log message should contain custom message',
        );
      });
    });
  });
}
