//
//  TimeDisplayView.swift
//  TimeDisplayView
//
//  Created by Scott Gould on 8/24/21.
//

import SwiftUI

enum TimeDisplayType
{
	case top
	case bottom
}

struct timeDisplayView: View
{
	@AppStorage( SettingsKeys.clockStyle ) var clockStyle: HourRepresentationStyle = .twelveHour
	@EnvironmentObject var schedule: ScheduleViewModel
	
	//	MARK: -Properties
	@Binding var shouldDisplay: Bool
	var dayOfTheWeek: DayOfTheWeek
	var timeDisplayType: TimeDisplayType
	
	var body: some View
	{
		Text( shouldDisplay ? time : " " )
			.font( .footnote )
			.frame( minWidth: 30 )
	}
	
	//	MARK: - Private Properties
	private var currentTimeInterval: TimeInterval
	{
		switch timeDisplayType
		{
			case .top:
				return schedule.dailySchedules[dayOfTheWeek.rawValue].start
				
			case .bottom:
				return schedule.dailySchedules[dayOfTheWeek.rawValue].end
		}
	}
	
	private var time: TimeText
	{
		let tTime =  TimeConverter( timeInterval: currentTimeInterval )
		
		switch clockStyle
		{
			case .twelveHour:
				return tTime.twelveHourTimeRepresentation
				
			case .twentyFourHour:
				return tTime.twentyFourHourTimeRepresentation
		}
	}
}
