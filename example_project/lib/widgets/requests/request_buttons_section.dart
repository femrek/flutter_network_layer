import 'dart:io';

import 'package:dart_network_layer_dio/dart_network_layer_dio.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart' hide Widget;
import 'package:path_provider/path_provider.dart';
import 'package:remote_logging/remote_logging.dart';

part '_bulk_buttons.dart';
part '_complex_buttons.dart';
part '_crud_buttons.dart';

/// Section displaying request buttons in three horizontal-scrolling rows,
/// grouped by API category: CRUDs, Bulks, and Complexes.
class RequestButtonsSection extends StatelessWidget {
  /// Creates an instance of [RequestButtonsSection] with the given [invoker].
  const RequestButtonsSection({required this.invoker, super.key});

  /// The network invoker used to make API requests when buttons are pressed.
  final DioNetworkInvoker invoker;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow(
            context,
            label: 'Basic CRUD Operations',
            icon: Icons.table_chart,
            color: Colors.indigo,
            child: _CrudButtons(invoker: invoker),
          ),
          const SizedBox(height: 4),
          _buildRow(
            context,
            label: 'Bulks',
            icon: Icons.cloud_upload,
            color: Colors.teal,
            child: _BulkButtons(invoker: invoker),
          ),
          const SizedBox(height: 4),
          _buildRow(
            context,
            label: 'Complexes',
            icon: Icons.account_tree,
            color: Colors.deepOrange,
            child: _ComplexButtons(invoker: invoker),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 64,
          child: child,
        ),
      ],
    );
  }
}

class _RequestButton extends StatelessWidget {
  const _RequestButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ActionChip(
        avatar: Icon(icon, size: 18),
        label: Text(label),
        onPressed: onPressed,
      ),
    );
  }
}

void _logNetworkResult<T extends Schema>(
  Logger log,
  String actionName,
  NetworkResult<T> result, {
  Object? Function(T data)? successFormatter,
}) {
  switch (result) {
    case SuccessResponseResult<T>():
      final formattedData = successFormatter != null
          ? successFormatter(result.data)
          : result.data.runtimeType;
      log.info('$actionName successful: $formattedData');
    case SpecifiedResponseResult<T>():
      log.severe(
        '$actionName failed with response: ${result.data.runtimeType}',
      );
    case NetworkErrorResult<T>(:final error):
      final lowerAction = actionName.toLowerCase();
      if (error is NetworkErrorInvalidResponseType) {
        log.severe(
          'Invalid response type during $lowerAction: '
          '<${error.statusCode}> ${error.response.runtimeType}',
        );
      }
      log.severe(
        'Network error during $lowerAction: ${result.error}',
        result.error,
        result.error.stackTrace,
      );
  }
}
