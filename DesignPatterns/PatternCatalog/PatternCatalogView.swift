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
                            PatternCatalogCell(topic: topic, description: section.description) {
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
    let topic: any PatternItemKeys
    var description: String = ""
    let onButtonTap: () -> Void
    
    var body: some View {
        DisclosureGroup(LocalizedStringKey(topic.titleKey)) {
            if topic.subtopics.isEmpty {
                PatternDescriptionView(description: topic.descriptionKey, onButtonTap: onButtonTap)
            } else {
                SubtopicPatternDescriptionView(topic: topic, description: description, onButtonTap: onButtonTap)
            }
        }
    }
}

private struct SubtopicPatternDescriptionView: View {
    let topic: any PatternItemKeys
    let description: String
    let onButtonTap: () -> Void
    
    var body: some View {
        Text(LocalizedStringKey(description))
        ForEach(topic.subtopics, id: \.titleKey) { subtopic in
            DisclosureGroup(LocalizedStringKey(subtopic.titleKey)) {
                PatternDescriptionView(description: subtopic.descriptionKey, onButtonTap: onButtonTap)
            }
        }
    }
}

private struct PatternDescriptionView: View {
    let description: String
    let onButtonTap: () -> Void

    var body: some View {
        VStack {
            Text(LocalizedStringKey(description))
            HStack {
                Spacer()
                Button("patterncatalog.cell.trymebutton") {
                    onButtonTap()
                }
                .buttonStyle(.automatic)
                .foregroundStyle(Color.green)
            }
        }
    }
}

#Preview {
    PatternCatalogView()
}
