# Design System Quick Reference

## 🎨 File Structure

```
lib/
├── themes/
│   └── app_theme.dart          # Complete design system
└── screens/                     # All screens with new design
    ├── login_screen.dart
    ├── signup_screen.dart
    ├── student_home_screen.dart
    ├── teacher_home_screen.dart
    ├── qr_generator_screen.dart
    ├── qr_scanner_screen.dart
    ├── attendance_history_screen.dart
    └── teacher_attendance_screen.dart
```

---

## 🎯 Using the Theme System

### In Any Screen:
```dart
import 'package:attendance_app/themes/app_theme.dart';

// Use colors
color: AppColors.primary
color: AppColors.secondary
color: AppColors.danger

// Use text styles
style: AppTextStyles.heading
style: AppTextStyles.body
style: AppTextStyles.caption

// Use decorations
decoration: AppDecorations.textFieldDecoration('Label')
decoration: AppDecorations.cardDecoration()
```

---

## 🎨 Color Palette

```dart
AppColors.primary        // #2563EB (Blue)
AppColors.secondary      // #10B981 (Green)
AppColors.accent         // #8B5CF6 (Purple)
AppColors.warning        // #F59E0B (Amber)
AppColors.danger         // #EF4444 (Red)
AppColors.surface        // #F9FAFB (Light Gray)
AppColors.border         // #E5E7EB (Border Gray)
AppColors.text           // #1F2937 (Dark Text)
AppColors.textLight      // #6B7280 (Light Text)
```

---

## 📝 Typography

```dart
AppTextStyles.heading           // 28px, Bold, -0.5 spacing
AppTextStyles.subheading        // 20px, Semi-bold
AppTextStyles.bodyLarge         // 16px, Medium
AppTextStyles.body              // 14px, Regular
AppTextStyles.caption           // 12px, Regular, Gray
```

---

## 🎁 Reusable Components

### Text Fields
```dart
TextField(
  decoration: AppDecorations.textFieldDecoration('Label'),
)
```

### Cards
```dart
Container(
  decoration: AppDecorations.cardDecoration(),
  padding: const EdgeInsets.all(16),
  child: // content
)
```

### Buttons (Global Theme)
```dart
ElevatedButton(
  onPressed: () {},
  child: const Text('Action'),
)
// Automatically styled!
```

---

## 🌈 Gradient Usage

### Page Background
```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.primary.withOpacity(0.05),
        AppColors.secondary.withOpacity(0.05),
      ],
    ),
  ),
)
```

### Header
```dart
Container(
  decoration: BoxDecoration(
    gradient: const LinearGradient(
      colors: [AppColors.primary, AppColors.accent],
    ),
  ),
)
```

---

## 📐 Spacing System

```
8px   - Minimal spacing (icons, small gaps)
12px  - Small spacing (list item gaps)
16px  - Medium spacing (card padding, sections)
24px  - Large spacing (screen margins, main sections)
32px  - Extra large spacing (major section breaks)
```

---

## ✨ Shadow Usage

### Card Shadow
```dart
boxShadow: [
  BoxShadow(
    color: Colors.black.withOpacity(0.04),
    blurRadius: 8,
    offset: const Offset(0, 2),
  ),
]
```

### Highlight Shadow
```dart
boxShadow: [
  BoxShadow(
    color: AppColors.primary.withOpacity(0.3),
    blurRadius: 12,
    offset: const Offset(0, 4),
  ),
]
```

---

## 🔄 Border Radius Guide

```
8px    - Small components (icons, small buttons)
12px   - Medium components (input fields, small cards)
16px   - Large components (main cards)
20px   - Extra large (modals, major containers)
24px   - Largest (rounded corners on sections)
```

---

## 💡 Design Tips

1. **Colors**: Always use `AppColors.*` constants
2. **Typography**: Use `AppTextStyles.*` for consistency
3. **Cards**: Use `AppDecorations.cardDecoration()` for consistency
4. **Spacing**: Stick to 8px multiples
5. **Shadows**: Use subtle, not bold shadows
6. **Icons**: Always pair with text labels
7. **Gradients**: Keep it subtle (under 0.2 opacity for backgrounds)
8. **Buttons**: Full-width on mobile, constrained on larger screens

---

## 🎬 Animation Guidelines

✅ Use smooth expansions (ExpansionTile)
✅ Use modals instead of snackbars for important feedback
✅ Dialog auto-dismisses after 2 seconds
✅ Keep animations under 300ms for responsiveness

---

## 🚀 Performance Checklist

✅ No heavy animations
✅ Gradients use `withOpacity()` efficiently
✅ Shadows are minimal
✅ Text styles are const
✅ Colors are const
✅ Builds are optimized

---

## 📱 Responsive Behavior

All screens are designed to work on:
- Small phones (360px)
- Medium phones (412px)
- Large phones (720px+)
- Tablets (800px+)

Padding adjusts automatically through `EdgeInsets`.

---

## 🎨 Adding New Screens

When creating a new screen, follow this template:

```dart
import 'package:flutter/material.dart';
import 'package:attendance_app/themes/app_theme.dart';

class MyNewScreen extends StatefulWidget {
  const MyNewScreen({super.key});

  @override
  State<MyNewScreen> createState() => _MyNewScreenState();
}

class _MyNewScreenState extends State<MyNewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title', style: TextStyle(
          color: AppColors.text,
          fontWeight: FontWeight.w600,
        )),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withOpacity(0.05),
              AppColors.secondary.withOpacity(0.05),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: // Your content
        ),
      ),
    );
  }
}
```

---

**Everything is ready! The design is cohesive, professional, and maintainable!** ✨
