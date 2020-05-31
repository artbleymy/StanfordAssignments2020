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
	var body: some View {
		VStack {
			ForEach(0..<4) { _ in
				HStack {
					ForEach(0..<4) {index in
						CardView(isFaceUp: index % 2 == 0)
					}
				}
			}
		}
			.padding()
			.foregroundColor(Color.orange)
			.font(Font.largeTitle)
	}
}

struct CardView: View
{
	var isFaceUp: Bool

	var body: some View {
		ZStack {
			if isFaceUp {
				RoundedRectangle(cornerRadius: 10.0)
					.fill(Color.white)
				RoundedRectangle(cornerRadius: 10.0)
					.stroke(lineWidth: 3)
				Text("👻")
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
		ContentView()
	}
}
