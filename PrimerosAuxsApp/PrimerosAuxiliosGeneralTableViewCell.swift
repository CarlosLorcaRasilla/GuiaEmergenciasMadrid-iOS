//
//  PrimerosAuxiliosGeneralTableViewCell.swift
//  PrimerosAuxsApp
//
//  Created by Lazaro Garcia Cruz on 6/6/17.
//  Copyright © 2017 Carlos Lorca. All rights reserved.
//

import UIKit
import SafariServices


class PrimerosAuxiliosGeneralTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imagen: UIImageView!
    var textoEnlace: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func cargarEnlace(_ sender: Any) {
        
        guard let url = URL(string: textoEnlace!) else {
            // not a valid URL
            return
        }
        
        if ["http", "https"].contains(url.scheme?.lowercased() ?? "") {
            // Can open with SFSafariViewController
            let safariViewController = SFSafariViewController(url: url)
            if let viewController = self.parentViewController as? PrimerosAuxViewController {
                viewController.present(safariViewController, animated: true, completion: nil)
            }
        } else {
            // Scheme is not supported or no scheme is given, use openURL
            var modifiedURLString = String(format:"http://%@", url.absoluteString)
            let safariViewController = SFSafariViewController(url: URL(string: modifiedURLString)!)
            if let viewController = self.parentViewController as? PrimerosAuxViewController {
                viewController.present(safariViewController, animated: true, completion: nil)
            }
        }

        
    }

}
