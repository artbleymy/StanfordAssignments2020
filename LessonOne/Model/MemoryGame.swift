//
//  MemoryGame.swift
//  LessonOne
//
//  Created by Stanislav on 31.05.2020.
//  Copyright © 2020 Stanislav Kozlov. All rights reserved.
//

import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable
{
	let color: Color
	let themeName: String
	var cards: [Card]
	var indexOfTheOneAndOnlyFaceUpCard: Int? {
		get {
			let indicies = self.cards.indices.filter{ self.cards[$0].isFaceUp }
			return indicies.count == 1 ? indicies.first : nil
		}
		set {
			for index in self.cards.indices {
				self.cards[index].isFaceUp = (index == newValue)
			}
		}
	}

	struct Card: Identifiable
	{
		var id: Int
		var isFaceUp: Bool = false
		var isMatched: Bool = false
		var content: CardContent
	}

	init(numberOfPairsOfCards: Int,
		 color: Color,
		 themeName: String,
		 cardContentFactory: (Int) -> CardContent) {
		self.cards = [Card]()
		self.color = color
		self.themeName = themeName
		for pairIndex in 0..<numberOfPairsOfCards {
			let content = cardContentFactory(pairIndex)
			self.cards.append(Card(id: pairIndex * 2, content: content))
			self.cards.append(Card(id: pairIndex * 2 + 1, content: content))
		}
		self.cards.shuffle()
	}

	mutating func choose(card: Card) {
		print("Choosen card: \(card)")
		let index = self.cards.firstIndex { $0.id == card.id }
		if let chosenIndex = index,
			cards[chosenIndex].isFaceUp == false,
			cards[chosenIndex].isMatched == false {
			if let potentialMatchIndex = self.indexOfTheOneAndOnlyFaceUpCard {
				if cards[chosenIndex].content == cards[potentialMatchIndex].content {
					cards[potentialMatchIndex].isMatched = true
					cards[chosenIndex].isMatched = true
				}
				self.cards[chosenIndex].isFaceUp = true
			}
			else {
				self.indexOfTheOneAndOnlyFaceUpCard = chosenIndex
			}
		}
	}
}
