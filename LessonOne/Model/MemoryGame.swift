//
//  MemoryGame.swift
//  LessonOne
//
//  Created by Stanislav on 31.05.2020.
//  Copyright © 2020 Stanislav Kozlov. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent>
{
	struct Card: Identifiable
	{
		var id: Int

		var isFaceUp: Bool = true
		var isMatched: Bool = false
		var content: CardContent

		mutating func choose() {
			self.isFaceUp.toggle()
		}
	}

	var cards: [Card]

	init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
		cards = [Card]()
		for pairIndex in 0..<numberOfPairsOfCards {
			let content = cardContentFactory(pairIndex)
			cards.append(Card(id: pairIndex * 2, content: content))
			cards.append(Card(id: pairIndex * 2 + 1, content: content))
		}
		cards.shuffle()
	}

	func choose(card: Card) {
		print("Choosen card: \(card)")
	}
}
