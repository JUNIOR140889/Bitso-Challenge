//
//  AlertSlidePresentationController.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/13/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import UIKit

class SlidePresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            guard let theView = containerView else { return CGRect.zero }
            let safeAreaTop = UIApplication.shared.windows[0].safeAreaInsets.top
            return CGRect(x: 0,
                          y: theView.bounds.height * 0.1 + safeAreaTop,
                          width: theView.bounds.width,
                          height: theView.bounds.height * 0.9 - safeAreaTop)
        }
    }

    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
}
