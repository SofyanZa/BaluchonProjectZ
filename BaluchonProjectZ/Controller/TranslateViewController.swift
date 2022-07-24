//
//  TranslateViewController.swift
//  BaluchonProject
//
//  Created by Sofyan Zarouri on 18/07/2022
//  Copyright © 2022 Sofyan Zarouri. All rights reserved.
//

import UIKit

final class TranslateViewController: UIViewController {
    
    // MARK: - Properties
    
    // instance de la classe TranslateService
    private let translateService = TranslateService()
    // instance d'index
    private var index: Int = 0
    // instance du langage de type
    private var language: Language = .fr
    
    // MARK: - Outlets
    
    @IBOutlet private weak var text: UITextField!
    @IBOutlet private weak var translation: UITextView!
    @IBOutlet private weak var pickerView: UIPickerView!
    @IBOutlet private weak var translateButton: UIButton!
    @IBOutlet private weak var translateActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var sourceLanguage: UILabel!
    @IBOutlet private weak var languageTranslation: UILabel!
    @IBOutlet weak var stackViewTranslate: UIStackView!
    
    // MARK: - view life cycle : hide the activity indicator
    
    override func viewDidLoad() {
        // aligner le champ de texte
        text.textAlignment = .natural
        // cache l'indicateur d'activité et le bouton d'affichage
        activityIndicator(activityIndicator: translateActivityIndicator, button: translateButton, showActivityIndicator: false)
        // notifications envoyées par le clavier pour connaître la position et appliquer la méthode pour remonter
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Actions
    
    // action pour gérer les données reçues par l'API, afficher l'indicateur d'activité et masquer le bouton
    
    @IBAction private func didTapeTranslateButton(_ sender: Any) {
        index = pickerView.selectedRow(inComponent: 0)
        guard text.text != "" else {
            alert(title: "Erreur", message: "Aucun texte saisi !")
            return
        }
        activityIndicator(activityIndicator: translateActivityIndicator, button: translateButton, showActivityIndicator: true)
        translateService.translate(language: language, text: text.text ?? "") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let translatedText):
                    self.refreshScreen(data: translatedText, textView: self.translation)
                case .failure:
                    self.alert(title: "Erreur", message: "Veuillez Vérifier votre saisie et la connexion internet !")
                }
                self.activityIndicator(activityIndicator: self.translateActivityIndicator, button: self.translateButton, showActivityIndicator: false)
            }
        }
    }
    
    // MARK: - Methods
    
    /// Méthode pour déplacer la vue vers le haut avec le clavier
    @objc
    private func keyboardWillChange(notification: NSNotification) {
        if let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
            as? NSValue)?.cgRectValue {
            if notification.name == UIResponder.keyboardWillShowNotification ||
                notification.name == UIResponder.keyboardWillChangeFrameNotification {
                if let tabBarHeight = tabBarController?.tabBar.frame.height {
                    view.frame.origin.y = -(keyboardRect.height - tabBarHeight)
                }
            } else {
                view.frame.origin.y = 0
            }
        }
    }
    
    /// méthode pour changer la langue de l'étiquette pour qu'elle corresponde au pickerView sélectionné
    private func changeLanguage(index: Int) {
        switch index {
        case 0:
            sourceLanguage.text = "Français"
            languageTranslation.text = "Anglais"
            language = .fr
        case 1:
            sourceLanguage.text = "Anglais"
            languageTranslation.text = "Français"
            language = .en
        case 2:
            sourceLanguage.text = "Detection"
            languageTranslation.text = "Français"
            language = .detect
        default:
            break
        }
    }
    
    /// Méthode pour afficher le résultat de la traduction dans le textView
    private func refreshScreen(data: Translate, textView: UITextView) {
        textView.text = data.data.translations[0].translatedText
        textView.centerVertically()
    }
}

// MARK: - Extension for pickerView

extension TranslateViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    // méthode pour retourner la colonne du numéro de l'UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // méthode pour retourner le nombre de lignes dans le UIPickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return translateService.language.count
    }
    
    // méthode pour retourner la valeur correspondant au pickerView, changer la couleur du texte en blanc
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        changeLanguage(index: row)
        return NSAttributedString(string: translateService.language[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}

// MARK: - Extension to dismiss Keyboard

extension TranslateViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        text.resignFirstResponder()
    }
}


