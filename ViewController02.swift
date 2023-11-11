//
//  ViewController02.swift
//  CastroSnapchat
//
//  Created by Estefany Castro on 8/11/23.
//

import UIKit
import Firebase

class ViewController02: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func crearNodosButtonTapped(_ sender: Any) {
        let ref = Database.database().reference()
   
        let usuariosData: [String: Any] = [
                "usuario1": [
                    "nombre": "Usuario 1",
                    "detalle": [
                        "edad": 25,
                        "email": "usuario1@email.com"

                    ]
                ],
                "usuario2": [
                    "nombre": "Usuario 2",
                    "detalle": [
                        "edad": 30,
                        "email": "usuario2@email.com"
                    ]
                ]
            ]

            // Enviar los datos a la base de datos
            ref.child("usuarios").updateChildValues(usuariosData)
        }
}
    
