//
//  AnnotationManualViewController.swift
//
//  Copyright © 2016 Tokbox, Inc. All rights reserved.
//

import UIKit

class AnnotationManualViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let image = UIImage(named: "mvc") else {
            return;
        }
        let imageView = UIImageView(image: image)
        imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height)
        
        let screenShareView = OTAnnotationScrollView()
        screenShareView.scrollView.contentSize = image.size
        
        screenShareView.addContentView(imageView)
        
        screenShareView.initializeToolbarView()
        screenShareView.toolbarView!.translatesAutoresizingMaskIntoConstraints = false
        
        let height = screenShareView.toolbarView!.bounds.size.height
        self.view.addSubview(screenShareView)
        self.view.addSubview(screenShareView.toolbarView!)
        
        NSLayoutConstraint(item: screenShareView,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
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
        
        let p1 = OTAnnotationPoint(x: 119, andY: 16)
        let p2 = OTAnnotationPoint(x: 122, andY: 16)
        let p3 = OTAnnotationPoint(x: 126, andY: 18)
        let p4 = OTAnnotationPoint(x: 119, andY: 16)
        let p5 = OTAnnotationPoint(x: 144, andY: 28)
        let path = OTAnnotationPath(points: [p1, p2, p3, p4, p5], strokeColor: nil)
        screenShareView.annotationView.addAnnotatable(path)
        
        let p6 = OTAnnotationPoint(x: 160, andY: 16)
        let p7 = OTAnnotationPoint(x: 160, andY: 20)
        let p8 = OTAnnotationPoint(x: 160, andY: 24)
        let p9 = OTAnnotationPoint(x: 160, andY: 26)
        let p10 = OTAnnotationPoint(x: 160, andY: 30)
        let path2 = OTAnnotationPath(points: [p6, p7, p8, p9, p10], strokeColor: UIColor.redColor())
        screenShareView.annotationView.addAnnotatable(path2)
    }
}
