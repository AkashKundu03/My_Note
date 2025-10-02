//
//  MyNoteModels.swift
//  MyNoteView
//
//  Created by Akash Kundu on 02/10/25.
import Foundation

enum MNContentKind: String, CaseIterable {
    case social = "Social Media"
    case email  = "Email Template"
    case blog   = "Blog"
}

struct MNContentItem: Identifiable, Equatable {
    let id: UUID
    var kind: MNContentKind
    var channel: String           // e.g. "Instagram"
    var title: String
    var subtitle: String
    var body: String

    init(id: UUID = UUID(),
         kind: MNContentKind,
         channel: String,
         title: String,
         subtitle: String,
         body: String) {
        self.id = id
        self.kind = kind
        self.channel = channel
        self.title = title
        self.subtitle = subtitle
        self.body = body
    }
}
