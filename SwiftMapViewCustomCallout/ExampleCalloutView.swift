//
//  ExampleCalloutView.swift
//  SwiftMapViewCustomCallout
//
//  Created by Robert Ryan on 8/10/16.
//  Copyright © 2015-2016 Robert Ryan. All rights reserved.
//

import UIKit
import MapKit

/// Callout that shows title and subtitle
///
/// This is concrete subclass of `CalloutView` that has two labels. Note, to 
/// have the callout resized appropriately, all this class needed to do was 
/// update is the constraints between these two labels (which have intrinsic 
/// sizes based upon the text contained therein) and the `contentView`. 
/// Autolayout takes care of everything else.
///
/// Note, I've added observers for the `title` and `subtitle` properties of 
/// the annotation view. Generally you don't need to worry about that, but it
/// can be useful if you're retrieving details about the annotation asynchronously
/// but you want to show the pin while that's happening. You just want to make sure
/// that when the annotation's relevant properties are retrieved, that we update
/// this callout view (if it's being shown at all).

class ExampleCalloutView: CalloutView {

    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        
        return label
    }()
    
    var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        return label
    }()
    
    /// Add constraints for subviews of `contentView`
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        let views = ["titleLabel": titleLabel, "subtitleLabel": subtitleLabel]
        
        let vflStrings = [
            "V:|[titleLabel][subtitleLabel]|",
            "H:|[titleLabel]|",
            "H:|[subtitleLabel]|"
        ]
        
        for vfl in vflStrings {
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: vfl, options: [], metrics: nil, views: views))
        }
    }
    
    init(annotation: MKShape) {
        super.init()
        
        configure()
        
        updateContents(for: annotation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Should not call init(coder:)")
    }
    
    /// Update callout contents
    
    private func updateContents(for annotation: MKShape) {
        titleLabel.text = annotation.title ?? "Unknown"
        subtitleLabel.text = annotation.subtitle
    }
    
}
