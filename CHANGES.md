# CHANGES

Date: 2025-11-04

Summary of changes for the Football Shop task.

- Implemented Football Shop UI in `lib/main.dart`:
  - Replaced template counter app with a home screen.
  - Added three buttons with icons and distinct colors:
    - All Products (blue, `Icons.list_alt`)
    - My Products (green, `Icons.shopping_bag`)
    - Create Product (red, `Icons.add_box`)
  - Each button shows a `SnackBar` message per requirements.
  - Set app title to "Football Shop" and enabled Material 3 theme.

- Updated `README.md` with required answers:
  - Widget tree and parent-child explanation.
  - List of widgets used and their roles.
  - Purpose of `MaterialApp`.
  - StatelessWidget vs StatefulWidget.
  - BuildContext usage and importance.
  - Hot reload vs hot restart.
  - Added Git add/commit/push instructions for a new GitHub repo.

- Updated `TODO.md` to check completed items.

Date: 2025-11-12

- Added product creation form `lib/screens/product_form.dart`:
  - Inputs: name, price, description, category, thumbnail URL, isFeatured.
  - Validation for non-empty fields, numeric price > 0, min/max lengths, and valid URL format.
  - Save button shows a pop-up dialog with the entered data.

- Implemented drawer `lib/widgets/left_drawer.dart` with navigation:
  - Halaman Utama (pushReplacement to Home).
  - Tambah Produk (push to form page).

- Refactored home to avoid circular imports:
  - Moved `HomePage` to `lib/screens/home.dart`.
  - Updated `lib/main.dart` to use the new screen.
  - Wired the "Tambah Produk" button to navigate to the form page.

- Updated `README.md` with answers about navigation, page structure using Scaffold/AppBar/Drawer, layout widgets for forms, and theme consistency.

- Checked off remaining items in `TODO.md` for this task.
