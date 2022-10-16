//
//  AlretVC.swift
//  Core Data
//
//  Created by Hassan on 20/05/2022.
//

import UIKit

class AlretVC: UIAlertController {

 

    func erorrAlert(message:String)
    {
        let alert = UIAlertController(title: "Erorr", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}
