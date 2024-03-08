//
//  ContentView.swift
//  ThoughtTrove
//
//  Created by Максим Самороковский on 05.03.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = QuotesViewModel()
    @State private var selectedCategory: String? = nil
    @State private var isNavigationAllowed = false
    @State private var selectedCategoryRotation: [String: Bool] = [:]
    @State private var isPresented = false
    
    var body: some View {
            NavigationStack {
            ZStack {
                BackgroundColorView()
                VStack(alignment: .leading) {
                    ScrollView {
                        VStack(spacing: 25) {
                            Text("- Popular -")
                                .font(.largeTitle)
                            ForEach(CategoriesData.allCategories.prefix(6), id: \.self) { category in
                                Button(action: {
                                    withAnimation {
                                        selectedCategoryRotation[category] = true
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        selectedCategory = category
                                        isNavigationAllowed = true
                                        selectedCategoryRotation[category] = false
                                        isPresented = true
                                    }
                                }) {
                                    Text(category)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 10)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 60)
                                        .background(Gradient(colors: [.blue, .indigo]))
                                        .cornerRadius(20)
                                        .contentShape(Rectangle())
                                        .padding(.horizontal, 10)
                                        .rotation3DEffect(.degrees(selectedCategoryRotation[category] ?? false ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                                }
                                .disabled(isNavigationAllowed)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 40)
                }
                .navigationTitle("Categories")
                .padding()
                .fullScreenCover(isPresented: $isPresented) {
                    if let category = selectedCategory {
                        NavigationView {
                            QuotesListView(category: category)
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarLeading) {
                                        Button(action: {
                                            isNavigationAllowed = false
                                            isPresented = false
                                        }) {
                                            Image(systemName: "chevron.left")
                                        }
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

