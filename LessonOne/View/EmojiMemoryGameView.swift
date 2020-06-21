//
//  EmojiMemoryGameView.swift
//  LessonOne
//
//  Created by Stanislav on 31.05.2020.
//  Copyright © 2020 Stanislav Kozlov. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View
{
	@ObservedObject var viewModel: EmojiMemoryGame

	var body: some View {
		VStack {
			Text(viewModel.themeName)
				.font(.largeTitle)
				.foregroundColor(self.viewModel.color)
			Grid(viewModel.cards) { card in
				CardView(card: card)
					.onTapGesture {
						self.viewModel.chooseCard(card: card)
					}
					.padding(5)
			}
			.padding()
			.foregroundColor(self.viewModel.color)

			Button(action: { self.viewModel.startGame() }, label: { Text("New game") })
		}
	}
}

struct CardView: View
{
	var card: MemoryGame<String>.Card

	var body: some View {
		GeometryReader { geometry in
			self.body(for: geometry.size)
		}
	}

	private func body(for size: CGSize) -> some View {
		ZStack {
			if self.card.isFaceUp {
				RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
				RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
				Text(self.card.content)
			}
			else {
				if self.card.isMatched == false {
					RoundedRectangle(cornerRadius: cornerRadius).fill()
				}
			}
		}
		.font(Font.system(size: fontSize(for: size)))
	}

	// MARK: - Drawing constants
	private let cornerRadius: CGFloat = 10.0
	private let edgeLineWidth: CGFloat = 3

	func fontSize(for size: CGSize) -> CGFloat {
		return min(size.width, size.height) * 0.75
	}
}

struct ContentView_Previews: PreviewProvider
{
	static var previews: some View {
		EmojiMemoryGameView(viewModel: EmojiMemoryGame())
	}
}
