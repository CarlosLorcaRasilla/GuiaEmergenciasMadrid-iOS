//
//  PrimerosAuxiliosTextoTableViewCell.swift
//  PrimerosAuxsApp
//
//  Created by Lazaro Garcia Cruz on 6/6/17.
//  Copyright © 2017 Carlos Lorca. All rights reserved.
//

import UIKit

class PrimerosAuxiliosTextoTableViewCell: UITableViewCell {

   
    @IBOutlet weak var textoTitulo: UILabel!
    @IBOutlet weak var textoCuerpo: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
