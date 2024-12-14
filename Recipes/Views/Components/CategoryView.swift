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
    let iconFontSize: CGFloat = 32
    
    var body: some View {
        VStack {
            CategoryIconView(icon: categoryIcon, fontSize: iconFontSize)
            CategoryNameView(category: category, isActive: isActive)
        }
        .frame(width: UIScreen.main.bounds.width * 0.20, height: UIScreen.main.bounds.height * 0.10)
        .background(isActive ? .green : .gray.opacity(0.1))
        .clipShape(.rect(cornerRadius: 10))
        .padding(.trailing, 3.5)
        .foregroundStyle(.primary)
    }
}

struct CategoryIconView: View {
    let icon: String
    let fontSize: CGFloat
    
    var body: some View {
        Text(icon)
            .font(.system(size: fontSize))
    }
}

struct CategoryNameView: View {
    let category: String
    let isActive: Bool
    
    var body: some View {
        Text(category)
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundStyle(isActive ? .white : .primary)
            .lineLimit(1)
    }
}

#Preview {
    CategoryView(isActive: false, category: "All", categoryIcon: "🍦")
}

