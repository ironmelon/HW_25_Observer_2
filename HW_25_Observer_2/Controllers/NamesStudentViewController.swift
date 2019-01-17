//
//  NamesStudentViewController.swift
//  HW_25_Observer_2
//
//  Created by Oleg Dynnikov on 10/27/18.
//  Copyright © 2018 Oleg Dynnikov. All rights reserved.
//

import UIKit

class NamesStudentViewController: UIViewController {

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Info"
        nameTextField.delegate = self
        lastNameTextField.delegate = self
        isActiveButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showFacultyVC" else { return }
        guard let destVC = segue.destination as? FacultyStudentViewController else { return }
        destVC.name = nameTextField.text
        destVC.lastName = lastNameTextField.text
     }

    // MARK: - Methods
    private func isActiveButton() {
        continueButton.isEnabled = nameTextField.text == "" || lastNameTextField.text == "" ? false : true
        continueButton.alpha = continueButton.isEnabled ? 1.0 : 0.5
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func hideKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Selectors
    @objc private func handleKeyboardWillShow(_ notification: Notification) {
        view.backgroundColor = .lightGray
    }

    @objc private func handleKeyboardWillHide(_ notification: Notification) {
        view.backgroundColor = .white
        isActiveButton()
    }
}

// MARK: - Extensions
extension NamesStudentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            textField.resignFirstResponder()
            lastNameTextField.becomeFirstResponder()
        } else { hideKeyboard() }
        return true
    }
}
