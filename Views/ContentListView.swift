//
//  ContentListView.swift
//  MyNoteView
//
//  Created by Akash Kundu on 02/10/25.
//

import SwiftUI

enum ContentKind: String {
    case social = "Social Media"
    case email  = "Email Template"
    case blog   = "Blog"
}

struct ContentListView: View {
    let kind: ContentKind

    private var rows: [(title: String, subtitle: String)] {
        switch kind {
        case .social:
            return Array(repeating: ("Marketing Review",
                                     "Today’s discussion focused on simplifying the cycle."), count: 5)
        case .email:
            return Array(repeating: ("Welcome Email",
                                     "Introduce the product and key value quickly."), count: 5)
        case .blog:
            return Array(repeating: ("Design Notes",
                                     "Turning raw ideas into a clean outline."), count: 5)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section(header: header) {
                    ForEach(rows.indices, id: \.self) { i in
                        NavigationLink {
                            ContentDetailView(title: rows[i].title,
                                              subtitle: rows[i].subtitle)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(rows[i].title).font(.body.weight(.semibold))
                                    Spacer()
                                    Image(systemName: "ellipsis").foregroundStyle(.secondary)
                                }
                                Text(rows[i].subtitle)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Divider().padding(.top, 8)
                            }
                            .padding(.vertical, 6)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Contents")
            .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
    }

    private var header: some View {
        HStack {
            Text("Contents").font(.headline)
            Spacer()
            Button("New Content") { }
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color.accentColor)
        }
    }
}

struct ContentDetailView: View {
    let title: String
    let subtitle: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(title).font(.title2.bold())
                Text(subtitle).foregroundStyle(.secondary)
                Divider().padding(.vertical, 8)
                Text("""
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum vulputate, lectus nec hendrerit faucibus, nunc purus interdum urna, ut efficitur magna ipsum et ante. Praesent et nisl sed mi lacinia bibendum. Integer non dui eu justo facilisis gravida.
""")
                .font(.body)
            }
            .padding(20)
        }
        .navigationTitle("Content")
        .navigationBarTitleDisplayMode(.inline)
    }
}
