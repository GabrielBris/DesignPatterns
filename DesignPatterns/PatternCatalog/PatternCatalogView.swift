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
    var viewModel: PatternCatalogViewModelProtocol!

    var body: some View {
        NavigationStack {
            VStack {
                List(viewModel.sections) { section in
                    Section {
                        ForEach(section.topics, id: \.titleKey) { topic in
                            PatternCatalogCell(title: topic.titleKey, description: topic.descriptionKey) {
                                viewModel.tryMeButtonTapped(at: topic)
                            }
                        }
                    } header: {
                        Text(LocalizedStringKey(section.title))
                    }
                }
                .navigationTitle("patterncatalog.title")
            }
            Text("about.attribution.message")
                .font(.caption2)
                .padding(8)
        }
    }
}

private struct PatternCatalogCell: View {
    let title: String
    let description: String
    let onButtonTap: () -> Void
    
    var body: some View {
        DisclosureGroup(LocalizedStringKey(title)) {
            VStack {
                Text(LocalizedStringKey(description))
                HStack {
                    Spacer()
                    Button("patterncatalog.cell.trymebutton") {
                        onButtonTap()
                    }
                    .buttonStyle(.automatic)
                }
            }
        }
    }
}

#Preview {
    PatternCatalogView()
}
