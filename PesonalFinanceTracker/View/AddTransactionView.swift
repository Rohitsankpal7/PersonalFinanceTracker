//
//  AddTransactionView.swift
//  PesonalFinanceTracker
//
//  Created by Rohit Sankpal on 25/05/25.
//

import CoreData
import SwiftUI

struct AddTransactionView: View {
    
    @StateObject private var viewModel = TransactionViewModel()
    @Environment(\.managedObjectContext) private var context
    
    var body: some View {
        Form {
            Section(header: Text("Amount")) {
                TextField("0.00", text: $viewModel.amount)
                    .keyboardType(.decimalPad)
            }
            
            Section(header: Text("Category")) {
                Picker("Category", selection: $viewModel.category) {
                    ForEach(viewModel.categoryOptions, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.menu)
            }
            
            Section(header: Text("Description")) {
                TextField("Optional", text: $viewModel.desc)
            }
            
            Section(header: Text("Date")) {
                DatePicker("Select Date", selection: $viewModel.date)
            }
            
            Section(header: Text("Type")) {
                Picker("Type", selection: $viewModel.type) {
                    ForEach(viewModel.typeOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Button {
                viewModel.addTransaction(context)
            } label: {
                Text("Add Transaction")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
            }
        }
        .navigationTitle("Add Transaction")
        .overlay(
            Group {
                if viewModel.showToast {
                    ToastView(message: viewModel.toastMessage)
                        .transition(
                            .move(edge: .top).combined(with: .opacity)
                        )
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    viewModel.showToast = false
                                }
                            }
                        }
                }
            },
            alignment: .top
        )
    }
}

#Preview {
    AddTransactionView()
}
