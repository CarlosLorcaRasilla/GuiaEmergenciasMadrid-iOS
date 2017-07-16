//
//  SelectorMapasViewController.swift
//  PrimerosAuxsApp
//
//  Created by Carlos Lorca on 15/6/17.
//  Copyright © 2017 Carlos Lorca. All rights reserved.
//

import UIKit

class SelectorMapasViewController: UIViewController {
    
    @IBOutlet weak var background: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Efecto a la imagen (Blur effect)
        background.image =  UIImage(named: "olaBackground")
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        background.addSubview(blurEffectView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
