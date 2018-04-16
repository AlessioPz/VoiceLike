//
//  UIViewController.swift
//  VoiceLike
//
//  Created by Alessio Papazzoni on 01/02/18.
//  Copyright © 2018 bussolalabs. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertOk(title: String? = nil, message: String? = nil, onDismiss: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { _ in
            onDismiss?()
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}
