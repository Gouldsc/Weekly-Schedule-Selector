//
//  DayColumnView.swift
//  DayColumnView
//
//  Created by Scott Gould on 8/24/21.
//

import SwiftUI

struct DayColumnView: View
{
	@EnvironmentObject var schedule: ScheduleViewModel
	
	let dayOfTheWeek: DayOfTheWeek
	let dayAbbreviation: String
	
	var body: some View
	{
		VStack
		{
			Text( dayAbbreviation )
				.font( .largeTitle )
			Spacer()
			DayRangeSliderView( totalHeight: 96 * 4 - 12,
								dayOfTheWeek: dayOfTheWeek )
				.environmentObject( schedule )
		}
	}
}
