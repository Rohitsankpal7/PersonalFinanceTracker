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
    
    // drop down properties
    let categoryOptions = ["Food", "Transport", "Entertainment", "Salary", "Other"]
    let typeOptions = ["Income", "Expense"]
    
    // MARK:- Add New Transaction
    func addTransaction(_ context: NSManagedObjectContext) {
        guard let amountValue = Double(amount), amountValue > 0 else {
            print("Invalid amount")
            return
        }
        
        let transaction = Transaction(context: context)
        transaction.id = UUID()
        transaction.amount = amountValue
        transaction.category = category
        transaction.desc = desc
        transaction.date = date
        transaction.type = type
        
        do {
            try context.save()
            clearInputs()
        } catch {
            print("Failed to save transaction: \(error.localizedDescription)")
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
