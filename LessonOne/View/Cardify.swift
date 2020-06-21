//
//  Cardify.swift
//  LessonOne
//
//  Created by Stanislav on 21.06.2020.
//  Copyright © 2020 Stanislav Kozlov. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier
{
	var isFaceUp: Bool
	// MARK: - Drawing constants
	private let cornerRadius: CGFloat = 10.0
	private let edgeLineWidth: CGFloat = 3

	func body(content: Content) -> some View {
		ZStack {
			if self.isFaceUp {
				RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
				RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
				content
			}
			else {
				RoundedRectangle(cornerRadius: cornerRadius).fill()
			}
		}
	}
}

extension View
{
	func cardify(isFaceUp: Bool) -> some View {
		self.modifier(Cardify(isFaceUp: isFaceUp))
	}
}
