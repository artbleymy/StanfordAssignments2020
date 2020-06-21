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

	@ViewBuilder
	private func body(for size: CGSize) -> some View {
		if card.isFaceUp || card.isMatched == false {
			ZStack {
				Pie(startAngle: Angle.degrees(30), endAngle: Angle.degrees(270))
					.padding(5)
					.opacity(0.3)
				Text(self.card.content)
			}
			.cardify(isFaceUp: card.isFaceUp)
			.font(Font.system(size: fontSize(for: size)))
		}
	}

	func fontSize(for size: CGSize) -> CGFloat {
		return min(size.width, size.height) * 0.7
	}
}

struct ContentView_Previews: PreviewProvider
{
	static var previews: some View {
		let game = EmojiMemoryGame()
		game.chooseCard(card: game.cards[0])
		return EmojiMemoryGameView(viewModel: game)
	}
}
