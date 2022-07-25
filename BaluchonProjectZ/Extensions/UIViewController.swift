//
//  UIViewController.swift
//  BaluchonProject
//
//  Created by Sofyan Zarouri on 18/07/2022
//  Copyright © 2022 Sofyan Zarouri. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    // MARK: - Methods
    
    /// méthode pour afficher une alerte
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    /// convertit le paramètre reçu en chaîne
    func convertToString(value: Float) -> String {
        return String(value)
    }
    
    /// méthode appelée pour gérer ensemble le bouton et le contrôleur d'activité : true pour masquer le bouton et afficher l'indicateur d'activité / false pour afficher le bouton et masquer le contrôleur d'activité
    func activityIndicator(activityIndicator: UIActivityIndicatorView, button: UIButton, showActivityIndicator: Bool){
        activityIndicator.isHidden = !showActivityIndicator
        button.isHidden = showActivityIndicator
    }
}
