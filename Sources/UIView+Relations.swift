//
//  UIView+Relations.swift
//  Framezilla
//
//  Created by Nikita on 26/08/16.
//  Copyright © 2016 Nikita. All rights reserved.
//

/// Phantom type for `nui_left`, `nui_right`, `nui_centerX` relations.

public protocol HorizontalRelation {}

/// Phantom type for `nui_top`, `nui_bottom`, `nui_centerY` relations.

public protocol VerticalRelation {}

/// Phantom type for `nui_height`, `nui_width` relations.

public protocol SizeRelation {}

public final class RelationView<Relation> {

    unowned var view: UIView
    var relationType: RelationType

    init(view: UIView, relation: RelationType) {
        self.view = view
        self.relationType = relation
    }
}

enum SafeAreaType {
    case top
    case left
    case right
    case bottom
}

enum RelationType {
    case bottom
    case top
    case left
    case right
    case width
    case widthTo
    case height
    case heightTo
    case centerX
    case centerY
    case safeArea(SafeAreaType)
}

@available(iOS 11.0, *)
public final class SafeAreaRelationCollection {
    unowned var view: UIView

    public lazy var top: RelationView<VerticalRelation> = .init(view: view, relation: .safeArea(.top))
    public lazy var left: RelationView<HorizontalRelation> = .init(view: view, relation: .safeArea(.left))
    public lazy var right: RelationView<HorizontalRelation> = .init(view: view, relation: .safeArea(.right))
    public lazy var bottom: RelationView<VerticalRelation> = .init(view: view, relation: .safeArea(.bottom))

    init(view: UIView) {
        self.view = view
    }
}

public extension UIView {

    /// Width relation of current view.

    var nui_width: RelationView<SizeRelation> {
        return RelationView(view: self, relation: .width)
    }

    /// Height relation of current view.

    var nui_height: RelationView<SizeRelation> {
        return RelationView<SizeRelation>(view: self, relation: .height)
    }

    /// Left relation of current view.

    var nui_left: RelationView<HorizontalRelation> {
        return RelationView<HorizontalRelation>(view: self, relation: .left)
    }

    /// Right relation of current view.

    var nui_right: RelationView<HorizontalRelation> {
        return RelationView<HorizontalRelation>(view: self, relation: .right)
    }

    /// Top relation of current view.

    var nui_top: RelationView<VerticalRelation> {
        return RelationView<VerticalRelation>(view: self, relation: .top)
    }

    /// Bottom relation of current view.

    var nui_bottom: RelationView<VerticalRelation> {
        return RelationView<VerticalRelation>(view: self, relation: .bottom)
    }

    /// CenterX relation of current view.

    var nui_centerX: RelationView<HorizontalRelation> {
        return RelationView<HorizontalRelation>(view: self, relation: .centerX)
    }

    /// CenterY relation of current view.

    var nui_centerY: RelationView<VerticalRelation> {
        return RelationView<VerticalRelation>(view: self, relation: .centerY)
    }

    /// Safe area

    @available(iOS 11.0, *)
    var nui_safeArea: SafeAreaRelationCollection {
        return SafeAreaRelationCollection(view: self)
    }
}
