//
//  Color+RawRepresentable.swift
//  Color+RawRepresentable
//
//  Created by Scott Gould on 8/24/21.
//

//	Original code by Zane Carter modified for macOS from: https://medium.com/geekculture/using-appstorage-with-swiftui-colors-and-some-nskeyedarchiver-magic-a38038383c5e

import AppKit
import SwiftUI

extension Color: RawRepresentable
{
	public init?( rawValue theRawValue: String )
	{
		guard let data = Data( base64Encoded: theRawValue )
		else
		{
			self = .black
			return
		}
		
		do
		{
			let tColor = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData( data ) as? NSColor ?? .black
			self = Color( tColor )
		}
		catch
		{
			self = .black
		}
	}
	
	public var rawValue: String
	{
		do
		{
			let tData = try NSKeyedArchiver.archivedData( withRootObject: NSColor( self ),
														  requiringSecureCoding: false ) as Data
			return tData.base64EncodedString()
		}
		catch
		{
			return ""
		}
	}
}
