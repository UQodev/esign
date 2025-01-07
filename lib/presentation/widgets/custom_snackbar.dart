import 'package:flutter/material.dart';

enum SnackBarType {
  success,
  error,
  warning,
  info,
}

class CustomSnackbar {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required SnackBarType type,
  }) {
    final overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(builder: (context) {
      return _SnackbarOverlay(
          title: title,
          message: message,
          type: type,
          onClose: () {
            overlayEntry.remove();
          });
    });

    overlayState.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}

class _SnackbarOverlay extends StatefulWidget {
  final String title;
  final String message;
  final SnackBarType type;
  final VoidCallback onClose;

  const _SnackbarOverlay({
    Key? key,
    required this.title,
    required this.message,
    required this.type,
    required this.onClose,
  }) : super(key: key);

  @override
  State<_SnackbarOverlay> createState() => _SnackbarOverlayState();
}

class _SnackbarOverlayState extends State<_SnackbarOverlay>
    with SingleTickerProviderStateMixin {
  double opacity = 0.0;
  Offset slideOffset = const Offset(0, 1);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        opacity = 1.0;
        slideOffset = Offset.zero;
      });
    });
  }

  void _hideSnackbar() {
    setState(() {
      opacity = 0.0;
      slideOffset = const Offset(0, 1);
    });

    Future.delayed(const Duration(milliseconds: 1000), widget.onClose);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: opacity,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 500),
          offset: slideOffset,
          curve: Curves.easeOutBack,
          child: _buildSnackbar(),
        ),
      ),
    );
  }

  Widget _buildSnackbar() {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: _getColor(widget.type),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: _getColor(widget.type).first.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                _getIcon(widget.type),
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      widget.message,
                      style: TextStyle(
                        color: Colors.white.withOpacity(.7),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: _hideSnackbar,
              child: const SizedBox(
                width: 50,
                height: 50,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static List<Color> _getColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return [const Color(0xFF2ECC71), const Color(0xFFB6F245)];
      case SnackBarType.error:
        return [const Color(0xFFA93226), const Color(0xFFE74C3C)];
      case SnackBarType.warning:
        return [const Color(0xFFF39C12), const Color(0xFFFFCC5C)];
      case SnackBarType.info:
        return [const Color(0xFF3391CD), const Color(0xFFA2D5F2)];
    }
  }

  static IconData _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle;
      case SnackBarType.error:
        return Icons.error;
      case SnackBarType.warning:
        return Icons.warning;
      case SnackBarType.info:
        return Icons.info;
    }
  }
}
