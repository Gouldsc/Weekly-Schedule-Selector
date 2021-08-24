//
//  DragHandleView.swift
//  DragHandleView
//
//  Created by Scott Gould on 8/24/21.
//

import SwiftUI

enum DragHandleDirection
{
	case top
	case bottom
	case leading
	case trailing
}

struct DragHandleView: View
{
	@AppStorage( SettingsKeys.selectedColor ) var selectedColor: Color = Color( #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1) )
	
	var direction: DragHandleDirection
	@Binding var handlePosition: CGPoint
	@State private var isHovering = false
	
	var onDrag: (CGFloat) -> Void		//	We kick this back up to the Parent view, so it can manage collisions with the other handle
	
	var body: some View
	{
		RoundedRectangle( cornerRadius: 4, style: .continuous )
			.fill( selectedColor )
			.frame( width: width,
					height: height )
			.onHover( perform:
						{
				tIsHovering in
				self.handleHoverEvent( hoverStatus: tIsHovering )
			} )
			.offset( x: xOffset, y: yOffset )
			.gesture( draggingHandle )
	}
	
	private func handleHoverEvent( hoverStatus: Bool )
	{
		self.isHovering = hoverStatus
		
		if isHovering
		{
			self.directionalCursor.push()
		}
		else
		{
			self.directionalCursor.pop()
		}
	}
	
	private var draggingHandle: some Gesture
	{
		DragGesture()
			.onChanged(
				{
					tDragValue in
					self.onDrag( isVerticalOrientation ? tDragValue.location.y :
									tDragValue.location.x )
				} )
	}
	
	//	MARK: - Directional Private Properties
	private var isVerticalOrientation: Bool
	{
		switch direction
		{
			case .top, .bottom:
				return true
				
			case .leading, .trailing:
				return false
		}
	}
	
	private var directionalCursor: NSCursor
	{
		switch direction
		{
			case .top, .bottom:
				return NSCursor.resizeUpDown
				
			case .leading, .trailing:
				return NSCursor.resizeLeftRight
		}
	}
	
	private var width: CGFloat
	{
		switch direction
		{
			case .top, .bottom:
				return 15
				
			case .leading, .trailing:
				return 6
		}
	}
	
	private var height: CGFloat
	{
		switch direction
		{
			case .top, .bottom:
				return 6
				
			case .leading, .trailing:
				return 15
		}
	}
	
	private var xOffset: CGFloat
	{
		switch direction
		{
			case .top, .bottom:
				return 0
				
			case .leading:
				return handlePosition.x
				
			case .trailing:
				return handlePosition.x + width
		}
	}
	
	private var yOffset: CGFloat
	{
		switch direction
		{
			case .top, .bottom:
				return handlePosition.y
				
			case .leading:
				return 0.5 * height	//	FIXME: I am unclear why these offsets are necessary but handles are out of position on the y axis without them
				
			case .trailing:
				return 0.5 * -height	//	FIXME: I am unclear why these offsets are necessary
		}
	}
}
