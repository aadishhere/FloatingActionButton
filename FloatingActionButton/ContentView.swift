//
//  ContentView.swift
//  FloatingActionButton
//
//  Created by Aadish Jain on 14/05/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isExpanded = false

    var body: some View {
        ZStack {
            if isExpanded {
                Color.primary.opacity(0.09)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isExpanded = false
                        }
                    }
            }

            // MARK: Floating Button Options
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 16) {
                        if isExpanded {
                            FloatingActionOption(
                                title: "Report Issue",
                                icon: "exclamationmark.bubble",
                                delay: 0.05
                            ) {
                                print("Report Issue tapped")
                            }

                            FloatingActionOption(
                                title: "Schedule Meeting",
                                icon: "text.bubble.badge.clock",
                                delay: 0.1
                            ) {
                                print("Schedule Meeting tapped")
                            }

                            FloatingActionOption(
                                title: "Request CallBack",
                                icon: "phone.arrow.down.left",
                                delay: 0.15
                            ) {
                                print("Request CallBack tapped")
                            }
                        }

                        // MARK: Engage Button
                        Button(action: {
                            withAnimation(.spring()) {
                                isExpanded.toggle()
                            }
                        }) {
                            Image(systemName: isExpanded ? "xmark" : "plus")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.blue)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 40)
                }
            }
        }
        .animation(.easeInOut, value: isExpanded)
    }
}

struct FloatingActionOption: View {
    let title: String
    let icon: String
    let delay: Double
    let action: () -> Void

    @State private var isVisible = false

    var body: some View {
        Button(action: {
            action()
        }) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.blue)
                    .clipShape(Circle())

                Text(title)
                    .font(.body)
                    .foregroundColor(.primary)

                Spacer(minLength: 0)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .frame(maxWidth: 220, alignment: .leading)
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
            .shadow(radius: 4)
            .opacity(isVisible ? 1 : 0)
            .offset(y: isVisible ? 0 : 20)
            .onAppear {
                withAnimation(.easeOut.delay(delay)) {
                    isVisible = true
                }
            }
            .onDisappear {
                isVisible = false
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ContentView()
}
