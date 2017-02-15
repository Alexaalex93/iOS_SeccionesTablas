//
//  AnimalTableViewController.swift
//  IndexedTableDemo
//
//  Created by Pablo Mateo Fernández on 27/01/2017.
//  Copyright © 2017 355 Berry Street S.L. All rights reserved.
//

import UIKit

class AnimalTableViewController: UITableViewController {
    let animals = ["Bear", "Black Swan", "Buffalo", "Camel", "Cockatoo", "Dog", "Donkey", "Emu", "Giraffe", "Greater Rhea", "Hippopotamus", "Horse", "Koala", "Lion", "Llama", "Manatus", "Meerkat", "Panda", "Peacock", "Pig", "Platypus", "Polar Bear", "Rhinoceros", "Seagull", "Tasmania Devil", "Whale", "Whale Shark", "Wombat"]
    
    let animales: [String:[String]] = ["B":["Bear", "Black Swan", "Bufalo"]]
    
    let animalSectionTitles = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    var animalesDict = [String:[String]] ()
    var animalesTituloSeccion = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        crearDiccAnimales()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        crearDiccAnimales()
    }
    
    
    
    
    
    
    //CREA LOS DICCIONARIOS CON LOS ANIMALES Y SUS CLAVES
    func crearDiccAnimales() {
    
        for animal in animals {
        
            //Coger la primera letra de uno y crear un dicionario
            
            //Necesitas crear un string.index para acceder al substring en vez de poner un entero como en java.
            let indexPrimeraLetra = animal.index(animal.startIndex, offsetBy: 1)
            let animalKey = animal.substring(to: indexPrimeraLetra)
            
            //let primeraLetra = animal.characters.first
            
            if var valorAnimales = animalesDict[animalKey]{ //Compruebo si existe la clave con if var
                
                valorAnimales.append(animal) //Si no existe la pongo
                animalesDict[animalKey] = valorAnimales//Y añado el animal
                
            } else {
            
                animalesDict[animalKey] = [animal] //Si existe añado el animal solo
            
            }
            
        
        }
        //Secciones
        animalesTituloSeccion = [String](animalesDict.keys)
        animalesTituloSeccion = animalesTituloSeccion.sorted(by: { (s1, s2) -> Bool in
        return s1 < s2
        })
        
        //animalesTituloSeccion = animalesTituloSeccion.sorted(by: { $0 < $1        })
    
    }
    

    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return animalesTituloSeccion.count //Antes era una seccion y ahora queremos tantas como titulos tengamos
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return animalesTituloSeccion[section]
    }
    
    //CREA UNA BARRA LATERAL CON LETRAS
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? { //Esta funcion sirve para poner la barra lateral con las letras
        return animalSectionTitles
    }
    
    //HACE QUE AL PINCHAR LA BARRA LATERAL TE LLEVE A LA SECCION CORRECTA
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        
        guard let index = animalesTituloSeccion.index(of: title)//Mira en el array que teniamos y lo comprueba con los titulos. Si existe devuelve index y si no -1
            else {
            return -1
        }
        return index
    }
    
    
    //MODIFICA EL TAMAÑO DE LAS SECCIONES
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        
        
        
        //SI QUIERES PONER LA SECCION A TU GUSTO CREARIAS UNA CLASE COMO HACEMOS CON LAS CELDAS DE TIPO UIVIEW Y LA LLAMARIAMOS DONDE PONEMOS view as! UITABLEViewHeaderFooterView POR EJEMPLO view as! UITableViewMiCeldaCustomizada
        
        
        
        headerView.backgroundView?.backgroundColor = UIColor(red: 231.0/255.0, green: 240.0/255.0, blue: 241.0/255.0, alpha: 1.0)
        headerView.textLabel?.font = UIFont(name: "Avenir", size: 27.0)
    }
    
    
    //RETORNA EL NUMERO DE FILAS POR SECCIONES
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        
        let animalKey = animalesTituloSeccion[section]
        
        guard let animalesValor = animalesDict[animalKey] else { //Comprueba si existe y si no llama a else. Es como un try catch
            return 0
        }
        return animalesValor.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        let animalKey = animalesTituloSeccion[indexPath.section] //Entramos en el array en la posicion donde nos encontremos en el tableview
        if let animalValues = animalesDict[animalKey]{ //Accedemos al diccionario con la clave que hemos cogido arriba
        
            cell.textLabel?.text = animalValues[indexPath.row] //Ahor le ponemos como texto el valor que haya en ese array
            
            let imageFileName = animalValues[indexPath.row].lowercased().replacingOccurrences(of: " ", with: "_") //Cogemos el nombre del animal, le quitamos el espacio y le ponemos un "_" que asi se llaman el nombre de las imagenes
            cell.imageView?.image = UIImage(named: imageFileName)
        
        }
        
        
        
        return cell
    }


}
