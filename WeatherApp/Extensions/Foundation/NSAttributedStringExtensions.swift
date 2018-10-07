//
//  NSAttributedStringExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 26/11/2016.
//  Copyright © 2016 SwifterSwift
//

#if canImport(Foundation)
import Foundation

#if canImport(UIKit)
import UIKit
#endif

#if canImport(Cocoa)
import Cocoa
#endif

// MARK: - Properties
public extension NSAttributedString {

	#if os(iOS)
	/// SwifterSwift: Bolded string.
	public var bolded: NSAttributedString {
		return applying(attributes: [.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
	}
	#endif

	/// SwifterSwift: Underlined string.
	public var underlined: NSAttributedString {
    return applying(attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
	}

	#if os(iOS)
	/// SwifterSwift: Italicized string.
	public var italicized: NSAttributedString {
		return applying(attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
	}
	#endif

	/// SwifterSwift: Struckthrough string.
	public var struckthrough: NSAttributedString {
    return applying(attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)])
	}

	/// SwifterSwift: Dictionary of the attributes applied across the whole string
	public var attributes: [NSAttributedString.Key: Any] {
		return attributes(at: 0, effectiveRange: nil)
	}

}

// MARK: - Methods
public extension NSAttributedString {

	/// SwifterSwift: Applies given attributes to the new instance of NSAttributedString initialized with self object
	///
	/// - Parameter attributes: Dictionary of attributes
	/// - Returns: NSAttributedString with applied attributes
	fileprivate func applying(attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
		let copy = NSMutableAttributedString(attributedString: self)
		let range = (string as NSString).range(of: string)
		copy.addAttributes(attributes, range: range)

		return copy
	}

	#if os(macOS)
	/// SwifterSwift: Add color to NSAttributedString.
	///
	/// - Parameter color: text color.
	/// - Returns: a NSAttributedString colored with given color.
	public func colored(with color: NSColor) -> NSAttributedString {
	return applying(attributes: [.foregroundColor: color])
	}
	#else
	/// SwifterSwift: Add color to NSAttributedString.
	///
	/// - Parameter color: text color.
	/// - Returns: a NSAttributedString colored with given color.
	public func colored(with color: UIColor) -> NSAttributedString {
		return applying(attributes: [.foregroundColor: color])
	}
	#endif

	/// SwifterSwift: Apply attributes to substrings matching a regular expression
	///
	/// - Parameters:
	///   - attributes: Dictionary of attributes
	///   - pattern: a regular expression to target
	/// - Returns: An NSAttributedString with attributes applied to substrings matching the pattern
	public func applying(attributes: [NSAttributedString.Key: Any], toRangesMatching pattern: String) -> NSAttributedString {
		guard let pattern = try? NSRegularExpression(pattern: pattern, options: []) else { return self }

		let matches = pattern.matches(in: string, options: [], range: NSRange(0..<length))
		let result = NSMutableAttributedString(attributedString: self)

		for match in matches {
			result.addAttributes(attributes, range: match.range)
		}

		return result
	}

	/// SwifterSwift: Apply attributes to occurrences of a given string
	///
	/// - Parameters:
	///   - attributes: Dictionary of attributes
	///   - target: a subsequence string for the attributes to be applied to
	/// - Returns: An NSAttributedString with attributes applied on the target string
	public func applying<T: StringProtocol>(attributes: [NSAttributedString.Key: Any], toOccurrencesOf target: T) -> NSAttributedString {
		let pattern = "\\Q\(target)\\E"

		return applying(attributes: attributes, toRangesMatching: pattern)
	}

}

// MARK: - Operators
public extension NSAttributedString {

	/// SwifterSwift: Add a NSAttributedString to another NSAttributedString.
	///
	/// - Parameters:
	///   - lhs: NSAttributedString to add to.
	///   - rhs: NSAttributedString to add.
	public static func += (lhs: inout NSAttributedString, rhs: NSAttributedString) {
		let string = NSMutableAttributedString(attributedString: lhs)
		string.append(rhs)
		lhs = string
	}

	/// SwifterSwift: Add a NSAttributedString to another NSAttributedString and return a new NSAttributedString instance.
	///
	/// - Parameters:
	///   - lhs: NSAttributedString to add.
	///   - rhs: NSAttributedString to add.
	/// - Returns: New instance with added NSAttributedString.
	public static func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
		let string = NSMutableAttributedString(attributedString: lhs)
		string.append(rhs)
		return NSAttributedString(attributedString: string)
	}

	/// SwifterSwift: Add a NSAttributedString to another NSAttributedString.
	///
	/// - Parameters:
	///   - lhs: NSAttributedString to add to.
	///   - rhs: String to add.
	public static func += (lhs: inout NSAttributedString, rhs: String) {
		lhs += NSAttributedString(string: rhs)
	}

	/// SwifterSwift: Add a NSAttributedString to another NSAttributedString and return a new NSAttributedString instance.
	///
	/// - Parameters:
	///   - lhs: NSAttributedString to add.
	///   - rhs: String to add.
	/// - Returns: New instance with added NSAttributedString.
	public static func + (lhs: NSAttributedString, rhs: String) -> NSAttributedString {
		return lhs + NSAttributedString(string: rhs)
	}

}
#endif

extension NSAttributedString {
  /**
   Returns a new mutable string with characters from a given character set removed.
   See http://panupan.com/2012/06/04/trim-leading-and-trailing-whitespaces-from-nsmutableattributedstring/
   - Parameters:
   - charSet: The character set with which to remove characters.
   - returns: A new string with the matching characters removed.
   */
  public func trimmingCharacters(in set: CharacterSet) -> NSAttributedString {
    let modString = NSMutableAttributedString(attributedString: self)
    modString.trimCharacters(in: set)
    return NSAttributedString(attributedString: modString)
  }
}


extension NSMutableAttributedString {
  /**
   Modifies this instance of the string to remove characters from a given character set from
   the beginning and end of the string.
   See http://panupan.com/2012/06/04/trim-leading-and-trailing-whitespaces-from-nsmutableattributedstring/
   - Parameters:
   - charSet: The character set with which to remove characters.
   */
  public func trimCharacters(in set: CharacterSet) {
    var range = (string as NSString).rangeOfCharacter(from: set)
    
    // Trim leading characters from character set.
    while range.length != 0 && range.location == 0 {
      replaceCharacters(in: range, with: "")
      range = (string as NSString).rangeOfCharacter(from: set)
    }
    
    // Trim trailing characters from character set.
    range = (string as NSString).rangeOfCharacter(from: set, options: .backwards)
    while range.length != 0 && NSMaxRange(range) == length {
      replaceCharacters(in: range, with: "")
      range = (string as NSString).rangeOfCharacter(from: set, options: .backwards)
    }
  }
  
}


extension NSMutableAttributedString {
  
