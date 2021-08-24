//
//  ContentView.swift
//  Weekly Schedule Selector
//
//  Created by Scott Gould on 8/24/21.
//

import SwiftUI

struct ContentView: View
{
	@StateObject var schedule = ScheduleViewModel()
	
	var body: some View
	{
		VStack
		{
			Text( "Weekly Schedule" )
				.font( .largeTitle )
				.frame( minWidth: 200 )
			
			Text( "Total Hours: \(formattedWeeklyHours)" )
				.padding( .bottom )
			
			ScheduleView()
				.environmentObject( schedule )
		}.padding()
	}
	
	private var formattedWeeklyHours: String
	{
		let tTotalHours = Float( schedule.weeklyDuration ) / 4.0
		return String( format: "%.2f", tTotalHours )
	}
}

struct ContentView_Previews: PreviewProvider
{
	static var previews: some View
	{
		ContentView()
	}
}
