//
//  HapinessViewController.swift
//  Hapiness
//
//  Created by Valentina Henao on 10/9/15.
//  Copyright © 2015 Valentina Henao. All rights reserved.
//

import UIKit


class HapinessViewController: UIViewController, FaceViewDataSource {
   
    private struct Constants {
        static let happinessGestureScale: CGFloat = 4
    }
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.happinessGestureScale)
            if happinessChange != 0 {
            hapiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }
    @IBOutlet weak var faceView: FaceView! {
        didSet {
        faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
    
    var hapiness = 100 { didSet {
        hapiness = min(max(hapiness, 0), 100)
        print("Hapiness = \(hapiness)")
        updateUI()
    }
    }
    func updateUI() {
        faceView.setNeedsDisplay()
    }
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(hapiness-50)/50
    }
}   
