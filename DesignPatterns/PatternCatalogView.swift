//
//  PatternCatalogView.swift
//  DesignPatterns
//
//  Created Gabriel Alejandro Briseño Alvarez on 08/02/26.
//  Copyright © 2026 ___ORGANIZATIONNAME___. All rights reserved.
//  Generated using MVVM Module Generator by Gabriel Briseño
//

import SwiftUI

struct PatternCatalogView: View {
    var viewModel: PatternCatalogViewModel!

    var body: some View {
        NavigationStack {
            List(viewModel.sections) { section in
                Section {
                    ForEach(section.topics, id: \.titleKey) { topic in
                        Text(LocalizedStringKey(topic.titleKey))
                    }
                } header: {
                    Text(LocalizedStringKey(section.title))
                } footer: {
                    Text("about.attribution.message")
                        .font(.footnote)
                }
            }
            .navigationTitle("patterncatalog.title")
        }
    }
}

#Preview {
    PatternCatalogView()
}
