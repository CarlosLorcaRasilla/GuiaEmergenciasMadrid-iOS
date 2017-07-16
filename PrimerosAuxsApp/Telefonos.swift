//
//  Telefonos.swift
//  PrimerosAuxsApp
//
//  Created by Carlos Lorca on 26/5/17.
//  Copyright © 2017 Carlos Lorca. All rights reserved.
//

import Foundation
import UIKit
import Parse


struct Telefonos {
    
    var telfId = ""
    var nombreTel = ""
    var numeroTel = ""
    var imagenTel: PFFile? 
    
    init(telfId: String, nombreTel: String, numeroTel: String, imagenTel: PFFile!) {
        
        self.telfId = telfId
        self.nombreTel = nombreTel
        self.numeroTel = numeroTel
        self.imagenTel = imagenTel
        
    }
    
    
    init(pfObject: PFObject) {
        
        self.telfId = pfObject.objectId!
        self.nombreTel = pfObject["nombreTel"] as! String
        self.numeroTel = pfObject["numeroTel"] as! String
        self.imagenTel = pfObject["imagenTel"] as! PFFile!
        
    }
    
    
    func toPFObject() -> PFObject {
        
        let telObject = PFObject(className: "Telefonos")
        telObject.objectId = telfId
        telObject["nombreTel"] = nombreTel
        telObject["numeroTel"] = numeroTel
        telObject["imagenTel"] = imagenTel
        
        return telObject
        
    }
    
}


