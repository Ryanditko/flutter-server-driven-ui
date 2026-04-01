import 'package:flutter/material.dart';

/// Catches build-time errors in a subtree and renders a graceful fallback
/// instead of crashing the entire widget tree.
///
/// Wraps the child build in a try/catch within its own [Builder] to
/// intercept synchronous exceptions during widget construction.
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
  void didUpdateWidget(ErrorBoundary oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child || oldWidget.nodeType != widget.nodeType) {
      _error = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return _ErrorFallback(nodeType: widget.nodeType, error: _error!);
    }

    try {
      return _SafeBuilder(
        builder: (_) => widget.child,
        onError: (error) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() => _error = error);
          });
        },
      );
    } catch (e) {
      return _ErrorFallback(nodeType: widget.nodeType, error: e);
    }
  }
}

class _SafeBuilder extends StatelessWidget {
  final Widget Function(BuildContext) builder;
  final void Function(Object error) onError;

  const _SafeBuilder({required this.builder, required this.onError});

  @override
  Widget build(BuildContext context) {
    try {
      return builder(context);
    } catch (e) {
      debugPrint('ErrorBoundary caught: $e');
      onError(e);
      return const SizedBox.shrink();
    }
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
