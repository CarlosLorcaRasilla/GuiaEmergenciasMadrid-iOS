//
//  PrimerosAuxViewController.swift
//  PrimerosAuxsApp
//
//  Created by Carlos Lorca on 31/5/17.
//  Copyright © 2017 Carlos Lorca. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu
import Parse

public enum TipoPrimerosAuxilios : Int {
    
    case paroCardiaco
    case asfixia
    case ictus
    case hemorragia
    case quemadura
    case golpeCalor
    case comaEtilico
    case desmayo
    case esguince
    
}

class PrimAuxComponenteTexto {
    
    var titulo = ""
    var texto = ""
    
    init(titulo: String, texto: String) {
        self.titulo = titulo
        self.texto = texto
    }
    
}

class PrimAuxComponenteGeneral {
    
    public var imagen: PFFile?
    public var enlace = ""
    
    init(imagen: PFFile, enlace: String) {
        self.imagen = imagen
        self.enlace = enlace
    }
    
}

class PrimerosAuxViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    var tipoSeleccionados: TipoPrimerosAuxilios!
    private var listaPrimerosAuxilios = [PrimAux]()
    private var listaComponentesTabla = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Efecto a la imagen (Blur effect)
        background.image =  UIImage(named: "olaBackground")
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        background.addSubview(blurEffectView)
        
        
        
        cargarPrimerosAuxiliosDesdeParse()
        prepararTabla()
        
        //Selector
        let items = ["Paro Cardiaco", "Asfixia", "Ictus", "Hemorragia", "Quemadura", "Golpe de Calor", "Coma Etilico", "Lipotimia o Desmayo", "Esguince o Fracturas"]
        
        let menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: "Seleccione Primer Auxilio", items: items as [AnyObject])
        
        self.navigationItem.titleView = menuView
        
        menuView.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
            
            print("Did select item at index: \(indexPath)")
        
            self?.tipoSeleccionados = TipoPrimerosAuxilios(rawValue: indexPath)
            
            self?.cargarPrimerosAuxiliosDesdeParse()
            self?.prepararTabla()
            
            
            menuView.removeFromSuperview()
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
     Este metodo se encarga de establecer las propiedades de la tabla
     */
    func prepararTabla() {
        
        tableView.allowsSelection = false
        
        //Eliminamos el footer para que no se vean lineas de mas
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //Propiedades del alto de las celdas
        tableView.estimatedRowHeight = 150.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //El scroll sera del tipo lento para facilitar la vision de los elementos
        tableView.decelerationRate = UIScrollViewDecelerationRateFast
        
    }
    
    /*
     Devuelve el numero de elementos de la lista
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaComponentesTabla.count
    }
    
    /*
     Este metodo configura la representacion visual de cada una de las filas de la tabla
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
            case 0...1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellTexto", for: indexPath) as! PrimerosAuxiliosTextoTableViewCell
                let componente = listaComponentesTabla[indexPath.row] as! PrimAuxComponenteTexto
                cell.textoTitulo.text = componente.titulo
                cell.textoCuerpo.text = componente.texto
                
                cell.layer.cornerRadius = 4.0
                cell.backgroundColor = UIColor(red: 187/255, green: 255/255, blue: 174/255, alpha: 1)
                
                return cell
            
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellGeneral", for: indexPath) as! PrimerosAuxiliosGeneralTableViewCell
                let componente = listaComponentesTabla[indexPath.row] as! PrimAuxComponenteGeneral
                if let featureImage = componente.imagen {
                    featureImage.getDataInBackground(block: { (imageData, error) in
                        if let tripImageData = imageData {
                            cell.imagen.image = UIImage(data: tripImageData)
                        }
                    })
                }
                
                cell.layer.cornerRadius = 4.0
                cell.backgroundColor = UIColor(red: 187/255, green: 255/255, blue: 174/255, alpha: 1)
                
                cell.textoEnlace = componente.enlace

            default:
                print("")
                break
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTexto", for: indexPath) as! PrimerosAuxiliosTextoTableViewCell
        return cell
        
    }
    
    //Este metodo determina la altura de cada una de las filas de la tabla
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 || indexPath.row == 1 {
            return UITableViewAutomaticDimension
        }
        
        return 250
        
    }
    
    func cargarPrimerosAuxiliosDesdeParse() {
        
        //Vaciar el Array
        listaPrimerosAuxilios.removeAll(keepingCapacity: true)
        //listaComponentesTabla.removeAll(keepingCapacity: true)
        
        //Pull de la info en parse
        let query = PFQuery(className: "PrimerosAux")
        query.cachePolicy = PFCachePolicy.networkElseCache
        query.findObjectsInBackground { (object, error) in
            
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let object = object {

                for (_, object) in object.enumerated() {
                    
                    //Parse nos devuelve un PFObject
                    //Tenemos que convertir el PFObject a un objeto de nuestra clase
                    let primAux = PrimAux(pfObject: object)
                    
                    if primAux.tipoPrimAux == self.tipoSeleccionados {
                        self.listaPrimerosAuxilios.append(primAux)
                        let componenteSintomas = PrimAuxComponenteTexto(titulo: "Sintomas", texto: primAux.sintomasPA)
                        let componentePasos = PrimAuxComponenteTexto(titulo: "Pasos a seguir", texto: primAux.quehacerPA)
                        let componenteGeneral = PrimAuxComponenteGeneral(imagen: primAux.imagenPA!, enlace: primAux.linkvideoPA)
                        self.listaComponentesTabla.append(componenteSintomas)
                        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .none)
                        self.listaComponentesTabla.append(componentePasos)
                        self.tableView.insertRows(at: [IndexPath(row: 1, section: 0)], with: .none)
                        self.listaComponentesTabla.append(componenteGeneral)
                        self.tableView.insertRows(at: [IndexPath(row: 2, section: 0)], with: .none)
                    }
                    
                }
            }
            
        }
        
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
 
