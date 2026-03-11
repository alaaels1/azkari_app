# Azkari App 📿

A professional, lightweight, and feature-rich Islamic Adhkar (remembrances) application specifically designed for **Windows Desktop**. It helps you maintain your daily spiritual routine with a seamless experience directly on your PC.

---

## 🌟 Features

### 📖 Adhkar Content
*   **Morning & Evening Azkar:** Access authentic adhkar with a clean, readable layout.
*   **Interactive Counter:** Built-in counter for each zekr with real-time progress tracking.
*   **Daily Stats:** Track your daily progress and completion history.

### 💻 Desktop Experience
*   **Always on Top (Pin):** Keep the app visible while working on other tasks.
*   **Launch at Startup:** Option to start the app automatically with Windows.
*   **Keyboard Shortcuts:**
    *   `Arrow Keys`: Navigate between different adhkar.
    *   `Space / Enter / +`: Increment the current zekr counter.
*   **Window Management:** Fully responsive design that respects Windows windowing standards.

### 🔔 Intelligent Notifications
*   **Time-Aware Reminders:** Notifications triggered at optimal times:
    *   **Morning:** 5:00 AM – 3:00 PM.
    *   **Evening:** 3:30 PM – 2:00 AM.
*   **Incomplete Progress Alerts:** Gentle reminders if you haven't finished your daily adhkar.

### 🎨 Personalization & Tools
*   **Dark & Light Mode:** Seamlessly switch between themes to suit your environment.
*   **Hijri Calendar:** Integrated Hijri date display with offset adjustments.
*   **Privacy Focused:** Full control over your data with an option to delete all local records.
*   **Contact & Feedback:** Direct channel to communicate with the developer.

---

## 📸 Screenshots

| Home Screen | Azkar View | Settings |
|:---:|:---:|:---:|
| ![Home](https://raw.githubusercontent.com/alaaels1/azkari_app/refs/heads/main/lib/assets/photos/Screenshot%202026-03-11%20115457.png) | ![Azkar](https://github.com/alaaels1/azkari_app/blob/main/lib/assets/photos/Screenshot%202026-03-11%20115514.png?raw=true) | ![Settings](https://github.com/alaaels1/azkari_app/blob/main/lib/assets/photos/SettingsScreen.png?raw=true) |

---

## 🛠 Tech Stack

*   **Framework:** [Flutter](https://flutter.dev) (Desktop)
*   **State Management:** [BLoC / Cubit](https://pub.dev/packages/flutter_bloc)
*   **Local Storage:** [Hive](https://pub.dev/packages/hive) (NoSQL, Fast & Lightweight)
*   **Notifications:** [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)
*   **Window Logic:** [window_manager](https://pub.dev/packages/window_manager) & [bitsdojo_window](https://pub.dev/packages/bitsdojo_window)
*   **Responsive UI:** [flutter_screenutil](https://pub.dev/packages/flutter_screenutil)

---

## 🚀 Installation

### For Users (Executable)
1.  Go to the **Releases** section.
2.  Download the latest `.msix` or `.zip` file for Windows.
3.  Install/Run the application.

### For Developers
1.  **Clone the repo:**
    ```bash
    git clone https://github.com/alaaels1/azkari_app.git
    ```
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Generate Hive adapters:**
    ```bash
    flutter pub run build_runner build
    ```
4.  **Run the app:**
    ```bash
    flutter run -d windows
    ```

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 📧 Contact

**Developer:** Alaa Ayman Elsaidy
**Email:** alaa.elsaidy.dev@gmail.com
**Official App Email:** azkariapp2026@gmail.com
