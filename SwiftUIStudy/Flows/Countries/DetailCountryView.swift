//
//  DetailCountryView.swift
//  SwiftUIStudy
//
//  Created by USER on 17.01.2024.
//

import SwiftUI
import ScalingHeaderScrollView

struct DetailCountryView: View {
    
    let countryModel: CountryModel
    @State var selectedImage: String = ""
     
    var body: some View {
        
        ScalingHeaderScrollView {
            VStack {
                TabView(selection: $selectedImage) {
                    ForEach(countryModel.country_info.images, id: \.self) { image in
                        AsyncImageView(urlString: image)
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 50, height: 50)
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .frame(height: 240)
                .background(.brown)
                Spacer()
            }
        } content: {
            countryDescription
                .padding([.leading, .trailing], 16)
                .padding([.top], 24)
                .background(.ultraThinMaterial)
        }
        .height(min: 100, max: 240)
        .allowsHeaderCollapse()
        .headerAlignment(.top)
        .ignoresSafeArea()
        .toolbarBackground(.hidden, for: .navigationBar)
    }
    
    @ViewBuilder
    var countryDescription: some View {
        VStack {
            
            HStack {
                Text(countryModel.name)
                    .font(.title)
                Spacer()
            }
            
            VStack {
                HStack {
                    Image(systemName: "star")
                        .foregroundStyle(.orange)
                    Text("Capital")
                    Spacer()
                    Text(countryModel.capital)
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
                    Text(countryModel.continent)
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
            
            Text(countryModel.description)
        }
    }
}

#Preview {
    DetailCountryView(countryModel: CountryModel(name: "Argentina", continent: "South America", capital: "Buenos Aires", population: 43_417_000, description_small: "In 2004, I completed two Inuit art buying trips to Iqaluit, the capital of Nunavut, Canada’s newest territory. For both trips, I flew out of Ottawa on Canadian airlines.", description: "As long as humans can think, there will be wars. Wars over such concepts as freedom, honor, dignity, etc.. Wars over territory, greed, power, prejudice, etc.. War is a part of human nature. For example, every human being is prejudiced. If they don’t like some race, nationality or religion, they don’t like short or tall or fat or skinny or smart or not smart or loud or quiet people. Some people don’t like children, some people don’t like old people, some people don’t like people with pets, or people that play their music too loud, or bad drivers, or people that believe in God or people that don’t believe in God.",  image: "https://www.votpusk.ru/country/ctimages/new/AR01.jpg", country_info: CountryInfo(images: [], flag:  "http://flags.fmcdn.net/data/flags/w580/ar.png")))
}

#Preview {
    ContentView(stateManager: AppStateManager.shared)
}
