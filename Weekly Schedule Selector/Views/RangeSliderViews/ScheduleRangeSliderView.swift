//
//  ScheduleRangeSliderView.swift
//  ScheduleRangeSliderView
//
//  Created by Scott Gould on 8/24/21.
//

import SwiftUI

struct ScheduleRangeSliderView: View
{
	//	MARK: - Properties
	
	@AppStorage( SettingsKeys.clockStyle ) var clockStyle: HourRepresentationStyle = .twelveHour
	@AppStorage( SettingsKeys.selectedColor ) private(set) var selectedColor: Color = Color( #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)  )
	@AppStorage( SettingsKeys.scheduleStart )  var scheduleStart: TimeInterval = 0
	@AppStorage( SettingsKeys.scheduleEnd ) var scheduleEnd: TimeInterval = 96
	
	@State var handle1Position = CGPoint( x: 20, y: 0 )
	@State var handle2Position = CGPoint( x: 350, y: 0 )
	@State var totalWidth: CGFloat
	
	var body: some View
	{
		HStack
		{
			leadingTimeDisplay
			
			ZStack( alignment: .leading )
			{
				sliderTrack
				hourlyRangeBar
				dragHandles
			}
			
			trailingTimeDisplay
			
		}
	}
	
	//	MARK: - Private Properties
	private var leadingTimeDisplay: some View
	{
		Text( leadingTime )
			.font( .footnote )
			.frame( minWidth: 40,
					alignment: .trailing )
	}
	
	private var leadingTime: String
	{
		let tTime = TimeConverter( timeInterval: scheduleStart )
		return clockStyle == .twelveHour ? tTime.twelveHourTimeRepresentation :
		tTime.twentyFourHourTimeRepresentation
	}
	
	private var sliderTrack: some View
	{
		RoundedRectangle( cornerRadius: 4, style: .continuous )
			.fill( Color.gray.opacity( 0.15 ) )
			.frame( width: totalWidth + 12, height: 15 )
	}
	
	private var hourlyRangeBar: some View
	{
		RoundedRectangle( cornerRadius: 4, style: .continuous )
			.fill( selectedColor )
			.frame( width: self.handle2Position.x - self.handle1Position.x + 12, height: 15 )
			.offset( x: self.handle1Position.x )
	}
	
	private var dragHandles: some View
	{
		VStack( spacing: 0 )
		{
			DragHandleView( direction: .leading,
							handlePosition: $handle1Position,
							onDrag:
								{
				tDragLocation in
				if tDragLocation >= .zero && tDragLocation <= handle2Position.x
				{
					let tSnappingCalculator = SnappingCalculator( totalLength: self.totalWidth, divisionCount: 96 )
					handle1Position.x = tSnappingCalculator.positionFor( proposedPosition: tDragLocation )
					updateScheduleSettings( forHandleDirection: .leading )
				}
			} )
			
			DragHandleView( direction: .trailing,
							handlePosition: $handle2Position,
							onDrag:
								{
				tDragLocation in
				if tDragLocation >= handle1Position.x && tDragLocation <= totalWidth
				{
					let tSnappingCalculator = SnappingCalculator( totalLength: self.totalWidth, divisionCount: 96 )
					handle2Position.x = tSnappingCalculator.positionFor( proposedPosition: tDragLocation )
					updateScheduleSettings( forHandleDirection: .trailing )
				}
			} )
		}
	}
	
	private var trailingTimeDisplay: some View
	{
		Text( trailingTime )
			.font( .footnote )
			.frame( minWidth: 40,
					alignment: .leading )
	}
	
	private var trailingTime: String
	{
		let tTime = TimeConverter( timeInterval: scheduleEnd )
		return clockStyle == .twelveHour ? tTime.twelveHourTimeRepresentation :
		tTime.twentyFourHourTimeRepresentation
	}
	
	//	MARK: - Private Methods
	private func updateScheduleSettings( forHandleDirection theHandleDirection: DragHandleDirection )
	{
		switch theHandleDirection
		{
			case .leading:
				scheduleStart = TimeConverter( position: handle1Position.x,
											   totalLength: totalWidth,
											   intervalsPerDay: 96 ).timeInterval
				
			case .trailing:
				scheduleEnd = TimeConverter( position: handle2Position.x,
											 totalLength: totalWidth,
											 intervalsPerDay: 96 ).timeInterval
				
			default:
				return
		}
	}
}
