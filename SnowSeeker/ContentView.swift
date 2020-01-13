//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Thai Nguyen on 1/11/20.
//  Copyright © 2020 Thai Nguyen. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)

            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                .foregroundColor(.secondary)
        }
    }
}

struct ContentView: View {
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @ObservedObject var favorites = Favorites()
    
    @State private var showingSorting = false
    
    @State private var showingFilter = false
    
    @State private var filteredAndSortedResorts = [Resort]()

    var body: some View {
        NavigationView {
            List(filteredAndSortedResorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )

                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                        .accessibility(label: Text("This is a favorite resort"))
                        .foregroundColor(Color.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(leading: Button(action: { self.showingFilter = true }) { Text("Filter") },
                trailing: Button(action: { self.showingSorting = true }) { Text("Sort") }
            )
            
            WelcomeView()
        }
        .phoneOnlyStackNavigationView()
        .environmentObject(favorites)
        .onAppear {
            self.filteredAndSortedResorts = self.resorts
        }
        .actionSheet(isPresented: $showingSorting) {
            ActionSheet(title: Text("Sorting"), message: nil, buttons: [
                .default(Text("Default")) { self.filteredAndSortedResorts = Bundle.main.decode("resorts.json") },
                .default(Text("Alphabetical")) { self.filteredAndSortedResorts.sort {$0.name < $1.name} },
                .default(Text("Country")) { self.filteredAndSortedResorts.sort {$0.country < $1.country} },
                .cancel()
                ])
        }
        .sheet(isPresented: $showingFilter) {
            FilterView(filteredResorts: self.$filteredAndSortedResorts)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
