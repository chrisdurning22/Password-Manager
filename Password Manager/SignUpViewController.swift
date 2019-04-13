//
//  SignUpViewController.swift
//  Password Manager
//
//  Created by Chris Durning on 05/10/2018.
//  Copyright © 2018 Chris Durning. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var rePasswordTextField: UITextField!
    
    @IBOutlet weak var signalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isEqualToString(pass:String, confirmPass:String) -> Bool {
        return pass == confirmPass
    }
    
    @IBAction func pressSignUp(_ sender: Any) {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let confirmPassword = rePasswordTextField.text else { return }
        
        let postString = "&a=\(email)&b=\(password)"
        
        guard let url = URL(string: "http://178.128.38.155/insert.php") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, errorif) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            
            let dataAsString = String(data: data, encoding: .utf8)
            print(dataAsString)
            
        }.resume()
        
        updateSignalInformation(email: email, pass: password, conf: confirmPassword)
    }
    
    func updateSignalInformation(email:String, pass:String, conf: String) {
        self.signalLabel.text = ""
        
        if(!isValidEmail(testStr: email)) {
            self.signalLabel.text = "The email address that you've entered is not valid. Please enter a valid email address."
        } else if (!isEqualToString(pass: pass, confirmPass: conf)) {
            self.signalLabel.text = "The passwords you've entered do not match."
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
