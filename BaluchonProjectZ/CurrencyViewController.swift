//
//  CurrencyViewController.swift
//  BaluchonProject
//
//  Created by Sofyan Zarouri on 18/07/2022
//  Copyright © 2022 Sofyan Zarouri. All rights reserved.
//
import UIKit

final class CurrencyViewController: UIViewController {
    
    // MARK: - Properties
    
    // création des instances des symboles
    private let fromSymbol = "EUR"
    private let toSymbol = "USD"
    // instance de la classe CurrencyService
    private let currencyService = CurrencyService()
    
    // MARK: - Outlets
    
    @IBOutlet private weak var currencyTextField: UITextField!
    @IBOutlet private weak var currencyResultLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var convertButton: UIButton!
    
    // MARK: - Action to check if there's value to convert
    
    @IBAction private func tappedConvertButton(_ sender: UIButton) {
        guard currencyTextField.text != "", currencyTextField.text != "," else {
            // envoie une alerte pour entrer une valeur à convertir
            alert(title: "Erreur", message: "Veuillez entrer un montant !")
            return
        }
        convertCurrency()
    }
    
    // MARK: - View Life cycle : hide activityIndicator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator(activityIndicator: activityIndicator, button: convertButton, showActivityIndicator: false)
    }
    
    // MARK: - Methods
    
    /// méthode pour convertir
    private func convertCurrency() {
        // change le type de la valeur en Double pour l'appel
        guard let text = currencyTextField.text, let value = Double(text) else { return }
        // affiche l'indicateur d'activité lorsque nous envoyons la requête à l'API
        activityIndicator(activityIndicator: activityIndicator, button: convertButton, showActivityIndicator: true)
        // appelle l'API pour envoyer la requête
        currencyService.getRate { result in
            DispatchQueue.main.async {
                // masque activityIndicator lorsque nous obtenons le résultat
                self.activityIndicator(activityIndicator: self.activityIndicator, button: self.convertButton, showActivityIndicator: false)
                // gère le résultat succès ou échec
                switch result {
                    // affiche la valeur convertie
                case .success(let currency):
                    self.displayWithTwoDecimals(result: currency.convert(value: value, from: self.fromSymbol, to: self.toSymbol))
                    // envoie une alerte indiquant que l'échange ne fonctionne pas
                case .failure:
                    self.alert(title: "Erreur", message: "Veuillez vérifier votre saison et/ou la connexion internet !")
                }
            }
        }
    }
    
    /// méthode pour afficher le résultat avec deux décimales
    private func displayWithTwoDecimals(result: Double){
        let result = String(format: "%.2f", result)
        currencyResultLabel.text = result
    }
}

// MARK: - Extension pour ignorer le clavier

extension CurrencyViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        currencyTextField.resignFirstResponder()
    }
}
