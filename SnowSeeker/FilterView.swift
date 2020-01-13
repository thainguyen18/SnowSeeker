//
//  FilterView.swift
//  SnowSeeker
//
//  Created by Thai Nguyen on 1/13/20.
//  Copyright © 2020 Thai Nguyen. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var countriesList: [String] {
        let countries = Set(resorts.map { $0.country })
        
        return Array(countries)
    }
    
    let sizesList = ["Small", "Average", "Large"]
    
    let pricesList = ["$", "$$", "$$$"]
    
    @Binding var filteredResorts: [Resort]
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List {
            Section(header: Text("Country")) {
                ForEach(countriesList, id: \.self) { country in
                    GeometryReader { geo in
                        Text(country)
                            .frame(width: geo.size.width)
                        .background(Color.red)
                    }
                    .onTapGesture {
                            self.filteredResorts = self.resorts.filter {$0.country == country}
                            
                            self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            
            Section(header: Text("Size")) {
                ForEach(sizesList, id: \.self) { size in
                    GeometryReader { geo in
                        Text(size)
                            .frame(width: geo.size.width)
                        .background(Color.red)
                    }
                        .onTapGesture {
                            var sizeNumber: Int
                            
                            switch size {
                            case "Small":
                                sizeNumber = 1
                            case "Average":
                                sizeNumber = 2
                            default:
                                sizeNumber = 3
                            }
                            
                            self.filteredResorts = self.resorts.filter {$0.size == sizeNumber}
                            
                            self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            
            Section(header: Text("Price")) {
                ForEach(pricesList, id: \.self) { price in
                    GeometryReader { geo in
                        Text(price)
                            .frame(width: geo.size.width)
                            .background(Color.red)
                    }
                        .onTapGesture {
                            var priceNumber: Int
                            
                            switch price {
                            case "$":
                                priceNumber = 1
                            case "$$":
                                priceNumber = 2
                            default:
                                priceNumber = 3
                            }
                            
                            self.filteredResorts = self.resorts.filter {$0.price == priceNumber}
                            
                            self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .navigationBarTitle("Select a Filter")
        .listStyle(GroupedListStyle())
        .onAppear {
            self.filteredResorts = self.resorts
        }
    }
}

//struct FilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterView()
//    }
//}
