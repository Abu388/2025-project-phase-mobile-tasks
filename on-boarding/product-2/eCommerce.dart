import 'dart:io';

void main() {
  ProductManager productManager = ProductManager();

  var options = [
    "1. View a product",
    "2. Add product",
    "3. Remove product",
    "4. Edit product",
    "5. View all products",
    "6. Exit",
  ];

  while (true) {
    print("\n");
    for (var option in options) {
      print(option);
    }

    stdout.write('\nEnter a number: ');
    int? choice = int.tryParse(stdin.readLineSync() ?? '');

    switch (choice) {
      case 1:
        stdout.write(
            "Enter product index (0 to ${productManager.length - 1}): ");
        int? index = int.tryParse(stdin.readLineSync() ?? '');
        productManager.viewProduct(index);
        break;

      case 2:
        stdout.write("Enter product name: ");
        String name = stdin.readLineSync() ?? '';

        stdout.write("Enter product description: ");
        String description = stdin.readLineSync() ?? '';

        stdout.write("Enter product price: ");
        double price = double.tryParse(stdin.readLineSync() ?? '') ?? 0;

        productManager.addProduct(Product(name, description, price));
        break;

      case 3:
        stdout.write("Enter index to remove: ");
        int? index = int.tryParse(stdin.readLineSync() ?? '');
        productManager.deleteProduct(index);
        break;

      case 4:
        stdout.write("Enter index to edit: ");
        int? index = int.tryParse(stdin.readLineSync() ?? '');
        if (index != null && index >= 0 && index < productManager.length) {
          stdout.write("New name: ");
          String name = stdin.readLineSync() ?? '';

          stdout.write("New description: ");
          String description = stdin.readLineSync() ?? '';

          stdout.write("New price: ");
          double price = double.tryParse(stdin.readLineSync() ?? '') ?? 0;

          productManager.editProduct(index, Product(name, description, price));
        } else {
          print("Invalid index.");
        }
        break;

      case 5:
        productManager.viewAllProducts();
        break;

      case 6:
        print("Exiting. Bye!");
        exit(0);

      default:
        print("Invalid option. Try again.");
    }
  }
}

// ----------------------------

class Product {
  String name;
  String description;
  double price;

  Product(this.name, this.description, this.price);

  void display() {
    print('Name: $name');
    print('Description: $description');
    print('Price: \$${price.toStringAsFixed(2)}');
  }
}

// ----------------------------

class ProductManager {
  List<Product> products = [
    Product("Laptop", "This is a high-quality laptop.", 33000),
    Product("Shoe", "These shoes are stylish and comfortable.", 1000),
    Product("Car", "This car offers a wonderful driving experience.", 10000000),
    Product("Phone", "This is a Samsung smartphone with great features.", 22000),
  ];

  void addProduct(Product product) {
    products.add(product);
    print("Product added!");
  }

  void viewAllProducts() {
    if (products.isEmpty) {
      print("No products available.");
    } else {
      for (int i = 0; i < products.length; i++) {
        print("\nProduct #$i:");
        products[i].display();
      }
    }
  }

  void viewProduct(int? index) {
    if (index != null && index >= 0 && index < products.length) {
      products[index].display();
    } else {
      print("Invalid index!");
    }
  }

  void editProduct(int index, Product updatedProduct) {
    products[index] = updatedProduct;
    print("Product updated.");
  }

  void deleteProduct(int? index) {
    if (index != null && index >= 0 && index < products.length) {
      products.removeAt(index);
      print("Product removed.");
    } else {
      print("Invalid index!");
    }
  }

  int get length => products.length;
}








 
  





// dart eComerce.dart