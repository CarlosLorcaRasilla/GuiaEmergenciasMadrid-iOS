//
//  PrimAux.swift
//  PrimerosAuxsApp
//
//  Created by Carlos Lorca on 31/5/17.
//  Copyright © 2017 Carlos Lorca. All rights reserved.
//

import Foundation
import UIKit
import Parse

struct PrimAux {
    
    var PrimAuxId = ""
    var nombrePA = ""
    var sintomasPA = ""
    var quehacerPA = ""
    var linkvideoPA = ""
    var tipoPrimAux: TipoPrimerosAuxilios?
    var imagenPA: PFFile?
    
    init(PrimAuxId: String, nombrePA: String, sintomasPA: String, quehacerPA: String, linkvideoPA: String, tipo: Int, imagenPA: PFFile!) {
        
        self.PrimAuxId = PrimAuxId
        self.nombrePA = nombrePA
        self.sintomasPA = sintomasPA
        self.quehacerPA = quehacerPA
        self.linkvideoPA = linkvideoPA
        self.tipoPrimAux = TipoPrimerosAuxilios(rawValue: tipo)
        self.imagenPA = imagenPA
        
    }
    
    init(pfObject: PFObject) {
        
        self.PrimAuxId = pfObject.objectId!
        self.nombrePA = pfObject["nombrePA"] as! String
        self.sintomasPA = pfObject["sintomasPA"] as! String
        self.quehacerPA = pfObject["quehacerPA"] as! String
        self.linkvideoPA = pfObject["linkvideoPA"] as! String
        self.tipoPrimAux = TipoPrimerosAuxilios(rawValue: pfObject["tipo"] as! Int)
        self.imagenPA = pfObject["imagenPA"] as! PFFile!
        
    }
    
    func toPFObject() -> PFObject {
        
        let primAuxObject = PFObject(className: "Telefonos")
        primAuxObject.objectId = PrimAuxId
        primAuxObject["nombrePA"] = nombrePA
        primAuxObject["sintomasPA"] = sintomasPA
        primAuxObject["quehacerPA"] = quehacerPA
        primAuxObject["linkvideoPA"] = linkvideoPA
        primAuxObject["tipo"] = tipoPrimAux?.rawValue
        primAuxObject["imagenPA"] = imagenPA
        
        return primAuxObject
        
    }
    
}


