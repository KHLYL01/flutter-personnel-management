import 'package:flutter/material.dart';

class ErrorWidgetWithRetry extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onRetry;

  const ErrorWidgetWithRetry({
    super.key,
    required this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: theme.colorScheme.error,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Oops!',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            if (onRetry != null)
              TextButton(
                onPressed: onRetry,
                child: const Text(
                  'Retry',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
