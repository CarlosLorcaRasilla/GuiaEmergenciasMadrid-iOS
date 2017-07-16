//
//  TestViewController.swift
//  PrimerosAuxsApp
//
//  Created by Lazaro Garcia Cruz on 6/6/17.
//  Copyright © 2017 Carlos Lorca. All rights reserved.
//

import UIKit
import Parse

class InformacionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate  {
    
    @IBOutlet weak var backgroundImag: UIImageView!
    @IBOutlet weak var collectionViewTelefonos: UICollectionView!
    @IBOutlet weak var collectionViewHospitales: UICollectionView!
    
    private var telefonos = [Telefonos]()
    private var hospitales = [Hospitales]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.collectionViewTelefonos.delegate = self
        self.collectionViewHospitales.delegate = self
        
        //Efecto a la imagen (Blur effect)
        backgroundImag.image =  UIImage(named: "cascadaBackground")
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImag.addSubview(blurEffectView)
        
        collectionViewTelefonos.backgroundColor = UIColor.clear
        collectionViewTelefonos.tag = 1
        collectionViewHospitales.backgroundColor = UIColor.clear
        collectionViewHospitales.tag = 2
        
        cargarTelefonosDesdeParse()
        cargarHospitalesDesdeParse()

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 2 {
            return hospitales.count
        }
        
         return telefonos.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        
        if collectionView.tag == 2 {
        
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellHospitales", for: indexPath) as! HospitalesEspCollectionViewCell
            
            //Configuramos la celda hospitales
            cell.nombreHosp.text = hospitales[indexPath.row].nombreHosp
            cell.especialidadHosp.text = hospitales[indexPath.row].especialidadHosp
            cell.direccionHosp.text = hospitales[indexPath.row].direccionHosp
            cell.numeroHosp.text = hospitales[indexPath.row].numeroHosp
            
            
            //Cargar imagen
            cell.imagenHosp.image = UIImage()
            if let featureImage = hospitales[indexPath.row].imagenHosp {
                featureImage.getDataInBackground(block: { (imageData, error) in
                    if let tripImageData = imageData {
                        cell.imagenHosp.image = UIImage(data: tripImageData)
                    }
                })
            }
            
            cell.layer.cornerRadius = 4.0
        
            return cell
            
        }
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellTelefonos", for: indexPath) as! TelefonosCollectionViewCell
        
        //Configuramos la celda telefonos
        cell.nombreTel.text = telefonos[indexPath.row].nombreTel
        cell.numeroTel.text = telefonos[indexPath.row].numeroTel
        
        //Cargar imagen
        cell.imagenTel.image = UIImage()
        if let featureImage = telefonos[indexPath.row].imagenTel {
            featureImage.getDataInBackground(block: { (imageData, error) in
                if let tripImageData = imageData {
                    cell.imagenTel.image = UIImage(data: tripImageData)
                }
            })
        }
            
        cell.layer.cornerRadius = 4.0
        
        return cell
  
    }

    
    
    func cargarTelefonosDesdeParse() {
        
        //Vaciar el Array
        telefonos.removeAll(keepingCapacity: true)
        
        //Pull de la info en parse
        
        let query = PFQuery(className: "Telefonos")
        //query.cachePolicy = PFCachePolicy.networkElseCache
        query.findObjectsInBackground { (object, error) in
            
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let object = object {
                print("Ha entrado")
                for (index, object) in object.enumerated() {
                    //Parse nos devuelve un PFObject
                    //Tenemos que convertir el PFObject a un objeto de nuestra clase Viajes
                    let telefono = Telefonos(pfObject: object)
                    self.telefonos.append(telefono)
                    
                    let indexPath = IndexPath(row: index, section: 0)
                    self.collectionViewTelefonos.insertItems(at: [indexPath])
                    
                }
            }
            
        }
        collectionViewTelefonos.reloadData()

    }
    
 
    
    func cargarHospitalesDesdeParse() {
        //Vaciar el Array
        hospitales.removeAll(keepingCapacity: true)
        
        
        //Pull de la info en parse
        let query = PFQuery(className: "Hospitales")
        query.cachePolicy = PFCachePolicy.networkElseCache
        query.findObjectsInBackground { (object, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let object = object {
                print("Ha entrado")
                for (index, object) in object.enumerated() {
                    //Parse nos devuelve un PFObject
                    //Tenemos que convertir el PFObject a un objeto de nuestra clase Viajes
                    let hospital = Hospitales(pfObject: object)
                    self.hospitales.append(hospital)
                    
                    let indexPath = IndexPath(row: index, section: 0)
                    self.collectionViewHospitales.insertItems(at: [indexPath])
                    
                }
                
            }
            
        }
        collectionViewHospitales.reloadData()
    }
   
}

    
