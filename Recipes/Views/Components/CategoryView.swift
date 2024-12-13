//
//  CategoryView.swift
//  Recipes
//
//  Created by Bruke Wondessen on 12/12/24.
//

import SwiftUI

struct CategoryView: View {
    let isActive: Bool
    let category: String
    let categoryIcon: String
    
    var body: some View {
        VStack {
            Text(categoryIcon)
                .font(.title)
            
            Text(category)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(isActive ? .white : .primary)
                .lineLimit(1)
        }
        .frame(width: UIScreen.main.bounds.width * 0.20, height: UIScreen.main.bounds.height * 0.10)
        .background(isActive ? .green : .gray.opacity(0.1))
        .clipShape(.rect(cornerRadius: 10))
        .padding(.trailing, 3.5)
        .foregroundStyle(.primary)
    }
}

#Preview {
    CategoryView(isActive: false, category: "All", categoryIcon: "🍦")
}
