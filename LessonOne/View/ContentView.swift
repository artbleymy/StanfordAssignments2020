//
//  ContentView.swift
//  LessonOne
//
//  Created by Stanislav on 31.05.2020.
//  Copyright © 2020 Stanislav Kozlov. All rights reserved.
//

import SwiftUI

struct ContentView: View
{
	var viewModel: EmojiMemoryGame

	var body: some View {
		HStack {
			ForEach(viewModel.cards) { card in
				CardView(card: card)
					.onTapGesture {
						self.viewModel.chooseCard(card: card)
					}
			}
		}
			.padding()
			.foregroundColor(Color.orange)
		.font( viewModel.cards.count < 5 ? Font.largeTitle : Font.body )
	}
}

struct CardView: View
{
	var card: MemoryGame<String>.Card

	var body: some View {
		ZStack {
			if card.isFaceUp {
				RoundedRectangle(cornerRadius: 10.0)
					.fill(Color.white)
					.aspectRatio(2 / 3, contentMode: .fit)
				RoundedRectangle(cornerRadius: 10.0)
					.stroke(lineWidth: 3)
					.aspectRatio(2 / 3, contentMode: .fit)
				Text(card.content)
			}
			else {
				RoundedRectangle(cornerRadius: 10.0)
				.fill()
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider
{
	static var previews: some View {
		ContentView(viewModel: EmojiMemoryGame())
	}
}