  fileprivate var range: NSRange {
    return NSRange(location: 0, length: length)
  }
  
  fileprivate var paragraphStyle: NSMutableParagraphStyle? {
    return attributes(at: 0, effectiveRange: nil)[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle
  }
  
}

// MARK: - Font
extension NSMutableAttributedString {
  /**
   Applies a font to the entire string.
   
   - parameter font: The font.
   */
  @discardableResult
  public func font(_ font: UIFont) -> Self {
    addAttribute(NSAttributedString.Key.font, value: font, range: range)
    return self
  }
  
  /**
   Applies a font to the entire string.
   
   - parameter name: The font name.
   - parameter size: The font size.
   
   Note: If the specified font name cannot be loaded, this method will fallback to the system font at the specified size.
   */
  @discardableResult
  public func font(name: String, size: CGFloat) -> Self {
    addAttribute(NSAttributedString.Key.font, value: UIFont(name: name, size: size) ?? .systemFont(ofSize: size), range: range)
    return self
  }
}

// MARK: - Paragraph style
extension NSMutableAttributedString {
  
  /**
   Applies a text alignment to the entire string.
   
   - parameter alignment: The text alignment.
   */
  @discardableResult
  public func alignment(_ alignment: NSTextAlignment) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.alignment = alignment
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies line spacing to the entire string.
   
