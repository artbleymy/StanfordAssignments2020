//
//  EmojiMemoryGame.swift
//  LessonOne
//
//  Created by Stanislav on 31.05.2020.
//  Copyright © 2020 Stanislav Kozlov. All rights reserved.
//

import SwiftUI

final class EmojiMemoryGame: ObservableObject
{
	private static let themes = [
		Theme(name: "Halloween", emojiSet: ["☠️", "🎃", "👻", "👽", "🤡", "👺", "👾"], color: Color.orange),
		Theme(name: "Sport", emojiSet: ["🏀", "⚽️", "⛸", "🥋", "🥊", "🏆", "🏄", "🪂", "🏹"], color: Color.blue),
		Theme(name: "Food", emojiSet: ["🍎", "🍐", "🍌", "🍉", "🍆", "🍅", "🍇", "🥐", "🍗", "🍒"], color: Color.green),
		Theme(name: "Transport", emojiSet: ["🚜", "🚓", "🛳", "🎠", "🚁", "🛫", "🛴", "🚗", "🚑", "🚀"], color: Color.red),
		Theme(name: "Gadgets", emojiSet: ["💻", "📱", "💿", "📷", "📺", "🔦", "🕹", "🖨", "⌚️"], color: Color.gray),
		Theme(name: "Flags", emojiSet: ["🇬🇪", "🇬🇷", "🇨🇳", "🇨🇦", "🇮🇸", "🇮🇱", "🇷🇺", "🇷🇪", "🇯🇵", "🇫🇮", "🇬🇧", "🇧🇷"], color: Color.yellow),
	]

	@Published private var model: MemoryGame<String>

	// MARK: - Access to the model
	var cards: Array<MemoryGame<String>.Card> {
		self.model.cards
	}

	var color: Color {
		self.model.color
	}

	var themeName: String {
		self.model.themeName
	}

	init() {
		self.model = EmojiMemoryGame.createMemoryGame()
	}

	func startGame() {
		self.model = EmojiMemoryGame.createMemoryGame()
	}
	// MARK: - Intents
	func chooseCard(card: MemoryGame<String>.Card) {
		model.choose(card: card)
	}

	static func createMemoryGame() -> MemoryGame<String> {

		let numberOfPairs = Int.random(in: 2...7)
		let theme = themes[Int.random(in: 0..<themes.count)]
		var emojisForGame = theme.emojiSet

		return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs, color: theme.color, themeName: theme.name) { _ in
			let randomIndex = Int.random(in: 0..<emojisForGame.count)
			return emojisForGame.remove(at: randomIndex)
		}
	}
}
