//
//  DetailCountryView.swift
//  SwiftUIStudy
//
//  Created by USER on 17.01.2024.
//

import SwiftUI
import ScalingHeaderScrollView

struct DetailCountryView: View {
    
    let countryModel: CountryEntity
    @State var selectedImage: String = ""
     
    var body: some View {
        ScalingHeaderScrollView {
            VStack {
                TabView(selection: $selectedImage) {
                    ForEach(countryModel.infoImages ?? [], id: \.self) { image in
                        AsyncImageView(urlString: image)
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .frame(height: 240)
                Spacer()
            }
        } content: {
            countryDescription
                .padding([.leading, .trailing], 16)
                .padding([.top], 24)
        }
        .height(min: 100, max: 240)
        .allowsHeaderCollapse()
        .hideScrollIndicators()
        .headerAlignment(.top)
        .ignoresSafeArea()
        .toolbarBackground(.hidden, for: .navigationBar)
    }
    
    @ViewBuilder
    var countryDescription: some View {
        VStack {
            
            HStack {
                Text(countryModel.name ?? "")
                    .font(.title)
                Spacer()
            }
            
            VStack {
                HStack {
                    Image(systemName: "star")
                        .foregroundStyle(.orange)
                    Text("Capital")
                    Spacer()
                    Text(countryModel.capital ?? "")
                        .foregroundStyle(.gray)
                }
                Divider()
            }
            .frame(height: 44)
            
            VStack {
                HStack {
                    Image(systemName: "face.smiling")
                        .foregroundStyle(.orange)
                    Text("Population")
                    Spacer()
                    Text("\(countryModel.population)")
                        .foregroundStyle(.gray)
                }
                Divider()
            }
            .frame(height: 44)
            
            VStack {
                HStack {
                    Image(systemName: "globe.americas.fill")
                        .foregroundStyle(.orange)
                    Text("Continent")
                    Spacer()
                    Text(countryModel.continent ?? "")
                        .foregroundStyle(.gray)
                }
                Divider()
            }
            .frame(height: 44)
            
            HStack {
                Text("About")
                Spacer()
            }
            .padding([.top], 20)
            .padding([.bottom], 8)
            
            Text(countryModel.description_big ?? "")
        }
    }
}
