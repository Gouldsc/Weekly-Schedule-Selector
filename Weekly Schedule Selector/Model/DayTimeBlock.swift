//
//  DayTimeBlock.swift
//  DayTimeBlock
//
//  Created by Scott Gould on 8/24/21.
//

import Foundation

enum DayOfTheWeek: Int
{
	case Sunday = 0
	case Monday = 1
	case Tuesday = 2
	case Wednessday = 3
	case Thursday = 4
	case Friday = 5
	case Saturday = 6
}

struct DayTimeBlock
{
	var dayOfTheWeek: DayOfTheWeek
	var start: TimeInterval
	var end: TimeInterval
	var isActive = false
	
	var duration: TimeInterval
	{
		return end - start
	}
}
