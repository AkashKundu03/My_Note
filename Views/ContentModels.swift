import Foundation

enum ContentKind { case social, email, blog }

struct ContentItem: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var subtitle: String
}

extension Array where Element == ContentItem {
    static let mock: [ContentItem] = [
        .init(title: "Marketing Review", subtitle: "Today’s discussion focused on simplifying the cycle."),
        .init(title: "Marketing Review", subtitle: "Today’s discussion focused on simplifying the cycle."),
        .init(title: "Marketing Review", subtitle: "Today’s discussion focused on simplifying the cycle."),
        .init(title: "Marketing Review", subtitle: "Today’s discussion focused on simplifying the cycle."),
        .init(title: "Marketing Review", subtitle: "Today’s discussion focused on simplifying the cycle.")
    ]
}
//
//  ContentModels.swift
//  MyNoteView
//
//  Created by Akash Kundu on 02/10/25.
//

