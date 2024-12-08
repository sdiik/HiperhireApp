//
//  BottomSheetViewController.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 07/12/24.
//

import UIKit

protocol BottomSheetDelegate: AnyObject {
    func bottomSheetDidDismiss()
}

class BottomSheetViewController: UIViewController {
    weak var delegate: BottomSheetDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 16
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(dismissBottomSheet))
        view.addGestureRecognizer(dismissGesture)

    }
    
    @objc private func dismissBottomSheet() {
        dismiss(animated: true) { [weak self] in
            guard let self else { return }
            self.delegate?.bottomSheetDidDismiss()
        }
    }
}

class BottomSheetPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        let height: CGFloat = containerView.bounds.height * 0.2
        return CGRect(
            x: 0,
            y: containerView.bounds.height - height,
            width: containerView.bounds.width,
            height: height
        )
    }

    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
}
