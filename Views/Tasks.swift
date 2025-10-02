import SwiftUI

struct TasksView: View {
    struct TaskItem: Identifiable {
        let id = UUID()
        let title: String
        let subtitle: String
        var isDone: Bool
        let priority: PriorityChip.Level
    }

    @State private var tasks: [TaskItem] = [
        .init(title: "Marketing Review", subtitle: "Today’s discussion focused on simplifying the cycle.", isDone: false, priority: .high),
        .init(title: "Marketing Review", subtitle: "Today’s discussion focused on simplifying the cycle.", isDone: false, priority: .high),
        .init(title: "Marketing Review", subtitle: "Today’s discussion focused on simplifying the cycle.", isDone: false, priority: .low),
        .init(title: "Marketing Review", subtitle: "Today’s discussion focused on simplifying the cycle.", isDone: false, priority: .low),
        .init(title: "Marketing Review", subtitle: "Today’s discussion focused on simplifying the cycle.", isDone: false, priority: .low),
        .init(title: "Marketing Review", subtitle: "Today’s discussion focused on simplifying the cycle.", isDone: false, priority: .low),
    ]

    var body: some View {
        ScrollView {
            SectionHeader(
                title: "Tasks",
                trailing: AnyView(Button("Add Task", action: {}).font(.subheadline))
            )

            VStack(spacing: 18) {
                ForEach(tasks.indices, id: \.self) { i in
                    TaskRow(item: tasks[i]) { tasks[i].isDone.toggle() }
                    Divider().padding(.leading, 34)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 24)
        }
    }
}

private struct TaskRow: View {
    let item: TasksView.TaskItem
    let toggle: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Selectable round control
            Button(action: toggle) {
                ZStack {
                    Circle()
                        .strokeBorder(item.isDone ? Color.accentColor : Color(.tertiaryLabel), lineWidth: 2)
                        .background(Circle().fill(item.isDone ? Color.accentColor : .clear))
                    if item.isDone {
                        Image(systemName: "checkmark")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }
                .frame(width: 22, height: 22)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(item.title).font(.body.weight(.semibold))
                    Spacer()
                    Button(action: {}) { Image(systemName: "ellipsis") }.tint(.secondary)
                }
                Text(item.subtitle).font(.subheadline).foregroundStyle(.secondary)
                PriorityChip(level: item.priority)
            }
        }
    }
}
