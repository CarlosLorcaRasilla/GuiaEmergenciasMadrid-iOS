//
//  TelEmerTableViewController.swift
//  PrimerosAuxsApp
//
//  Created by Carlos Lorca on 26/5/17.
//  Copyright © 2017 Carlos Lorca. All rights reserved.
//

import UIKit
import Parse

class TelefEmerTableViewController: UITableViewController {

   
   
    
    private var telefonosEmer = [Telefonos]()
    
    
    func cargarDatosParse() {
        //Vaciar Array
        telefonosEmer.removeAll(keepingCapacity: true)
        tableView.reloadData()
        
        //Pull info Parse
        let query = PFQuery(className: "Telefonos")
        query.findObjectsInBackground { (objetos, error) in
            
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let objects = objetos {
                for (index, object) in objects.enumerated() {
                    let telefono = Telefonos(pfObject: object)
                    self.telefonosEmer.append(telefono)
                    
                    let indexPath = IndexPath(row: index, section: 0)
                    
                }
            }
        
        }
    
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
        //return telefonosEmer.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

    
        
        //nombreTelTxt.text = telefonosEmer[indexPath.row].nombreTel
        //numeroTelTxt.text = telefonosEmer[indexPath.row].numeroTel
        
        cell.layer.cornerRadius = 6.0
        
        return cell
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
