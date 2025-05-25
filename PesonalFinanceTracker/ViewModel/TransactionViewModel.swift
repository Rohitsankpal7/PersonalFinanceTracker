//
//  TransactionViewModel.swift
//  PesonalFinanceTracker
//
//  Created by Rohit Sankpal on 25/05/25.
//

import CoreData
import SwiftUI

class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    @Published var amount: String = ""
    @Published var date: Date = Date()
    @Published var category: String = ""
    @Published var desc: String = ""
    @Published var type: String = "" // Income/Expense
    
    @Published var showToast: Bool = false
    @Published var toastMessage: String = ""
    
    // drop down properties
    let categoryOptions = ["Food", "Transport", "Entertainment", "Salary", "Other"]
    let typeOptions = ["Income", "Expense"]
    
    func isValidInput() -> Bool {
        guard let amountValue = Double(amount), amountValue > 0 else {
            showToast(message: "Invalid input. Please check amount.")
            return false
        }
        return true
    }
    
    private var toastTimer: Timer?
    
    // MARK:- Add New Transaction
    func addTransaction(_ context: NSManagedObjectContext) {
        guard isValidInput() else {
            print("Invalid amount")
            return
        }
        
        guard !category.isEmpty else {
            toastMessage = "Please select category."
            showToast = true
            return
        }
        
        let transaction = Transaction(context: context)
        transaction.id = UUID()
        transaction.amount = Double(amount) ?? 0
        transaction.category = category
        transaction.desc = desc
        transaction.date = date
        transaction.type = type
        
        do {
            try context.save()
            clearInputs()
            showToast(message: "Transaction added successfully!")
        } catch {
            showToast(message: "Failed to save transaction.")
            print("Failed to save transaction: \(error.localizedDescription)")
        }
    }
    
    private func showToast(message: String) {
        toastMessage = message
        showToast = true
        
        // Cancel previous timer if any
        toastTimer?.invalidate()
        
        toastTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            DispatchQueue.main.async {
                self.showToast = false
            }
        }
    }

    
    // MARK: - Clear Input Fields
    func clearInputs() {
        amount = ""
        category = "Food"
        desc = ""
        date = Date()
        type = "Expense"
    }
}
