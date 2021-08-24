//
//  ScheduleViewModel.swift
//  ScheduleViewModel
//
//  Created by Scott Gould on 8/24/21.
//

import Foundation

class ScheduleViewModel: ObservableObject
{
	@Published var dailySchedules = [DayTimeBlock]()
	
	var weeklyDuration: TimeInterval
	{
		
		var rWeeklyDuration = 0
		
		for tDaySchedule in dailySchedules where tDaySchedule.isActive
		{
			rWeeklyDuration += tDaySchedule.duration
		}
		return rWeeklyDuration
	}
	
	init()
	{
		let tDaysOfTheWeek: [DayOfTheWeek] = [ .Sunday,
											   .Monday,
											   .Tuesday,
											   .Wednessday,
											   .Thursday,
											   .Friday,
											   .Saturday]
		
		var tDaySchedule = [DayTimeBlock]()
		for tDay in tDaysOfTheWeek
		{
			tDaySchedule.append( DayTimeBlock( dayOfTheWeek: tDay, start: 0, end: 0, isActive: false ) )
		}
		
		dailySchedules = tDaySchedule
	}
}
