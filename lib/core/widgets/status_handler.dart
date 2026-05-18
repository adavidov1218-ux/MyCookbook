import 'package:flutter/material.dart';

class StatusHandler extends StatelessWidget {
  final bool isLoading;
  final bool isEmpty;
  final String? error;
  final Widget child;
  final String emptyMessage;

  const StatusHandler({
    super.key,
    required this.isLoading,
    required this.isEmpty,
    required this.child,
    this.error,
    this.emptyMessage = 'Ничего не найдено',
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (error != null) return Center(child: Text('Ошибка: $error'));
    if (isEmpty) return Center(child: Text(emptyMessage));
    return child;
  }
}
