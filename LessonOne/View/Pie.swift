//
//  Pie.swift
//  LessonOne
//
//  Created by Stanislav on 21.06.2020.
//  Copyright © 2020 Stanislav Kozlov. All rights reserved.
//

import SwiftUI

struct Pie: Shape
{
	var startAngle: Angle
	var endAngle: Angle
	var clockwise = false

	func path(in rect: CGRect) -> Path {
		var path = Path()
		let center = CGPoint(x: rect.width / 2, y: rect.height / 2 )
		let radius = min(rect.width, rect.height) / 2
		let start = CGPoint(
			x: center.x + radius * cos(CGFloat(startAngle.radians)),
			y: center.y + radius * sin(CGFloat(startAngle.radians))
			)

		path.move(to: center)
		path.addLine(to: start)
		path.addArc(center: center,
					radius: radius,
					startAngle: startAngle,
					endAngle: endAngle,
					clockwise: clockwise)
		path.addLine(to: center)
		return path
	}
}
