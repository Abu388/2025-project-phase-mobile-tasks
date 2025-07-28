# Simple E-Commerce Flutter App

This is a simple e-commerce Flutter application with navigation between multiple screens.  
Users can view a list of products, see product details, add new products, and search for products.

---

## 📂 Project Structure

lib/
├── main.dart # Entry point of the app, defines routes.
├── home_page.dart # Displays a list of products (default screen).
├── addProductPage.dart # Screen to add a new product (with name, price, description, and image).
├── details_page.dart # Screen showing details of a selected product.
└── search_product.dart # Screen to search through products.
└── images/ # Contains product images.
screenshots/ # Contains app screenshots for documentation.


---

## ✨ Features

- **Home Page** (`home_page.dart`)
  - Displays a list of products (with name, price, and image).
  - Tapping on a product navigates to the **Details Page**.
  - Floating Action Button (FAB) navigates to **Add Product Page** to create a new product.
  
- **Add Product Page** (`addProductPage.dart`)
  - Form to add a new product with fields for:
    - Product Name
    - Price
    - Description
    - Image path (or image picker).
  - On saving, the new product is returned to the **Home Page** and displayed in the list.

- **Details Page** (`details_page.dart`)
  - Shows the selected product's image, name, price, and description.
  - Allows actions like "Buy" or size selection.

- **Search Product Page** (`search_product.dart`)
  - Screen for searching products from the list (to be integrated with search logic).

- **Main File** (`main.dart`)
  - Configures routes and initializes the app.
  - Routes:
    - `/` → HomePage
    - `/details` → DetailsPage
    - `/addproduct` → AddProductPage
    - `/search` → SearchProductPage

---

## 🖼 Screenshots

Screenshots of the app are located in the `screenshots/` folder.  
You can include them here like this (example):  
![Home Page](screenshots/home.png)  
![Details Page](screenshots/details.png)

---

## 🛠 How It Works

1. **Navigation**
   - Uses `Navigator.pushNamed` and `Navigator.pop` to switch between pages.
   - The `AddProductPage` returns a new product as a `Map<String, String>` which is added to the product list on `HomePage`.

2. **State Management**
   - The product list (`data`) is maintained as a state in `HomePage`.
   - When a new product is added, `setState` updates the UI dynamically.

3. **Image Handling**
   - Default products use assets from the `images/` folder.
   - `AddProductPage` allows entering an image path or (optionally) using the image picker.

---

## 🚀 How to Run

1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Ensure the `images/` folder contains the sample product images:
   - `images/s2.jpg`
   - `images/s22.jpg`
   - `images/s23.jpg`
4. Run the app:
   ```bash
   flutter run

if ur code couldn't perform check out this things :- widget_test.dart and 


# # # # # # # #  # #  # #  # # #  # #  # #  # # # 
//\\//\\//\\//\//\/\/\/\/\//\/\/\//\/\/\//\/\/\//\/\//\
/////////////////////////////////////////////////

widget_test.dart



// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hello_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}



# # # # # # # #  # #  # #  # # #  # #  # #  # # # 
//\\//\\//\\//\//\/\/\/\/\//\/\/\//\/\/\//\/\/\//\/\//\
/////////////////////////////////////////////////

pubspec.yaml



name: hello_app
description: "A new Flutter project."
# The following line prevents the package from being accidentally published to
# pub.dev using `flutter pub publish`. This is preferred for private packages.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev

# The following defines the version and build number for your application.
# A version number is three numbers separated by dots, like 1.2.43
# followed by an optional build number separated by a +.
# Both the version and the builder number may be overridden in flutter
# build by specifying --build-name and --build-number, respectively.
# In Android, build-name is used as versionName while build-number used as versionCode.
# Read more about Android versioning at https://developer.android.com/studio/publish/versioning
# In iOS, build-name is used as CFBundleShortVersionString while build-number is used as CFBundleVersion.
# Read more about iOS versioning at
# https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
# In Windows, build-name is used as the major, minor, and patch parts
# of the product and file versions while build-number is used as the build suffix.
version: 1.0.0+1

environment:
  sdk: ^3.8.1

# Dependencies specify other packages that your package needs in order to work.
# To automatically upgrade your package dependencies to the latest versions
# consider running `flutter pub upgrade --major-versions`. Alternatively,
# dependencies can be manually updated by changing the version numbers below to
# the latest version available on pub.dev. To see which dependencies have newer
# versions available, run `flutter pub outdated`.
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.8
  image_picker: ^1.0.7 
dev_dependencies:
  flutter_test:
    sdk: flutter

  # The "flutter_lints" package below contains a set of recommended lints to
  # encourage good coding practices. The lint set provided by the package is
  # activated in the `analysis_options.yaml` file located at the root of your
  # package. See that file for information about deactivating specific lint
  # rules and activating additional ones.
  flutter_lints: ^5.0.0

# For information on the generic Dart part of this file, see the
# following page: https://dart.dev/tools/pub/pubspec

# The following section is specific to Flutter packages.
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  # To add assets to your application, add an assets section, like this:
  assets:
    - images/
  #   - images/a_dot_ham.jpeg

  # An image asset can refer to one or more resolution-specific "variants", see
  # https://flutter.dev/to/resolution-aware-images

  # For details regarding adding assets from package dependencies, see
  # https://flutter.dev/to/asset-from-package

  # To add custom fonts to your application, add a fonts section here,
  # in this "flutter" section. Each entry in this list should have a
  # "family" key with the font family name, and a "fonts" key with a
  # list giving the asset and other descriptors for the font. For
  # example:
  # fonts:
  #   - family: Schyler
  #     fonts:
  #       - asset: fonts/Schyler-Regular.ttf
  #       - asset: fonts/Schyler-Italic.ttf
  #         style: italic
  #   - family: Trajan Pro
  #     fonts:
  #       - asset: fonts/TrajanPro.ttf
  #       - asset: fonts/TrajanPro_Bold.ttf
  #         weight: 700
  #
  # For details regarding fonts from package dependencies,
  # see https://flutter.dev/to/font-from-package





### ✅ Task 8: Linter Setup Complete

- Installed `flutter_lints` in `pubspec.yaml`.
- Created `analysis_options.yaml` and added recommended rules:
  - `avoid_print`, `prefer_const_constructors`, `prefer_single_quotes`, etc.
- Ran `flutter analyze` to check for linter issues.
- IDE now shows warnings and suggestions for cleaner, consistent code.
