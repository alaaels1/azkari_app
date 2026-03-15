<div align="center">

<img src="https://raw.githubusercontent.com/alaaels1/azkari_app/refs/heads/main/assets/photos/Logo.png" width="120" alt="Azkari Logo"/>

# أذكاري — Azkari App 📿

![Stars](https://img.shields.io/github/stars/alaaels1/azkari_app?style=for-the-badge&logo=github&color=6A5ACD)
![License](https://img.shields.io/github/license/alaaels1/azkari_app?style=for-the-badge&color=FF8C00)
![Flutter](https://img.shields.io/badge/Flutter-Desktop-42A5F5?style=for-the-badge&logo=flutter)
![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux-708090?style=for-the-badge)


*أقدم هذا العمل صدقةً جاريةً لوجه الله، ولا تنسوني من دعائكم.* 🤲

**A professional, lightweight Islamic Azkar desktop application for Windows & Linux**

[![Download Windows](https://img.shields.io/badge/Download-Windows%20.exe-0078D6?style=for-the-badge&logo=windows)](https://github.com/alaaels1/azkari_app/releases/download/v1.0.0/azkari_app.exe)
[![Download Windows (No Warning)](https://img.shields.io/badge/Download-Windows%20(Signed)-28A745?style=for-the-badge&logo=windows)](https://github.com/alaaels1/azkari_app/releases/download/v1.0.0/azkari_app_warning_free.exe)
[![Download DEB](https://img.shields.io/badge/Download-Linux%20.deb-E95420?style=for-the-badge&logo=ubuntu)](https://github.com/alaaels1/azkari_app/releases/download/v1.0.0/AzkariApp.deb)
[![Download AppImage](https://img.shields.io/badge/Download-Linux%20.AppImage-FCC624?style=for-the-badge&logo=linux&logoColor=black)](https://github.com/alaaels1/azkari_app/releases/download/v1.0.0/AzkariApp.AppImage)


</div>

---

## 📖 About

Azkari helps you maintain your daily spiritual routine with a seamless desktop experience. Built with Flutter, it offers authentic morning and evening adhkar with smart reminders, progress tracking, and a distraction-free interface — right on your PC.

---
## 🎬 Demo Video

[![Watch the Demo](https://img.youtube.com/vi/P5W359WkOT0/maxresdefault.jpg)](https://youtu.be/P5W359WkOT0)


## 📸 Screenshots

| Home Screen | Morning Azkar | Evening Azkar |
|:---:|:---:|:---:|
| ![Home](https://raw.githubusercontent.com/alaaels1/azkari_app/refs/heads/main/assets/photos/home.png) | ![Morning](https://raw.githubusercontent.com/alaaels1/azkari_app/refs/heads/main/assets/photos/azkar_sabah.png) | ![Evening](https://raw.githubusercontent.com/alaaels1/azkari_app/refs/heads/main/assets/photos/azkar_masaa.png) |

| Completion Screen | Progress Tracker | Settings |
|:---:|:---:|:---:|
| ![Completion](https://raw.githubusercontent.com/alaaels1/azkari_app/refs/heads/main/assets/photos/compelation_dialog.png) | ![Progress](https://raw.githubusercontent.com/alaaels1/azkari_app/refs/heads/main/assets/photos/progress.png) | ![Settings](https://raw.githubusercontent.com/alaaels1/azkari_app/refs/heads/main/assets/photos/settings.png) |

---

## 🌟 Features

### 📖 Azkar Content
- **Morning & Evening Azkar** — Authentic adhkar with a clean, readable layout
- **Interactive Counter** — Built-in counter with real-time progress tracking
- **Completion Screen** — Beautiful celebration screen when you finish all adhkar
- **Daily Stats** — Track your daily progress and completion history

### 💻 Desktop Experience
- **Always on Top (Pin)** — Keep the app visible while working on other tasks
- **Launch at Startup** — Start automatically with Windows
- **Keyboard Shortcuts:**
  - `Arrow Keys` — Navigate between adhkar
  - `Space / Enter / +` — Increment the counter
- **Fully Responsive** — Respects Windows & Linux windowing standards

### 🔔 Intelligent Notifications
- **Morning Reminders** — 5:00 AM to 3:00 PM
- **Evening Reminders** — 3:30 PM to 2:00 AM
- **Incomplete Progress Alerts** — Gentle nudge if you haven't finished

### 🎨 Personalization & Tools
- **Dark & Light Mode** — Switch themes to suit your environment
- **Hijri Calendar** — Integrated Hijri date with offset adjustments
- **Progress Tracker** — Visual history of your daily completion
- **Privacy Focused** — Full control with option to delete all local data
- **Contact & Feedback** — Direct channel to reach the developer

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| Framework | [Flutter](https://flutter.dev) Desktop |
| State Management | [BLoC / Cubit](https://pub.dev/packages/flutter_bloc) |
| Local Storage | [Hive](https://pub.dev/packages/hive) |
| Notifications | [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) |
| Window Management | [window_manager](https://pub.dev/packages/window_manager) |
| Responsive UI | [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) |

---

## 🚀 Installation

### For Users

#### 🪟 Windows
1. Download the `.exe` file below.
2. Double-click to run — no installation needed.

> [![Download for Windows](https://img.shields.io/badge/Download-Windows%20.exe-0078D6?style=for-the-badge&logo=windows)](https://github.com/alaaels1/azkari_app/releases/download/v1.0.0/azkari_app.exe)

#### 🐧 Linux (Debian/Ubuntu)
1. Download the `.deb` file below.
2. Run:
```bash
cd ~/Downloads
sudo dpkg -i AzkariApp.deb
azkari_app
```
> [![Download Deb](https://img.shields.io/badge/Download-Linux%20.deb-orange?style=for-the-badge&logo=ubuntu&logoColor=white)](https://github.com/alaaels1/azkari_app/releases/download/v1.0.0/AzkariApp.deb)

#### 🐧 Linux (AppImage)
1. Download the `.AppImage` file below.
2. Run:
```bash
cd ~/Downloads
chmod +x AzkariApp.AppImage
./AzkariApp.AppImage --appimage-extract-and-run
```
> [![Download AppImage](https://img.shields.io/badge/Download-Linux%20.AppImage-FCC624?style=for-the-badge&logo=linux&logoColor=black)](https://github.com/alaaels1/azkari_app/releases/download/v1.0.0/AzkariApp.AppImage)

---

### For Developers
```bash
# Clone the repo
git clone https://github.com/alaaels1/azkari_app.git

# Install dependencies
flutter pub get

# Generate Hive adapters
flutter pub run build_runner build

# Run on Windows
flutter run -d windows

# Run on Linux
flutter run -d linux
```

## 📚 Data Source & Credits

The adhkar content used in this application is partially adapted from the following open-source repository:

🔗 https://github.com/AbdelrahmanBayoumi/morning-evening-adhkar

Full credit goes to the original author **Abdelrahman Bayoumi** for collecting and organizing the adhkar data.

Note: The data has been modified and adapted to fit the structure and features of this application.

---
---

## 📜 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---


## 👩‍💻 Developer

<div align="center">

**Alaa Ayman Elsaidy**

📧 **Email:** alaa.elsaidy.dev@gmail.com  
📩 **App Support:** azkariapp2026@gmail.com  

</div>
