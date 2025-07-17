# 📌 Tech Spec: Quran App

## 1.  Project Overview
      - **Project Name:** Quran App  
      - **Description:**  
             A simple digital Al-Qur'an application that displays a list of surahs, full ayat content, and supporting features such as audio playback and loading animations. Built with Flutter using the lightweight and efficient GetX architecture.
      - **API Endpoint:** [https://open-api.my.id/quran](https://open-api.my.id/quran)  
      - **Target Platform:** Android, iOS  
      - **Programming Language:** Dart  
      - **Framework:** Flutter 3.27.4 
      - **State Management:** GetX  
      - **Flutter Version Management:** FVM (Flutter Version Management)

## 2. 🔑 Main Features
      - Displays a list of 114 surahs, including surah number, Arabic name, and total number of verses.  
      - View detailed surah content with Arabic text, translation, and transliteration.  
      - Navigate easily between surahs (previous and next).  
      - Play surah audio using the `just_audio` audio player.  
      - Shows skeleton loading animations while data is being fetched.

## 3. 📦 Dependencies
      | Package | Version | Description |
      |--------|---------|-------------|
      | **[GetX](https://pub.dev/packages/get)** | `^4.7.2` | Lightweight and efficient solution for state management, routing, and dependency injection. |
      | **[flutter_dotenv](https://pub.dev/packages/flutter_dotenv)** | `^5.2.1` | Manages environment variables from a `.env` file for API keys, URLs, and other configurations. |
      | **[dio](https://pub.dev/packages/dio)** | `^5.8.0` | A powerful and flexible HTTP client for making API requests. |
      | **[skeletonizer](https://pub.dev/packages/skeletonizer)** | `^1.4.3` | Provides a shimmer-style loading animation before main content is displayed. |
      | **[flutter_svg](https://pub.dev/packages/flutter_svg)** | `^2.0.17` | Renders SVG images and icons within Flutter widgets. |
      | **[audioplayers](https://pub.dev/packages/audioplayers)** | `^6.4.0` | Plays audio with controls such as play, pause, and seek. |
      | **[just_audio](https://pub.dev/packages/just_audio)** | `^0.10.4` | An alternative audio player with advanced control and stable streaming. |
      | **[flutter_html](https://pub.dev/packages/flutter_html)** | `^3.0.0` | Renders HTML content into Flutter UI components. |

## 4. 🧱 Project Structure & Design Pattern

This project follows a modular and layered architecture inspired by Clean Architecture principles, organized using GetX for state management and dependency injection.

### 5.📁 Folder Structure Overview
lib/
├── component/ # Reusable global components (widgets, configs, utils)
│ ├── base/ # Base classes or abstract structures
│ ├── config/ # App configuration (theme, route, constants)
│ ├── ext/ # Extensions and helper functions
│ ├── model/ # Global data models
│ ├── translation/ # Localization files
│ ├── util/ # Utilities and helpers
│ └── widget/ # Shared UI widgets
│
├── features/ # Feature-based module separation
│ └── home/ # Example: Home feature
│ ├── binding/ # GetX bindings for dependency injection
│ ├── model/ # Feature-specific data models
│ ├── presentation/ # UI, controllers, and state
│ └── repository/ # Data source and repository pattern

### 6 🧩 Design Pattern Principles

      - **Separation of Concerns**: Divides logic into independent layers (UI, logic, data).
      - **Feature-Based Modules**: Each feature has its own folder for scalability and maintainability.
      - **GetX**:
      - `Controller` handles state and logic.
      - `Binding` handles dependency injection.
      - `State` holds observable variables.
      - **Repository Pattern**: Manages data access (API, local DB) through a centralized abstraction.
      - **Reusable Components**: Configs, widgets, and utilities placed under `component/`.

This pattern ensures **code maintainability**, **testability**, and **modular development**.