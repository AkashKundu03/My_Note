import SwiftUI

struct EmailTemplateSheet: View {
    var onContinue: () -> Void

    private let tileW: CGFloat = 96
    private let tileH: CGFloat = 78
    private let overlapFraction: CGFloat = 0.20

    var body: some View {
        VStack(spacing: 18) {
            // (Grabber removed; system drag indicator is provided by the .sheet modifier)

            // Zig-zag: Envelope / Paperplane / Tray
            HStack(spacing: -(tileW * overlapFraction)) {
                tile {
                    Image(systemName: "envelope.fill")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.blue)
                }
                .rotationEffect(.degrees(8))
                .zIndex(1)

                tile {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.indigo)
                }
                .rotationEffect(.degrees(-8))
                .zIndex(2)

                tile {
                    Image(systemName: "tray.full.fill")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.teal)
                }
                .rotationEffect(.degrees(8))
                .zIndex(3)
            }
            .frame(height: tileH)
            .padding(.top,34)

            Text("Email Template").font(.title.bold())

            Text("Turn your note into a clean email draft with one tap.")
                .font(.callout)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 28)

            VStack(alignment: .leading, spacing: 18) {
                BulletRow(icon: "envelope.badge", title: "One-tap drafts",
                          body: "Create a ready-to-send email from your note.")
                BulletRow(icon: "doc.text.fill", title: "Templates",
                          body: "Keep tone & structure consistent across mails.")
                BulletRow(icon: "bolt.fill", title: "Fast follow-ups",
                          body: "Generate polite nudges right from a note.")
            }
            .padding(.horizontal, 24)

            Spacer(minLength: 0)

            Button(action: onContinue) {
                Text("Continue")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(RoundedRectangle(cornerRadius: 14).fill(Color.accentColor))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
            }
            .padding(.bottom, 16)
        }
    }

    @ViewBuilder
    private func tile<Glyph: View>(@ViewBuilder _ glyph: () -> Glyph) -> some View {
        RoundedRectangle(cornerRadius: 22, style: .continuous)
            .fill(.white)
            .frame(width: tileW, height: tileH)
            .shadow(color: .black.opacity(0.12), radius: 8, y: 5)
            .overlay(glyph())
    }
}
