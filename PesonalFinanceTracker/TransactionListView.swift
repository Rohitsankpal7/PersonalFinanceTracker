//
//  ContentView.swift
//  PesonalFinanceTracker
//
//  Created by Rohit Sankpal on 25/05/25.
//

import SwiftUI
import CoreData

struct TransactionListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.timestamp, ascending: true)],
        animation: .default
)
    private var transactions: FetchedResults<Transaction>
    
    var totalBalance: Double {
        transactions.reduce(0) { result, txn in
            result + (txn.type == "Income" ? txn.amount : -txn.amount)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Total Balance")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text("$\(totalBalance, specifier: "%.2f")")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(totalBalance >= 0 ? .green : .red)
                    }
                    .padding(.vertical, 5)
                }
                
                ForEach(transactions) { txn in
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(txn.category ?? "Unknown")
                                .font(.system(size: 17, weight: .medium))
                            
                            Spacer()
                            
                            Text("\(txn.type == "Income" ? "+" : "-")$\(txn.amount, specifier: "%.2f")")
                                .fontWeight(.bold)
                                .foregroundColor(txn.type == "Income" ? .green : .red)
                        }
                        // description
                        if let desc = txn.desc, !desc.isEmpty {
                            Text(desc)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        // Income/Expense date
                        if let date = txn.date {
                            Text(date.formatted(date: .abbreviated, time: .omitted))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Transactions")
            .background(Color.yellow)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddTransactionView()) {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
        }
        .refreshable {
            // calling nothing on pull to refresh because @FetchRequest auto-refreshes.
            // added this because it will show user that spinner so it looks like data updated.
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { transactions[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    TransactionListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
