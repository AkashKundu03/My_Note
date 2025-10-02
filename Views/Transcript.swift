import SwiftUI

struct TranscriptView: View {
    struct Line: Identifiable {
        let id = UUID()
        let time: String
        let text: String
    }

    private let lines: [Line] = [
        .init(time: "0:01", text: "Hey, Doctor, uh, so I just created a, uh, diagram on how things should work. I just reviewed the, um, uh, design."),
        .init(time: "0:15", text: "Uh, it looks good, uh, no doubt. Uh, but it doesn't, uh, so far what I've seen. I think there's a communication gap."),
        .init(time: "0:24", text: "And what's, what has been implemented and what we want..."),
        .init(time: "0:45", text: "They look at a good animation type of a small live caption with single word at a time."),
        .init(time: "0:45", text: "Like how I'm speaking..."),
        .init(time: "1:04", text: "They can edit the summary action items..."),
        .init(time: "1:21", text: "They can create reminders and events..."),
        .init(time: "1:40", text: "And, and we’ll see the same with the action ...")
    ]

    var body: some View {
        ScrollView {
            SectionHeader(title: "Transcript")

            LazyVStack(alignment: .leading, spacing: 18) {
                ForEach(lines) { line in
                    HStack(alignment: .top, spacing: 14) {
                        Text(line.time)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Color(.systemBlue))
                            .frame(width: 44, alignment: .leading)
                        Text(line.text).font(.body)
                    }
                    Divider()
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 28)
        }
    }
}
