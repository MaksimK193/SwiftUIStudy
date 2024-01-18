//
//  CountriesView.swift
//  SwiftUIStudy
//
//  Created by USER on 17.01.2024.
//

import SwiftUI

struct CountriesView: View {
    @ObservedObject private var countriesViewModel = CountriesViewModel()
    
    var body: some View {
            List {
                ForEach(countriesViewModel.countries, id: \.name) { country in
                    
                    NavigationLink(destination: {
                        DetailCountryView(countryModel: country)
                    }, label: {
                        CountriesCellView(countryModel: country)
                            .onAppear() {
                                if country == countriesViewModel.countries.last {
                                    countriesViewModel.fetch()
                                }
                                    
                            }
                    })
                }
            }
            .listStyle(.plain)
            .navigationTitle("Countries")
    }
}

struct CountriesCellView: View {
    let countryModel: CountryModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "photo")
                    .frame(width: 54, height: 36)
                VStack(alignment: .leading) {
                    Text(countryModel.name)
                    Text(countryModel.capital)
                }
            }
            Text(countryModel.description_small)
        }
    }
}

#Preview {
    NavigationStack {
        CountriesView()
    }
}
