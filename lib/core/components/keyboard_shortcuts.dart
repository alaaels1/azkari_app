import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardShortcuts extends StatelessWidget {
  final Widget child;
  final VoidCallback? onNextPage;
  final VoidCallback? onPreviousPage;
  final VoidCallback? onCount;

  const KeyboardShortcuts({
    super.key,
    required this.child,
    this.onNextPage,
    this.onPreviousPage,
    this.onCount,
  });

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        // سهم شمال ← → الصفحة التالية
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () {
          onNextPage?.call();
        },

        const SingleActivator(LogicalKeyboardKey.arrowRight): () {
          onPreviousPage?.call();
        },

        const SingleActivator(LogicalKeyboardKey.add): () {
          onCount?.call();
        },
        const SingleActivator(LogicalKeyboardKey.numpadAdd): () {
          onCount?.call();
        },

        const SingleActivator(LogicalKeyboardKey.space): () {
          onCount?.call();
        },

        const SingleActivator(LogicalKeyboardKey.enter): () {
          onCount?.call();
        },
        const SingleActivator(LogicalKeyboardKey.numpadEnter): () {
          onCount?.call();
        },
      },
      child: Focus(autofocus: true, child: child),
    );
  }
}
