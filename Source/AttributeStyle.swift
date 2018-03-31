//
//  AttributeStyle.swift
//  ListOK.swift
//
//  Created by Radaev Mikhail on 30.09.17.
//  Copyright © 2017 ListOK. All rights reserved.
//

import Foundation
import UIKit

public extension Float {
    public var cgFloat: CGFloat { return CGFloat(self) }
}

public extension Dictionary {
    public func map<T: Hashable, U>( transform: (Key, Value) -> (T, U)) -> [T: U] {
        var result: [T: U] = [:]
        for (key, value) in self {
            let (transformedKey, transformedValue) = transform(key, value)
            result[transformedKey] = transformedValue
        }
        return result
    }
}

public extension NSAttributedString {
    public static var empty: NSAttributedString { return NSAttributedString() }
}

public extension String {
   public func with(style: AttributeStyle) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: style.build())
    }
}

public func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
    let result = NSMutableAttributedString()
    result.append(lhs)
    result.append(rhs)
    return NSAttributedString(attributedString: result)
}

public class AttributeStyle {
    private var styles = Dictionary<NSAttributedStringKey, Any>()
    private let paragraph = NSMutableParagraphStyle()

    public enum Color {
        case foreground(UIColor)
        case background(UIColor)
        case stroke(UIColor)
        case strikethrough(UIColor)
        case underline(UIColor)
    }

    public enum Spacing {
        public enum Paragraph {
            case before(Float)
            case after(Float)
        }

        case line(Float)
        case paragraph(Spacing.Paragraph)
    }

    public enum LineHeight {
        case minimum(Float)
        case maximum(Float)
        case multiple(Float)
    }

    public enum Indent {
        case firstLine(Float)
        case head(Float)
        case tail(Float)
    }

    public enum Tab {
        case stops(Array<NSTextTab>)
        case defaultInterval(Float)
    }

    public enum Style {
        case strikethrough(NSUnderlineStyle)
        case underline(NSUnderlineStyle)
    }

    public init() {}

    public func font(_ font: UIFont) -> AttributeStyle {
        self.styles[NSAttributedStringKey.font] = font
        return self
    }

    public func color(_ color: Color) -> AttributeStyle {
        switch color {
        case .background(let value):
            self.styles[NSAttributedStringKey.backgroundColor] = value
        case .foreground(let value):
            self.styles[NSAttributedStringKey.foregroundColor] = value
        case .strikethrough(let value):
            self.styles[NSAttributedStringKey.strikethroughColor] = value
        case .stroke(let value):
            self.styles[NSAttributedStringKey.strokeColor] = value
        case .underline(let value):
            self.styles[NSAttributedStringKey.underlineColor] = value
        }

        return self
    }

    public func spacing(_ spacing: Spacing) -> AttributeStyle {
        switch spacing {
        case .line(let value):
            self.paragraph.lineSpacing = value.cgFloat
        case .paragraph(.after(let value)):
            self.paragraph.paragraphSpacing = value.cgFloat
        case .paragraph(.before(let value)):
            self.paragraph.paragraphSpacingBefore = value.cgFloat
        }
        return self
    }

    public func indent(_ indent: Indent) -> AttributeStyle {
        switch indent {
        case .firstLine(let value):
            self.paragraph.firstLineHeadIndent = value.cgFloat
        case .head(let value):
            self.paragraph.headIndent = value.cgFloat
        case .tail(let value):
            self.paragraph.tailIndent = value.cgFloat
        }
        return self
    }

    public func alignment(_ alignment: NSTextAlignment) -> AttributeStyle {
        self.paragraph.alignment = alignment
        return self
    }

    public func baseWriting(direction: NSWritingDirection) -> AttributeStyle {
        self.paragraph.baseWritingDirection = direction
        return self
    }

    public func tab(_ tab: Tab) -> AttributeStyle {
        switch tab {
        case .stops(let value):
            self.paragraph.tabStops = value
        case .defaultInterval(let value):
            self.paragraph.defaultTabInterval = value.cgFloat
        }
        return self
    }

    public func hyphenation(factor: Float) -> AttributeStyle {
        self.paragraph.hyphenationFactor = factor
        return self
    }

    public func style(_ style: Style) -> AttributeStyle {
        switch style {
        case .strikethrough(let value):
            self.styles[NSAttributedStringKey.strikethroughStyle] = value
        case .underline(let value):
            self.styles[NSAttributedStringKey.underlineStyle] = value
        }
        return self
    }

    public func breakMode(_ mode: NSLineBreakMode) -> AttributeStyle {
        self.paragraph.lineBreakMode = mode
        return self
    }

    public func stroke(width: Float) -> AttributeStyle {
        self.styles[NSAttributedStringKey.strokeWidth] = width.cgFloat
        return self
    }

    public func baseline(offset: Float) -> AttributeStyle {
        self.styles[NSAttributedStringKey.baselineOffset] = offset.cgFloat
        return self
    }

    public func text(effect: String) -> AttributeStyle {
        self.styles[NSAttributedStringKey.textEffect] = effect
        return self
    }

    public func shadow(_ shadow: NSShadow) -> AttributeStyle {
        self.styles[NSAttributedStringKey.shadow] = shadow
        return self
    }

    public func kern(_ kern: Float) -> AttributeStyle {
        self.styles[NSAttributedStringKey.kern] = kern.cgFloat
        return self
    }

    public func ligature(_ ligature: Int) -> AttributeStyle {
        self.styles[NSAttributedStringKey.ligature] = ligature
        return self
    }

    public func build() -> Dictionary<String, Any> {
        self.styles[NSAttributedStringKey.paragraphStyle] = self.paragraph
        return self.styles.map { key, value  in return (key.rawValue, value) }
    }

    public func build() -> Dictionary<NSAttributedStringKey, Any> {
        self.styles[NSAttributedStringKey.paragraphStyle] = self.paragraph
        return self.styles
    }
}
