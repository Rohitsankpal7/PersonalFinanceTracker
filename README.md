# Personal Finance Tracker

A simple and user-friendly iOS application built with SwiftUI and Core Data to manage your daily income and expenses.

## 📱 Features

- **Add Transactions**
  - Enter transaction amount
  - Choose a category (Food, Transport, Entertainment, Salary, Other)
  - Select transaction type (Income / Expense)
  - Add a description
  - Pick a date (defaults to today)

- **View Transactions**
  - List of all transactions with:
    - Amount, category, description, and date
    - Green for income, red for expenses
  - Total balance displayed at the top
  - Pull-to-refresh functionality

- **User Feedback**
  - Toast messages on validation or success
  - Input validations for amount and category


## 🗂 Architecture

The app follows **MVVM (Model-View-ViewModel)** architecture:
- **Model**: Core Data entity `Transaction`
- **ViewModel**: Handles input validation, transaction logic, and toast state
- **Views**: Built using SwiftUI

## 🧪 Testing

Includes basic unit tests for:
- Input validation
- Toast messages
- Core Data integration using in-memory store

## 🛠 Technologies Used

- SwiftUI
- Core Data
- MVVM Pattern
- XCTest for unit testing

## 📦 Installation

1. Clone the repository:
   ```bash
   git clone [https://github.com/Rohitsankpal7/PersonalFinanceTracker/tree/main/PesonalFinanceTracker](https://github.com/Rohitsankpal7/PersonalFinanceTracker.git)

2. Open in Xcode:
    open PersonalFinanceTracker.xcodeproj

3. Build and run on iOS Simulator or real device.

## Screen shots

![Simulator Screenshot - iPhone 16 Pro - 2025-05-26 at 00 26 41](https://github.com/user-attachments/assets/43dd15bf-da43-47be-ae62-d8df15e337cd)
![Simulator Screenshot - iPhone 16 Pro - 2025-05-26 at 00 25 16](https://github.com/user-attachments/assets/89ca42b9-bd8a-4e4a-b1ae-a4bd3ed7ea12)
![Simulator Screenshot - iPhone 16 Pro - 2025-05-26 at 00 35 52](https://github.com/user-attachments/assets/5e38deda-4932-482c-b024-555022f2c7f6)

