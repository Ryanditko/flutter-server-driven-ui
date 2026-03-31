import 'package:flutter/material.dart';

/// Catches build-time errors in a subtree and renders a graceful fallback
/// instead of crashing the entire widget tree.
///
/// Usage in [ComponentParser]:
/// ```dart
/// return ErrorBoundary(
///   nodeType: node.type,
///   child: builtWidget,
/// );
/// ```
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final String nodeType;

  const ErrorBoundary({
    super.key,
    required this.child,
    required this.nodeType,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  Object? _error;

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return _ErrorFallback(nodeType: widget.nodeType, error: _error!);
    }

    return _ErrorCatcher(
      onError: (error) {
        if (mounted) setState(() => _error = error);
      },
      child: widget.child,
    );
  }
}

class _ErrorCatcher extends StatelessWidget {
  final Widget child;
  final void Function(Object error) onError;

  const _ErrorCatcher({required this.child, required this.onError});

  @override
  Widget build(BuildContext context) {
    Widget result;
    try {
      result = child;
    } catch (e) {
      onError(e);
      return const SizedBox.shrink();
    }
    return result;
  }
}

class _ErrorFallback extends StatelessWidget {
  final String nodeType;
  final Object error;

  const _ErrorFallback({required this.nodeType, required this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(8),
        color: Colors.red.shade50,
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade400, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Error rendering "$nodeType"',
                  style: TextStyle(
                    color: Colors.red.shade800,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  error.toString(),
                  style: TextStyle(color: Colors.red.shade600, fontSize: 11),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
