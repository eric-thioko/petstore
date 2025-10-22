# 🐾 Pet Store App

A comprehensive Flutter application for managing a pet store, built with Clean Architecture principles and modern Flutter development practices.

## Demo
### Web
[recording.webm](https://github.com/user-attachments/assets/56738988-c51f-46b3-829b-6a6f5031a420)
### Mobile
https://github.com/user-attachments/assets/4baf0a03-b646-46df-b15d-2f88df41fa7e


## 📱 Features

### Core Functionality
- **Pet Management**: Browse, add, update, and delete pets
- **Shopping Cart**: Add pets to cart, manage cart items, and checkout
- **Pet Categories**: Organize pets by categories and tags
- **Pet Status**: Track pet availability (available, pending, sold)
- **Image Support**: Display pet photos with cached network images

### UI/UX Features
- **Material Design 3**: Modern UI with custom theme
- **Responsive Layout**: Optimized for different screen sizes
- **Loading States**: Skeleton loading and progress indicators
- **Error Handling**: User-friendly error messages with retry options
- **Empty States**: Helpful messages when no data is available
- **Confirmation Dialogs**: Safe deletion and checkout confirmations
- **Refresh Indicator**: Pull-to-refresh functionality

## 🏗️ Architecture

### Clean Architecture Layers

```
lib/
├── core/                           # Core utilities and shared components
│   ├── common/
│   │   ├── bloc_observer.dart     # BLoC state observer for debugging
│   │   ├── state/                 # Generic state management
│   │   ├── theme/                 # App theme configuration
│   │   └── widgets/               # Reusable UI components
│   ├── di/                        # Dependency Injection (GetIt)
│   ├── network/                   # API client and endpoints
│   └── router/                    # Go Router navigation
│
├── data/                          # Data Layer
│   └── repository/
│       ├── cart/                  # Cart repository implementation
│       │   ├── cart_repository.dart
│       │   ├── data_source/
│       │   │   └── cart_local_data_source.dart
│       │   └── model/             # Cart data models
│       └── pet/                   # Pet repository implementation
│           ├── pet_repository.dart
│           ├── data_source/
│           │   └── pet_remote_data_source.dart
│           └── model/             # Pet data models (DTOs)
│               ├── pet_get_response.dart
│               ├── pet_add_request.dart
│               ├── pet_update_request.dart
│               └── pet_delete_request.dart
│
├── domain/                        # Domain Layer (Business Logic)
│   ├── entity/                    # Business entities
│   │   └── pet/
│   │       ├── pet_entity.dart
│   │       ├── category_entity.dart
│   │       └── tags_entity.dart
│   └── usecase/                   # Use cases
│       ├── cart/
│       │   ├── cart_add.dart
│       │   ├── cart_get.dart
│       │   ├── cart_remove.dart
│       │   └── cart_checkout.dart
│       └── pet/
│           ├── pet_get.dart
│           ├── pet_add.dart
│           ├── pet_update.dart
│           └── pet_delete.dart
│
└── presentation/                  # Presentation Layer (UI)
    ├── home/                      # Home screen
    │   ├── home_page.dart
    │   ├── cubit/
    │   │   ├── home_cubit.dart
    │   │   └── home_state.dart
    │   └── widgets/
    │       └── pet_card.dart
    ├── cart/                      # Cart screen
    │   ├── cart_page.dart
    │   ├── cubit/
    │   │   ├── cart_cubit.dart
    │   │   └── cart_state.dart
    │   └── widgets/
    │       ├── cart_item.dart
    │       └── checkout_button.dart
    ├── add_pet/                   # Add pet screen
    │   └── add_pet_page.dart
    └── update_pet/                # Update pet screen
        └── update_pet_page.dart
```

## 🛠️ Tech Stack

### Core Dependencies
- **Flutter SDK**: `>=3.0.0 <4.0.0`
- **Dart**: Latest stable version

### State Management & Architecture
- **flutter_bloc**: ^8.1.6 - State management using BLoC pattern
- **dartz**: ^0.10.1 - Functional programming (Either, Option)
- **get_it**: ^8.0.3 - Dependency injection
- **equatable**: ^2.0.7 - Value equality

### Networking & Data
- **dio**: ^5.7.0 - HTTP client for API calls
- **cached_network_image**: ^3.4.1 - Image caching

### Navigation & Routing
- **go_router**: ^14.6.2 - Declarative routing

### Testing
- **flutter_test**: SDK - Widget and unit testing
- **bloc_test**: ^9.1.7 - BLoC testing utilities
- **mocktail**: ^1.0.4 - Mocking library

### Code Quality
- **flutter_lints**: ^5.0.0 - Linting rules

## 📦 Installation

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code
- iOS development setup (for iOS builds)

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd petstore
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

4. **Run tests**
   ```bash
   flutter test
   ```

## 🧪 Testing

### Test Coverage
The project includes comprehensive test coverage:

- **95 tests total** ✅
- **100% passing rate** ✅

#### Test Breakdown:
- **Data Layer Tests**: 16 tests
  - Repository pattern testing
  - Data source integration
  - Response/Request mapping

- **Domain Layer Tests**: 20 tests
  - Use case business logic
  - Entity transformations
  - Error handling

- **Presentation Layer Tests**: 59 tests
  - **Cubit Tests**: 15 tests
    - State management logic
    - BLoC event handling
  - **Widget Tests**: 44 tests
    - UI component rendering
    - User interactions
    - State-driven UI changes

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/domain/usecase/pet/pet_get_test.dart

# Run tests with verbose output
flutter test --verbose
```

## 🔍 Code Quality

### Static Analysis
```bash
# Run Flutter analyzer
flutter analyze

# Current status: ✅ No issues found
```

### Linting
The project follows Flutter's recommended linting rules with custom configurations.

## 🌐 API Integration

The app integrates with the PetStore API:

**Base URL**: `https://petstore3.swagger.io`

### Endpoints Used:
- `GET /api/v3/pet` - Get all pets
- `POST /api/v3/pet` - Add new pet
- `PUT /api/v3/pet` - Update pet
- `DELETE /api/v3/pet/{petId}` - Delete pet

## 🎨 Design System

### Theme
- **Color Scheme**: Material Design 3 with custom primary colors
- **Typography**: Poppins font family
- **Icons**: Material Icons

### Reusable Components
- **LoadingIndicator**: Centralized loading state
- **EmptyState**: Consistent empty state UI
- **ErrorState**: Standardized error display with retry
- **ConfirmationDialog**: Reusable confirmation dialogs
- **PetCard**: Pet display card component
- **CartItem**: Shopping cart item component
- **CheckoutButton**: Checkout action button

## 📝 State Management

### BLoC Pattern
The app uses BLoC (Business Logic Component) pattern for state management:

- **Cubits**: Simplified BLoC without events
- **States**: Immutable state classes using Equatable
- **Generic States**: Reusable state wrapper for loading/success/error

### Generic State Structure
```dart
class GenericDataState<T> {
  final T? data;
  final Failure? failure;
  final bool isLoading;

  // States: initial, loading, success, error
}
```

## 🔄 Dependency Injection

The app uses **GetIt** for dependency injection with lazy singleton pattern:

- **Network**: Dio, ApiClient, Endpoints
- **Data Sources**: Remote and Local data sources
- **Repositories**: Domain repository implementations
- **Use Cases**: Business logic use cases

## 🚀 Build & Deployment

### Development Build
```bash
# Debug mode
flutter run

# Profile mode (performance testing)
flutter run --profile

# Release mode
flutter run --release
```

### Production Build
```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

## 📚 Project Evolution

### Implemented Features
1. ✅ Clean Architecture setup
2. ✅ Dependency Injection with GetIt
3. ✅ BLoC state management
4. ✅ Pet CRUD operations
5. ✅ Shopping cart functionality
6. ✅ Comprehensive testing suite
7. ✅ Error handling and loading states
8. ✅ Image caching
9. ✅ Navigation with Go Router
10. ✅ Theme customization

### Technical Improvements
1. ✅ Migration from MultiProvider to GetIt
2. ✅ Centralized cart logic in HomeCubit
3. ✅ Generic state management pattern
4. ✅ Proper separation of concerns
5. ✅ Type-safe routing
6. ✅ Comprehensive test coverage (95 tests)
7. ✅ Fixed all deprecation warnings
8. ✅ Clean code architecture

## 🤝 Contributing

### Code Style
- Follow Flutter style guide
- Use meaningful variable names
- Add comments for complex logic
- Write tests for new features

### Git Workflow
1. Create feature branch
2. Implement changes
3. Run tests (`flutter test`)
4. Run analyzer (`flutter analyze`)
5. Create pull request

## 📄 License

This project is licensed under the MIT License.

## 👥 Authors

- **Development Team** - Initial work and implementation

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- PetStore API for the backend service
- Community packages and contributors

---

**Made with ❤️ using Flutter**

For more information, visit [Flutter Documentation](https://flutter.dev/docs)
