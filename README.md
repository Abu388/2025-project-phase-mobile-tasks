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









