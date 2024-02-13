//
//  CountriesView.swift
//  SwiftUIStudy
//
//  Created by USER on 17.01.2024.
//

import SwiftUI
import YandexMobileMetrica

struct CountriesView: View {
    @ObservedObject private var countriesViewModel = CountriesViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(countriesViewModel.countriesCoreData, id: \.name) { country in
                    NavigationLink(destination: {
                        DetailCountryView(countryModel: country)
                    }, label: {
                        CountriesCellView(countryModel: country, countriesViewModel: countriesViewModel)
                            .onAppear() {
                                if country == countriesViewModel.countriesCoreData.last {
                                    countriesViewModel.fetch(next: countriesViewModel.next)
                                }
                            }
                    })
                }
            }
            .listStyle(.plain)
            .navigationTitle("Countries")
            .onAppear {
                YMMYandexMetrica.reportEvent("YandexMapsScreen opened")
                countriesViewModel.fetch()
                countriesViewModel.getCountries()
            }
            .refreshable {
                countriesViewModel.fetch()
            }
        }
    }
}

struct CountriesCellView: View {
    let countryModel: CountryEntity
    @ObservedObject var countriesViewModel: CountriesViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImageView(urlString: countryModel.flagImage ?? "")
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 54, maxHeight: 36)
                VStack(alignment: .leading) {
                    Text(countryModel.name ?? "")
                    Text(countryModel.capital ?? "")
                        .foregroundStyle(.gray)
                }
            }
            Text(countryModel.description_small ?? "")
        }
    }
}

#Preview {
    NavigationStack {
        CountriesView()
    }
}

struct AsyncImageView: View {
    @StateObject private var loader = ImageLoader()
    let urlString: String

    var body: some View {
        Group {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                Image(systemName: "photo")
            }
        }
        .onAppear {
            loader.load(fromURLString: urlString)
        }
    }
}
