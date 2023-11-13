//
//  ViewController.swift
//  CastroSnapchat
//
//  Created by Estefany Castro on 7/11/23.
//

import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn

class iniciarSesionViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password:
                            passwordTextField.text!) { (user, error) in
            print("Intentando Iniciar Sesion")
            if error != nil{
                print("Se presento el siguient error: \(error)")
            }else{
                print("Inicio de sesion exitoso")
            }
        }
        
    }
    
    
    @IBAction func iniciarSesionConGoogleTapped(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self)
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print("Error en el inicio de sesión con Google: \(error.localizedDescription)")
            return
        }

        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("Error: No se pudo obtener el clientID de FirebaseApp")
            return
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

     
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                print("Error en el inicio de sesión con Google: \(error!.localizedDescription)")
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print("Error: No se pudo obtener la información del usuario de Google")
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)

        }
    }

}
