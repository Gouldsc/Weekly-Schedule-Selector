//
//  SnappingCalculator.swift
//  SnappingCalculator
//
//  Created by Scott Gould on 8/24/21.
//

import Foundation

struct SnappingCalculator
{
	var totalLength: CGFloat
	var divisionCount: Int
	private var divisionIncrement: CGFloat
	{
		return totalLength / CGFloat( divisionCount )
	}
	
	func positionFor( proposedPosition theProposedPosition: CGFloat ) -> CGFloat
	{
		let tDividedPosition = theProposedPosition / divisionIncrement
		return tDividedPosition.rounded( .toNearestOrAwayFromZero ) * divisionIncrement
	}
	
	func integerValueFor( proposedPosition theProposedPosition: CGFloat ) -> Int
	{
		let tDividedPosition = theProposedPosition / divisionIncrement
		return Int( tDividedPosition.rounded( .toNearestOrAwayFromZero ) )
	}
}
