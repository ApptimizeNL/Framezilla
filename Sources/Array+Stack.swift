//
//  Array+Stack.swift
//  Framezilla
//
//  Created by Nikita Ermolenko on 19/02/2017.
//
//

public enum StackAxis : Int {
    case horizontal
    case vertical
}

public extension Array where Element: UIView {
    
    /// Arranges views in the order of list along a vertical or horizontal axis, with spacing properties.
    ///
    /// - note: You have to change the `state` of the container, not the arranged subviews.
    ///
    /// - parameter axis:      A stack with a horizontal axis is a row of arranged subviews, and a stack with a vertical axis is a column of arranged subviews.
    /// - parameter spacing:   Spacing between adjacent edges of arranged subviews.
    /// - parameter state:     The state for which you configure frame.
    
    public func stack(axis: StackAxis, spacing: Number = 0.0, state: AnyHashable = STATE_DEFAULT_VALUE) {
        
        for view in self {
            guard let _ = view.superview else {
                assertionFailure("Can not configure stack relation without superview.")
                return
            }
        }

        let superview = self[0].superview!
        for view in self {
            if view.superview != superview {
                assertionFailure("All views should have the same superview.")
            }
        }
        
        guard superview.nui_state == state else {
            return
        }
        
        let count = CGFloat(self.count)
        var prevView = self[0]
        
        switch axis {
        case .horizontal:
            let width = (superview.bounds.width - (count - 1) * spacing.value) / count
            let height = superview.bounds.height

            for (index, view) in self.enumerated() {
                view.configureFrames { maker in
                    maker.size(width: width, height: height)
                    if index == 0 {
                        maker.left()
                    }
                    else {
                        maker.left(to: prevView.nui_right, inset: spacing)
                    }
                }
                prevView = view
            }
        case .vertical:
            let width = superview.bounds.width
            let height = (superview.bounds.height - (count - 1) * spacing.value) / count

            for (index, view) in self.enumerated() {
                view.configureFrames { maker in
                    maker.size(width: width, height: height)
                    if index == 0 {
                        maker.top()
                    }
                    else {
                        maker.top(to: prevView.nui_bottom, inset: spacing)
                    }
                }
                prevView = view
            }
            
        }
    }
}
