//
//  DayRangeSliderView.swift
//  DayRangeSliderView
//
//  Created by Scott Gould on 8/24/21.
//

import SwiftUI

struct DayRangeSliderView: View
{
	@EnvironmentObject var schedule: ScheduleViewModel
	
	//	MARK: - Properties
	@AppStorage( SettingsKeys.selectedColor ) private(set) var selectedColor: Color = Color( #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)  )
	@AppStorage( SettingsKeys.scheduleStart ) private(set) var scheduleStart: TimeInterval = 0
	@AppStorage( SettingsKeys.scheduleEnd ) private(set) var scheduleEnd: TimeInterval = 96
	
	@State var handle1Position = CGPoint( x: 0, y: 124 )
	@State var handle2Position = CGPoint( x: 0, y: 264 )
	@State var totalHeight: CGFloat
	let dayOfTheWeek: DayOfTheWeek
	
	var body: some View
	{
		VStack
		{
			addRemoveButton
			
			timeDisplayView(shouldDisplay: $isShowingDay,
							dayOfTheWeek: dayOfTheWeek,
							timeDisplayType: .top )
				.environmentObject( schedule )
			
			ZStack( alignment: .top )
			{
				sliderTrack
				
				if isShowingDay
				{
					hourlyRangeBar
					dragHandles
				}
			}
			
			timeDisplayView(shouldDisplay: $isShowingDay,
							dayOfTheWeek: dayOfTheWeek,
							timeDisplayType: .bottom )
				.environmentObject( schedule )
			
		}
	}
	
	//	MARK: - Private Properties
	@State private var isShowingDay = false
	
	private var addRemoveButton: some View
	{
		Button( action: isShowingDay ? removeDay : addDay )
		{
			Image( systemName: isShowingDay ? "minus.circle" : "plus.circle" )
				.foregroundColor( isShowingDay ? .red : .green )
		}
		.buttonStyle( .plain )
		.padding( 5 )
	}
	
	private var sliderTrack: some View
	{
		RoundedRectangle( cornerRadius: 4, style: .continuous )
			.fill( Color.gray.opacity( 0.15 ) )
			.frame( width: 15, height: totalHeight + 12 )
	}
	
	private var hourlyRangeBar: some View
	{
		RoundedRectangle( cornerRadius: 4, style: .continuous )
			.fill( selectedColor )
			.frame( width: 15, height: self.handle2Position.y - self.handle1Position.y + 12 )
			.offset( y: self.handle1Position.y )
	}
	
	private var dragHandles: some View
	{
		VStack( spacing: 0 )
		{
			DragHandleView( direction: .top,
							handlePosition: $handle1Position,
							onDrag:
								{
				tDragLocation in
				if tDragLocation >= .zero && tDragLocation <= handle2Position.y
				{
					let tSnappingCalculator = SnappingCalculator( totalLength: self.totalHeight, divisionCount: intervalsPerDay )
					handle1Position.y = tSnappingCalculator.positionFor( proposedPosition: tDragLocation )
					updateSchedule( forHandleDirection: .top )
				}
			} )
			
			DragHandleView( direction: .bottom,
							handlePosition: $handle2Position,
							onDrag:
								{
				tDragLocation in
				if tDragLocation >= handle1Position.y && tDragLocation <= totalHeight
				{
					let tSnappingCalculator = SnappingCalculator( totalLength: self.totalHeight, divisionCount: intervalsPerDay )
					handle2Position.y = tSnappingCalculator.positionFor( proposedPosition: tDragLocation )
					updateSchedule( forHandleDirection: .bottom )
				}
			} )
		}
	}
	
	var intervalsPerDay: TimeInterval
	{
		return scheduleEnd - scheduleStart
	}
	
	//	MARK: - Private Methods
	private func addDay()
	{
		isShowingDay = true
		updateSchedule( forHandleDirection: .top )
		updateSchedule( forHandleDirection: .bottom )
	}
	
	private func removeDay()
	{
		isShowingDay = false
		updateSchedule( forHandleDirection: .top )
		updateSchedule( forHandleDirection: .bottom )
	}
	
	private func updateSchedule( forHandleDirection theHandleDirection: DragHandleDirection )
	{
		if isShowingDay
		{
			schedule.dailySchedules[dayOfTheWeek.rawValue].isActive = true
		}
		else
		{
			schedule.dailySchedules[dayOfTheWeek.rawValue].isActive = false
		}
		
		let tTimeIntervalOffsetFromMidnight = scheduleStart
		switch theHandleDirection
		{
			case .top:
				let tTopHandleTime = TimeConverter( position: handle1Position.y,
													totalLength: totalHeight,
													intervalsPerDay: intervalsPerDay ).timeInterval
				schedule.dailySchedules[dayOfTheWeek.rawValue].start = tTopHandleTime + tTimeIntervalOffsetFromMidnight
				
			case .bottom:
				let tBottomHandleTime = TimeConverter( position: handle2Position.y,
													   totalLength: totalHeight,
													   intervalsPerDay: intervalsPerDay ).timeInterval
				schedule.dailySchedules[dayOfTheWeek.rawValue].end = tBottomHandleTime + tTimeIntervalOffsetFromMidnight
				
			default:
				return
		}
	}
}
