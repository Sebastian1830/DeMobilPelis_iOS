//
//  UIViewController.swift
//  MobilPelis
//
//  Created by Sebastian Soto Varas on 2/04/22.
//

import UIKit

extension UIViewController {
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func segueTo(storyboard name: String, controller identifier: String, presentation: UIModalPresentationStyle, transition: UIModalTransitionStyle) {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: identifier)
        
        vc.modalPresentationStyle = presentation
        vc.modalTransitionStyle = transition
        
        present(vc, animated: true, completion: nil)
    }
}
