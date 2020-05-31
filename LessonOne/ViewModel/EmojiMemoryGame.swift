//
//  EmojiMemoryGame.swift
//  LessonOne
//
//  Created by Stanislav on 31.05.2020.
//  Copyright © 2020 Stanislav Kozlov. All rights reserved.
//

import SwiftUI

final class EmojiMemoryGame
{
	static var emojis = ["🤡", "💍", "👑", "💅🏻", "☠️", "👿", "👺", "🐍", "🦀", "🐸", "🦜", "🦔", "🐠", "🦕", "⚡️", "🌊", "🍅", "🍔", "🍕"]
	private var model: MemoryGame<String>

	// MARK: - Access to the model
	var cards: Array<MemoryGame<String>.Card> {
		model.cards
	}

	init() {
		self.model = EmojiMemoryGame.createMemoryGame()
	}

	// MARK: - Intents
	func chooseCard(card: MemoryGame<String>.Card) {
		model.choose(card: card)
	}
}

private extension EmojiMemoryGame
{
	static func createMemoryGame() -> MemoryGame<String> {

		let numberOfPairs = Int.random(in: 2...5)
		return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) { _ in
			let randomIndex = Int.random(in: 0..<emojis.count)
			return emojis.remove(at: randomIndex)
		}
	}
}
