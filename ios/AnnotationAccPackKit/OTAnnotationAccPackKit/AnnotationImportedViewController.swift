//
//  AnnotationImportedViewController.swift
//
//  Copyright © 2016 Tokbox, Inc. All rights reserved.
//

import UIKit

class AnnotationImportedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        extendedLayoutIncludesOpaqueBars = true
        
        guard let image = UIImage(named: "mvc") else {
            return;
        }
        let imageView = UIImageView(image: image)
        imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let screenShareView = OTAnnotationScrollView()
        screenShareView.scrollView.contentSize = image.size
        
        screenShareView.addContentView(imageView)
        
        screenShareView.initializeToolbarView()
        screenShareView.toolbarView!.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(screenShareView)
        self.view.addSubview(screenShareView.toolbarView!)
        
        NSLayoutConstraint(item: screenShareView,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: 0).active = true
        
        NSLayoutConstraint(item: screenShareView,
                           attribute: .Left,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .Left,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: screenShareView,
                           attribute: .Right,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .Right,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: screenShareView,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: screenShareView.toolbarView!,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        let height = screenShareView.toolbarView!.bounds.size.height
        NSLayoutConstraint(item: screenShareView.toolbarView!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: screenShareView.toolbarView!,
                           attribute: .Left,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .Left,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: screenShareView.toolbarView!,
                           attribute: .Right,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .Right,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: screenShareView.toolbarView!,
                           attribute: .Height,
                           relatedBy: .Equal,
                           toItem: nil,
                           attribute: .NotAnAttribute,
                           multiplier: 1.0,
                           constant: height).active = true
    }
}
