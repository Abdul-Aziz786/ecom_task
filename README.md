# ECommerce Pro - High Traffic E-Commerce Application

A scalable, high-performance e-commerce application built with Flutter and GetX state management.

## 🚀 Features

- **State Management**: GetX for reactive state management
- **Clean Architecture**: Separation of concerns with layers (Data, Domain, Presentation)
- **Networking**: Dio for API calls with interceptors
- **Local Storage**: SharedPreferences & Hive for caching
- **Authentication**: JWT-based authentication with auto-refresh
- **Performance**: Optimized for high traffic with caching strategies
- **UI/UX**: Material Design 3 with custom theming
- **Validation**: Comprehensive form validation
- **Error Handling**: Centralized error handling with user-friendly messages

## 📁 Project Structure

```
lib/
├── core/                           # Core functionality
│   ├── constants/                  # App-wide constants
│   │   ├── app_constants.dart     # App configuration
│   │   └── api_endpoints.dart     # API endpoint definitions
│   ├── network/                    # Network layer
│   │   ├── api_client.dart        # Dio API client
│   │   └── interceptors/          # Request/Response interceptors
│   ├── theme/                      # App theming
│   │   ├── app_colors.dart        # Color palette
│   │   └── app_theme.dart         # Theme configuration
│   └── utils/                      # Utility classes
│       ├── storage_service.dart   # Local storage service
│       ├── snackbar_service.dart  # Snackbar utilities
│       └── validators.dart        # Form validators
├── data/                           # Data layer
│   ├── models/                     # Data models
│   │   ├── user_model.dart
│   │   ├── product_model.dart
│   │   ├── category_model.dart
│   │   ├── cart_model.dart
│   │   └── order_model.dart
│   └── repositories/               # Data repositories
│       ├── auth_repository.dart
│       ├── product_repository.dart
│       └── cart_repository.dart
├── presentation/                   # Presentation layer
│   ├── bindings/                   # GetX bindings
│   ├── controllers/                # GetX controllers
│   ├── pages/                      # UI pages
│   └── widgets/                    # Reusable widgets
├── routes/                         # App routing
└── main.dart                       # App entry point
```

## 🔧 Setup Instructions

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code

### Installation

1. **Install dependencies**

   ```bash
   flutter pub get
   ```

2. **Configure API endpoints**

   - Update `lib/core/constants/app_constants.dart` with your API base URL
   - Update payment gateway keys

3. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Key Dependencies

- **get**: State management and navigation
- **dio**: HTTP client for API calls
- **shared_preferences & hive**: Local storage
- **cached_network_image**: Image caching
- **firebase**: Authentication and analytics
- **flutter_stripe & razorpay**: Payment integration

## 🚦 Usage Examples

### Authentication

```dart
final authController = Get.find<AuthController>();
await authController.login(email: 'user@example.com', password: 'password');
```

### Product Management

```dart
final productController = Get.find<ProductController>();
await productController.loadProducts();
```

### Cart Management

```dart
final cartController = Get.find<CartController>();
await cartController.addToCart(product: product, quantity: 1);
```

## 📱 Build Commands

```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release
```

## 📄 License

This project is licensed under the MIT License.

---

**Note**: This is a core setup. Configure API endpoints, payment gateways, and Firebase before production use.
