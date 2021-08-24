//
//  TimeConverter.swift
//  TimeConverter
//
//  Created by Scott Gould on 8/24/21.
//

import Foundation

typealias TimeInterval = Int	//	15 minute time interval
typealias TimeText = String //	e.g. "11:45 A" or "14:00"

struct TimeConverter
{
	///	TimeInterval value between 0 and 96 representing the day as a quantity of 15-minute blocks
	let timeInterval: TimeInterval
	
	var twelveHourTimeRepresentation: String
	{
		return self.hoursAndMinutes.twelveHourRepresentation
	}
	
	var twentyFourHourTimeRepresentation: String
	{
		return self.hoursAndMinutes.twentyFourHourRepresentation
	}
	
	//	MARK: - Initialization
	init( timeInterval theTimeInterval: TimeInterval )
	{
		self.timeInterval = theTimeInterval
	}
	
	init( position thePosition: CGFloat, totalLength theTotalLength: CGFloat, intervalsPerDay theIntervalsPerDay: Int )
	{
		let tSnappingCalculator = SnappingCalculator( totalLength: theTotalLength, divisionCount: theIntervalsPerDay )
		self.timeInterval = tSnappingCalculator.integerValueFor( proposedPosition: thePosition )
	}
	
	
	//	MARK: - Private Properties
	private var hoursAndMinutes: TimeInHoursAndMinutes
	{
		let tHours = timeInterval / 4
		let tMinutes = timeInterval % 4 * 15
		
		return TimeInHoursAndMinutes( hour: tHours, minute: tMinutes )
	}
}

