# 🛒 Shop Online

A modern e-commerce mobile application built with Flutter and Firebase.

## ✨ Features

- **Authentication** - Login/Register with Email, Google & Facebook
- **Product Browsing** - Browse products by categories with carousel
- **Shopping Cart** - Add/remove items and manage quantities
- **Favorites** - Save your favorite products
- **Checkout** - Complete purchase with payment methods
- **User Profile** - Manage account and addresses
- **Real-time Updates** - Firebase Firestore integration

## 🛠️ Technologies

- **Flutter** - Cross-platform mobile framework
- **Firebase** - Authentication, Firestore database
- **BLoC/Cubit** - State management
- **Persistent Bottom Nav Bar** - Navigation
- **Cached Network Image** - Image caching

## 📋 Prerequisites

- Flutter SDK (3.6.0 or higher)
- Firebase project configured
- Android Studio / VS Code
- Google Services JSON files

## 🚀 Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/lbarsidati22/shop_online.git
   cd shop_online
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Add your `google-services.json` to `android/app/`
   - Add your `GoogleService-Info.plist` to `ios/Runner/`

4. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Project Structure

```
lib/
├── models/          # Data models
├── services/        # API & Firebase services
├── view_models/     # BLoC/Cubit state management
├── views/           # UI pages & widgets
└── utils/           # Routes, colors, constants
```

## 📦 Dependencies

- `flutter_bloc` - State management
- `firebase_core` & `firebase_auth` - Authentication
- `cloud_firestore` - Database
- `google_sign_in` & `flutter_facebook_auth` - Social login
- `persistent_bottom_nav_bar` - Navigation
- `flutter_carousel_widget` - Carousel slider
- `cached_network_image` - Image optimization

## 📄 License

This project is for educational purposes.

---

Made with ❤️ using Flutter
