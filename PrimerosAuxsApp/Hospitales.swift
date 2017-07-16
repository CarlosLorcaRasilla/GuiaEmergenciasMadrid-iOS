//
//  Hospitales.swift
//  PrimerosAuxsApp
//
//  Created by Carlos Lorca on 5/6/17.
//  Copyright © 2017 Carlos Lorca. All rights reserved.
//

import Foundation
import UIKit
import Parse

struct Hospitales {
    
    var hospitalID = ""
    var nombreHosp = ""
    var especialidadHosp = ""
    var direccionHosp = ""
    var numeroHosp = ""
    var imagenHosp: PFFile?
    
    
    init(hospitalID: String, nombreHosp: String, especialidadHosp: String, direccionHosp: String, numeroHosp: String, imagenHosp: PFFile!) {
        self.hospitalID = hospitalID
        self.nombreHosp = nombreHosp
        self.especialidadHosp = especialidadHosp
        self.direccionHosp = direccionHosp
        self.numeroHosp = numeroHosp
        self.imagenHosp = imagenHosp

    }
    
    init(pfObject: PFObject) {
        
        //Coger los datos del Parse. Si es una variable creada de sistema se puede coger directamente pero si es una nuestra hay que cogerla como si fuera un JSON y pasarla al tipo de la nuestra
        
        self.hospitalID = pfObject.objectId!
        self.nombreHosp = pfObject["nombreHosp"] as! String
        self.especialidadHosp = pfObject["especialidadHosp"] as! String
        self.direccionHosp = pfObject["direccionHosp"] as! String
        self.numeroHosp = pfObject["numeroHosp"] as! String
        self.imagenHosp = pfObject["imagenHosp"] as! PFFile!
    }
    
    func toPfObject() -> PFObject {
        let hospitalObject = PFObject(className: "Hospitales")
        hospitalObject.objectId = hospitalID
        hospitalObject["nombreHosp"] = nombreHosp
        hospitalObject["especialidadHosp"] = especialidadHosp
        hospitalObject["direccionHosp"] = direccionHosp
        hospitalObject["numeroHosp"] = numeroHosp
        hospitalObject["imagenHosp"] = imagenHosp
        
        return hospitalObject
    }
    
}
