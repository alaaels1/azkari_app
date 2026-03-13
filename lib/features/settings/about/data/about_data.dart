import 'package:flutter/material.dart';

import '../../../../core/components/models/info_model.dart';

const String githubUrl = "https://github.com/alaaels1/azkari_app";

const List<InfoSection> aboutSections = [
  InfoSection(
    icon: Icons.menu_book_outlined,
    title: "عن التطبيق",
    content:
    "أذكاري هو تطبيق بسيط يساعدك على المداومة على أذكار الصباح والمساء "
        "أثناء العمل على الحاسوب، مع تصميم هادئ يركز على وضوح القراءة "
        "وسهولة الوصول للأذكار.",
  ),
  InfoSection(
    icon: Icons.star_border,
    title: "مميزات التطبيق",
    content:
    "• قراءة أذكار الصباح والمساء بخط واضح وسهل.\n"
        "• تثبيت الأذكار فوق النوافذ أثناء العمل.\n"
        "• تتبع التزامك اليومي بقراءة الأذكار عبر التقويم.\n"
        "• تعديل التاريخ الهجري عند الحاجة.\n"
        "• التنقل بين الأذكار بسهولة باستخدام أزرار اليمين واليسار.\n"
        "• التسبيح بسهولة باستخدام اختصارات لوحة المفاتيح : Space، Enter، +.",
  ),

  InfoSection(
    icon: Icons.code,
    title: "كود التطبيق",
    content: "يمكنك الاطلاع على الكود الكامل للتطبيق عبر GitHub.",
  ),
];