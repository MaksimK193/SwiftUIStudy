//
//  CountriesView.swift
//  SwiftUIStudy
//
//  Created by USER on 17.01.2024.
//

import SwiftUI

struct CountriesView: View {
    var body: some View {
        NavigationStack {
            List() {
                ForEach(0..<10) { i in
                    NavigationLink(destination: {
                        
                    }, label: {
                        CountriesCellView()
                    })
                }
            }
            .listStyle(.plain)
            .navigationTitle("Countries")
        }
    }
}

struct CountriesCellView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "photo")
                    .frame(width: 54, height: 36)
                VStack(alignment: .leading) {
                    Text("Argentina")
                    Text("Beunos Aires")
                }
            }
            Text("In 2004, I completed two Inuit art buying trips to Iqaluit, the capital of Nunavut, Canada’s newest territory. For both trips, I flew out of Ottawa on Canadian airlines.")
        }
    }
}

#Preview {
    CountriesView()
}