   - parameter lineSpacing: The line spacing amount.
   */
  @discardableResult
  public func lineSpacing(_ lineSpacing: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpacing
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies paragraph spacing to the entire string.
   
   - parameter paragraphSpacing: The paragraph spacing amount.
   */
  @discardableResult
  public func paragraphSpacing(_ paragraphSpacing: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.paragraphSpacing = paragraphSpacing
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Add a line to the entire string.
   
   - parameter mode: The line break mode.
   */
  @discardableResult
  public func addLine() -> Self {
    append(NSAttributedString(string: "\n"))
    return self
  }
  
  
  /**
   Applies a line break mode to the entire string.
   
   - parameter mode: The line break mode.
   */
  @discardableResult
  public func lineBreak(_ mode: NSLineBreakMode) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.lineBreakMode = mode
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a line height multiplier to the entire string.
   
   - parameter multiple: The line height multiplier.
   */
  @discardableResult
  public func lineHeight(multiple: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = multiple
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a first line head indent to the string.
   
   - parameter indent: The first line head indent amount.
   */
  @discardableResult
  public func firstLineHeadIndent(_ indent: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.firstLineHeadIndent = indent
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a head indent to the string.
   
   - parameter indent: The head indent amount.
   */
  @discardableResult
  public func headIndent(_ indent: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.headIndent = indent
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies tabstops.
   
   - parameter tabstop.
   */
  @discardableResult
  public func tabStops(_ tabStops: [NSTextTab] ) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.tabStops = tabStops
    return self
  }
  
  @discardableResult
  public func defaultTabInterval(_ indentation: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.defaultTabInterval = indentation
    return self
  }
  

  
  /**
   Applies a tail indent to the string.
   
   - parameter indent: The tail indent amount.
   */
  @discardableResult
  public func tailIndent(_ indent: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.tailIndent = indent
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a minimum line height to the entire string.
   
   - parameter height: The minimum line height.
   */
  @discardableResult
  public func minimumLineHeight(_ height: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.minimumLineHeight = height
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a maximum line height to the entire string.
   
   - parameter height: The maximum line height.
   */
  @discardableResult
  public func maximumLineHeight(_ height: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.maximumLineHeight = height
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a base writing direction to the entire string.
   
   - parameter direction: The base writing direction.
   */
  @discardableResult
  public func baseWritingDirection(_ direction: NSWritingDirection) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.baseWritingDirection = direction
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a paragraph spacing before amount to the string.
   
   - parameter spacing: The distance between the paragraph’s top and the beginning of its text content.
   */
  @discardableResult
  public func paragraphSpacingBefore(_ spacing: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.paragraphSpacingBefore = spacing
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
}

// MARK: - Foreground color
extension NSMutableAttributedString {
  /**
   Applies the given color over the entire string, as the foreground color.
   
   - parameter color: The color to apply.
   */
  @discardableResult @nonobjc
  public func color(_ color: UIColor, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedString.Key.foregroundColor, value: color.alpha(alpha), range: range)
    return self
  }
  
  /**
   Applies the given color over the entire string, as the foreground color.
   
   - parameter color: The color to apply.
   */
  @discardableResult
  public func color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: red, green: green, blue: blue, alpha: alpha), range: range)
    return self
  }
  
  /**
   Applies the given color over the entire string, as the foreground color.
   
   - parameter color: The color to apply.
   */
  @discardableResult
  public func color(white: CGFloat, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(white: white, alpha: alpha), range: range)
    return self
  }
  
  /**
   Applies the given color over the entire string, as the foreground color.
   
   - parameter color: The color to apply.
   */
  @discardableResult @nonobjc
  public func color(_ hex: UInt32, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(white: CGFloat(hex), alpha: alpha), range: range)
    return self
  }
}

// MARK: - Underline, kern, strikethrough, stroke, shadow, text effect
extension NSMutableAttributedString {
  /**
   Applies a single underline under the entire string.
   
   - parameter style: The `NSUnderlineStyle` to apply. Defaults to `.styleSingle`.
   */
  @discardableResult
  public func underline(style: NSUnderlineStyle = .single, color: UIColor? = nil) -> Self {
    addAttribute(NSAttributedString.Key.underlineStyle, value: style.rawValue, range: range)
    
    if let color = color {
      addAttribute(NSAttributedString.Key.underlineColor, value: color, range: range)
    }
    
    return self
  }
  
  /**
   Applies a kern (spacing) value to the entire string.
   
   - parameter value: The space between each character in the string.
   */
  @discardableResult
  public func kern(_ value: CGFloat) -> Self {
    addAttribute(NSAttributedString.Key.kern, value: value, range: range)
    return self
  }
  
  /**
   Applies a strikethrough to the entire string.
   
   - parameter style: The `NSUnderlineStyle` to apply. Defaults to `.styleSingle`.
   - parameter color: The underline color. Defaults to the color of the text.
   */
  @discardableResult
  public func strikethrough(style: NSUnderlineStyle = .single, color: UIColor? = nil) -> Self {
    addAttribute(NSAttributedString.Key.strikethroughStyle, value: style.rawValue, range: range)
    
    if let color = color {
      addAttribute(NSAttributedString.Key.strikethroughColor, value: color, range: range)
    }
    
    return self
  }
  
  /**
   Applies a stroke to the entire string.
   
   - parameter color: The stroke color.
   - parameter width: The stroke width.
   */
  @discardableResult
  public func stroke(color: UIColor, width: CGFloat) -> Self {
    addAttributes([
      NSAttributedString.Key.strokeColor : color,
      NSAttributedString.Key.strokeWidth : width
      ], range: range)
    
    return self
  }
  
  /**
   Applies a shadow to the entire string.
   
   - parameter color: The shadow color.
   - parameter radius: The shadow blur radius.
   - parameter offset: The shadow offset.
   */
  @discardableResult
  public func shadow(color: UIColor, radius: CGFloat, offset: CGSize) -> Self {
    let shadow = NSShadow()
    shadow.shadowColor = color
    shadow.shadowBlurRadius = radius
    shadow.shadowOffset = offset
    
    addAttribute(NSAttributedString.Key.shadow, value: shadow, range: range)
    
    return self
  }
  
}

// MARK: - Background color
extension NSMutableAttributedString {
  
  /**
   Applies a background color to the entire string.
   
   - parameter color: The color to apply.
   */
  @discardableResult @nonobjc
  public func backgroundColor(_ color: UIColor, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedString.Key.backgroundColor, value: color.alpha(alpha), range: range)
    return self
  }
  
  /**
   Applies a background color to the entire string.
   
   - parameter red: The red color component.
   - parameter green: The green color component.
   - parameter blue: The blue color component.
   - parameter alpha: The alpha component.
   */
  @discardableResult
  public func backgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor(red: red, green: green, blue: blue, alpha: alpha), range: range)
    return self
  }
  
  /**
   Applies a background color to the entire string.
   
   - parameter white: The white color component.
   - parameter alpha: The alpha component.
   */
  @discardableResult
  public func backgroundColor(white: CGFloat, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor(white: white, alpha: alpha), range: range)
    return self
  }
  
  /**
   Applies a background color to the entire string.
   
   - parameter hex: The hex color value.
   - parameter alpha: The alpha component.
   */
  @discardableResult @nonobjc
  public func backgroundColor(_ hex: UInt32, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor(white: CGFloat(hex), alpha: alpha), range: range)
    return self
  }
}

extension NSMutableAttributedString {
  
  /**
   Applies a baseline offset to the entire string.
   
   - parameter offset: The offset value.
   */
  @discardableResult
  public func baselineOffset(_ offset: Float) -> Self {
    addAttribute(NSAttributedString.Key.baselineOffset, value: NSNumber(value: offset), range: range)
    return self
  }
}

public func +(lhs: NSMutableAttributedString, rhs: NSAttributedString) -> NSMutableAttributedString {
  let lhs = NSMutableAttributedString(attributedString: lhs)
  lhs.append(rhs)
  return lhs
}

public func +=(lhs: NSMutableAttributedString, rhs: NSAttributedString) {
  lhs.append(rhs)
}

