//
//  SettingsView.swift
//  SettingsView
//
//  Created by Scott Gould on 8/24/21.
//

import SwiftUI

enum HourRepresentationStyle: String
{
	case twelveHour = "twelveHour"
	case twentyFourHour = "twentyFourHour"
}

enum SettingsKeys
{
	static let clockStyle = "clockStyle"
	static let selectedColor = "selectedColor"
	static let scheduleStart = "scheduleStart"
	static let scheduleEnd = "scheduleEnd"
}

struct SettingsView: View
{
	@AppStorage( SettingsKeys.clockStyle ) var clockStyle: HourRepresentationStyle = .twelveHour
	@AppStorage( SettingsKeys.selectedColor ) var selectedColor: Color = Color( #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1) )
	@AppStorage( SettingsKeys.scheduleStart ) var scheduleStart: TimeInterval = 30
	@AppStorage( SettingsKeys.scheduleEnd ) var scheduleEnd: TimeInterval = 50
	
	
	@State private var isTwentyFourHourTimeStyle = false
	@State private var startTimeSliderValue: Double = 0.0
	@State private var endTimeSliderValue: Double = 0.0
	
	
	var body: some View
	{
		Form
		{
			ColorPicker( "Slider Color:", selection: $selectedColor )
			
			Toggle( "Use a 24-hour clock", isOn: $isTwentyFourHourTimeStyle )
				.onChange( of: self.isTwentyFourHourTimeStyle, perform:
							{
					updateTimeSetting( to: $0 )
				} )
			
			Text( "Set beginning and end times for the week:" )
				.font( .headline )
				.padding(.top)
			ScheduleRangeSliderView( totalWidth: 96 * 4 )
				.frame( alignment: .bottomLeading )
				.offset( x: -90, y: 0 )
		}
		.frame( minWidth: 250, minHeight: 150 )
		.padding()
	}
	
	private func updateTimeSetting( to theSetting: Bool  )
	{
		switch isTwentyFourHourTimeStyle
		{
			case true:
				clockStyle = .twentyFourHour
				
			case false:
				clockStyle = .twelveHour
		}
	}
}

struct SettingsView_Previews: PreviewProvider
{
	static var previews: some View
	{
		SettingsView()
	}
}
