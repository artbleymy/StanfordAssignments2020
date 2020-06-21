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
	private(set) var cards: [Card]

	private var indexOfTheOneAndOnlyFaceUpCard: Int? {
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
		var isFaceUp: Bool = false {
			didSet {
				if isFaceUp {
					print("Start")
					startUsingBonusTime()
				}
				else {
					print("Finish")
					stopUsingBonusTime()
				}
			}
		}
		var isMatched: Bool = false {
			didSet {
				stopUsingBonusTime()
			}
		}

		var content: CardContent

		var bonusTimeLimit: TimeInterval = 6

		private var faceUpTime: TimeInterval {
			if let lastFaceUpDate = self.lastFaceUpDate {
				return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
			}
			else {
				return pastFaceUpTime
			}
		}

		var lastFaceUpDate: Date?
		var pastFaceUpTime: TimeInterval = 0

		var bonusTimeRemaining: TimeInterval {
			max(0, bonusTimeLimit - faceUpTime)
		}

		var bonusRemaining: Double {
			(bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
		}

		var hasEarnedBonus: Bool {
			self.isMatched && self.bonusTimeRemaining > 0
		}

		var isConsumingBonusTime: Bool {
			self.isFaceUp && self.isMatched == false && self.bonusTimeRemaining > 0
		}

		private mutating func startUsingBonusTime() {
			if isConsumingBonusTime, lastFaceUpDate == nil {
				self.lastFaceUpDate = Date()
			}
		}

		private mutating func stopUsingBonusTime() {
			self.pastFaceUpTime = self.faceUpTime
			self.lastFaceUpDate = nil
		}
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
