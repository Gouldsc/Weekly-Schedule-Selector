//
//  ScheduleView.swift
//  ScheduleView
//
//  Created by Scott Gould on 8/24/21.
//

import SwiftUI

struct ScheduleView: View
{
	@EnvironmentObject var schedule: ScheduleViewModel
	
	let daysOfTheWeekAbbreviations: [DayOfTheWeek : String] = [.Sunday : "Su",
															   .Monday : "M",
															   .Tuesday : "Tu",
															   .Wednessday : "W",
															   .Thursday : "Th",
															   .Friday : "F",
															   .Saturday : "S"]
	let daysOfTheWeekKeys = [DayOfTheWeek.Sunday,
							 DayOfTheWeek.Monday,
							 DayOfTheWeek.Tuesday,
							 DayOfTheWeek.Wednessday,
							 DayOfTheWeek.Thursday,
							 DayOfTheWeek.Friday,
							 DayOfTheWeek.Saturday]
	
	var body: some View
	{
		HStack( alignment: .center )
		{
			ForEach( daysOfTheWeekKeys, id: \.self)
			{
				tDayKey in
				DayColumnView( dayOfTheWeek: tDayKey, dayAbbreviation: daysOfTheWeekAbbreviations[tDayKey]! )
					.environmentObject( schedule )
				
			}.frame( width: 40, height: 500, alignment: .center )
		}
	}
}
