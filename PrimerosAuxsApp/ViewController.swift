//
//  ViewController.swift
//  PrimerosAuxsApp
//
//  Created by Carlos Lorca on 16/5/17.
//  Copyright © 2017 Carlos Lorca. All rights reserved.
//

import UIKit

extension UIView {
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
}

class ViewController: UIViewController {


    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var background: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Efecto a la imagen (Blur effect)
        background.image =  UIImage(named: "cascadaBackground")
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        background.addSubview(blurEffectView)
        
        //self.navigationController?.navigationBar.barTintColor = UIColor.clear.withAlphaComponent(1)
        self.navigationController?.navigationBar.isOpaque = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

