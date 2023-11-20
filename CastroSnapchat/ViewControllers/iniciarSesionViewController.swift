//
//  ElegirUsuarioViewController.swift
//  CastroSnapchat
//
//  Created by Estefany Castro on 14/11/23.
//
import UIKit
import Firebase
import GoogleSignIn
import FirebaseDatabase
class iniciarSesionViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            print("Intentando Iniciar Sesion")
            
            if error != nil {
                print("Se presento el siguiente error: \(error)")
                
                let alert = UIAlertController(title: "Error de inicio de sesión", message: "Usuario no encontrado. ¿Desea crear un nuevo usuario?", preferredStyle: .alert)
                
                let createButton = UIAlertAction(title: "Crear", style: .default) { _ in
                    // Presenta la pantalla para la creación de un nuevo usuario
                    self.performSegue(withIdentifier: "crearUsuarioSegue", sender: nil)
                }
                
                let cancelButton = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
                
                alert.addAction(createButton)
                alert.addAction(cancelButton)
                
                self.present(alert, animated: true, completion: nil)
                
            } else {
                print("Inicio de sesion exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        }
    }
    
    @IBAction func iniciarSesionConGoogleTapped(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Inicia el flujo de inicio de sesión con Google
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            if let error = error {
                print("Error al iniciar sesión con Google: \(error.localizedDescription)")
            } else if let user = result?.user,
                      let idToken = user.idToken?.tokenString {
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
                
                // Inicia sesión en Firebase con las credenciales de Google
                Auth.auth().signIn(with: credential) { _, firebaseError in
                    if let firebaseError = firebaseError {
                        print("Error al iniciar sesión en Firebase: \(firebaseError.localizedDescription)")
                    } else {
                        print("Inicio de sesión en Firebase exitoso")
                        // Realiza cualquier acción adicional que necesites después del inicio de sesión.
                    }
                }
            }
        }
    }
    
}
