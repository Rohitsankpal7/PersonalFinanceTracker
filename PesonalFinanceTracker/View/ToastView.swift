//
//  ToastView.swift
//  PesonalFinanceTracker
//
//  Created by Rohit Sankpal on 25/05/25.
//

import SwiftUI

struct ToastView: View {
    var message: String
    var body: some View {
        Spacer()
        Text(message)
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.8))
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.top, 50)
    }
}

#Preview {
    ToastView(message: "")
}
