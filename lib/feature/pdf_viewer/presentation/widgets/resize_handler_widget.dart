// ميثود مساعدة داخل الكلاس
import 'package:flutter/material.dart';

Widget buildResizeHandle({
  required Alignment alignment,
  required Function(DragUpdateDetails) onDrag,
}) {
  // حجم المقبض
  const double handleSize = 14.0;

  return Align(
    alignment: alignment,

    // نستخدم Transform.translate لوضع المقبض "خارج" حدود الصورة
    // ليكون نصفه بالداخل ونصفه بالخارج ليسهل مسكه
    child: Transform.translate(
      offset: Offset(
        // تحريك أفقي بناءً على الموقع
        (alignment.x == -1)
            ? -handleSize / 2
            : (alignment.x == 1)
                ? handleSize / 2
                : 0,
        // تحريك عمودي بناءً على الموقع
        (alignment.y == -1)
            ? -handleSize / 2
            : (alignment.y == 1)
                ? handleSize / 2
                : 0,
      ),
      child: GestureDetector(
        onPanUpdate: onDrag,

        // تغيير شكل مؤشر الماوس (مهم جداً للويب)
        child: MouseRegion(
          cursor: getCursorForAlignment(alignment), // يعيد شكل سهم التكبير
          child: Container(
            width: handleSize,
            height: handleSize,
            decoration: BoxDecoration(
              color: Colors.teal,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
          ),
        ),
      ),
    ),
  );
}

// ميثود مساعدة لتغيير شكل الماوس
MouseCursor getCursorForAlignment(Alignment alignment) {
  if (alignment == Alignment.topLeft || alignment == Alignment.bottomRight) {
    return SystemMouseCursors.resizeUpLeftDownRight;
  }
  if (alignment == Alignment.topRight || alignment == Alignment.bottomLeft) {
    return SystemMouseCursors.resizeUpRightDownLeft;
  }
  if (alignment == Alignment.centerLeft || alignment == Alignment.centerRight) {
    return SystemMouseCursors.resizeLeftRight;
  }
  if (alignment == Alignment.topCenter || alignment == Alignment.bottomCenter) {
    return SystemMouseCursors.resizeUpDown;
  }
  return SystemMouseCursors.basic;
}
