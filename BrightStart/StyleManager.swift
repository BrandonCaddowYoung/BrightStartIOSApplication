//
//  StyleManager.swift
//


import Foundation
import ChameleonFramework

typealias Style = StyleManager

//MARK: - StyleManager

final class StyleManager {
    
    // MARK: - StyleManager
    
    static func setUpTheme() {
        Chameleon.setGlobalThemeUsingPrimaryColor(theme1(), withSecondaryColor: theme2(), usingFontName: "HelveticaNeue-Thin", andContentStyle: content())
    }
    
    // MARK: - Theme
    
    static func theme1() -> UIColor {
        return UIColor.flatBlue
    }
    
    static func theme2() -> UIColor {
        return UIColor.flatWhite
    }
    
    static func theme3() -> UIColor {
        return UIColor.flatGray
    }
    
    static func theme4() -> UIColor {
        return UIColor.flatOrange
    }
    
    static func theme5() -> UIColor {
        return UIColor.flatBlack
    }
    
    static func errorTheme() -> UIColor {
        return UIColor.flatRed
    }
    
    static func TableBackGroundColour() -> UIColor {
        return theme2()
    }
    
    static func lightFont() -> UIColor {
        return theme2()
    }
    
    static func darkFont() -> UIColor {
        return theme5()
    }
    
    static func DarkBackground() -> UIColor {
        return UIColor.flatBlue
    }

    static func LightBackground() -> UIColor {
        return UIColor.flatBlue
    }
    
    init() {
    
    }
  
    static func NavigationBarBackGround() -> UIColor {
        return UIColor.flatBlue
    }
    
    static func NavigationBarText() -> UIColor {
        return UIColor.flatWhite
    }
    
    static func NavigationBarBackButton() -> UIColor {
        return UIColor.flatOrange
    }
    
    static func HeadingFontColour() -> UIColor {
        return UIColor.flatBlack
    }
    
    static func FontColour() -> UIColor {
        return UIColor.flatWhite
    }
    
    static func TableFontColor() -> UIColor {
        return UIColor.flatBlack
    }
    
    
    
   
    
    static func TableViewHeadingFontColour() -> UIColor {
       return UIColor.flatBlue
    }
    
    
    
    
    
    
    
    
    
    static func buttonBackGround() -> UIColor {
        return UIColor.flatWhite
    }
    
    static func buttonForeGround() -> UIColor {
        return UIColor.flatBlack
    }
    
    
    
    
    
    
    
    
    
    
    
    
    static func toolBarTheme() -> UIColor {
        return FlatMint()
    }
    
    static func tintTheme() -> UIColor {
        return FlatMint()
    }
    
    static func titleTextTheme() -> UIColor {
        return FlatWhite()
    }
    
    static func titleTheme() -> UIColor {
        return FlatCoffeeDark()
    }
    
    static func textTheme() -> UIColor {
        return FlatMint()
    }
    
    static func backgroudTheme() -> UIColor {
        return UIColor.flatBlue
    }
    
    static func positiveTheme() -> UIColor {
        return FlatMint()
    }
    
    static func negativeTheme() -> UIColor {
        return FlatRed()
    }
    
    static func clearTheme() -> UIColor {
        return UIColor.clear
    }
    
    // MARK: - Content
    
    static func content() -> UIContentStyle {
        return UIContentStyle.contrast
    }
    
    // MARK: - Font
    
    
}

//MARK: - FontType

enum FontType {
    case Small
    case Medium
    case Large
    case XLArge
    case XXLArge
    case XXXLArge
}

extension FontType {
    var fontName: String {
        switch self {
        
        case .Small:
            return "HelveticaNeue-Thin"
        case .Medium:
            return "HelveticaNeue-Thin"
        case .Large:
            return "HelveticaNeue-Thin"
        case .XLArge:
            return "HelveticaNeue-Thin"
        case .XXLArge:
            return "HelveticaNeue-Thin"
        case .XXXLArge:
            return "HelveticaNeue-Thin"

        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .Small:
            return 10
         case .Medium:
            return 20
        case .Large:
            return 30
        case .XLArge:
            return 40
        case .XXLArge:
            return 50
        case .XXXLArge:
            return 60
        }
    }
}
