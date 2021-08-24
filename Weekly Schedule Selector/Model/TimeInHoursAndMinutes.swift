//
//  TimeInHoursAndMinutes.swift
//  TimeInHoursAndMinutes
//
//  Created by Scott Gould on 8/24/21.
//

import Foundation

struct TimeInHoursAndMinutes
{
	//	Expects hours in range from  0-24
	//	valid minutes are one of these values: (0, 15, 30, 45)
	let hour: Int
	let minute: Int
	
	var twelveHourRepresentation: TimeText
	{
		var rTwelveHourRepresentation: TimeText = minuteRepresentation
		
		switch hour
		{
			case 0:
				rTwelveHourRepresentation = "12:" + rTwelveHourRepresentation + " A"
				
			case _ where hour < 12:
				rTwelveHourRepresentation = "\(hour):" + rTwelveHourRepresentation + " A"
				
			case 12:
				rTwelveHourRepresentation = "\(hour):" + rTwelveHourRepresentation + " P"
				
			case 24:
				rTwelveHourRepresentation = "\(hour - 12):" + rTwelveHourRepresentation + " A"
				
			default:
				rTwelveHourRepresentation = "\(hour - 12):" + rTwelveHourRepresentation + " P"
		}
		return rTwelveHourRepresentation
	}
	
	var twentyFourHourRepresentation: TimeText
	{
		var rTwentyFourHourRepresentation: TimeText = minuteRepresentation
		
		if hour < 10
		{
			rTwentyFourHourRepresentation =  "0\(hour):" + rTwentyFourHourRepresentation
		}
		else
		{
			rTwentyFourHourRepresentation = "\(hour):" + rTwentyFourHourRepresentation
		}
		return rTwentyFourHourRepresentation
	}
	
	private var minuteRepresentation: String
	{
		if minute == 0
		{
			return "0\(minute)"
		}
		else
		{
			return "\(minute)"
		}
	}
}

