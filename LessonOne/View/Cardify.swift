//
//  Cardify.swift
//  LessonOne
//
//  Created by Stanislav on 21.06.2020.
//  Copyright © 2020 Stanislav Kozlov. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier
{
	var rotation: Double

	var isFaceUp: Bool {
		rotation < 90
	}

	var animatableData: Double {
		get {
			return rotation
		}
		set {
			rotation = newValue
		}
	}

	init(isFaceUp: Bool) {
		rotation = isFaceUp ? 0 : 180
	}
	// MARK: - Drawing constants
	private let cornerRadius: CGFloat = 10.0
	private let edgeLineWidth: CGFloat = 3

	func body(content: Content) -> some View {
		ZStack {
			Group {
				RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
				RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
				content
			}
				.opacity(isFaceUp ? 1 : 0)

			RoundedRectangle(cornerRadius: cornerRadius).fill()
				.opacity(isFaceUp ? 0 : 1)
		}
		.rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
	}
}

extension View
{
	func cardify(isFaceUp: Bool) -> some View {
		self.modifier(Cardify(isFaceUp: isFaceUp))
	}
}
