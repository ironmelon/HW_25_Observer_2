//
//  FacultyStudentViewController.swift
//  HW_25_Observer_2
//
//  Created by Oleg Dynnikov on 10/27/18.
//  Copyright © 2018 Oleg Dynnikov. All rights reserved.
//

import UIKit

class FacultyStudentViewController: UIViewController {

    @IBOutlet private weak var facultyTextField: UITextField!
    @IBOutlet private weak var continueButton: UIButton!
    
    var name: String?
    var lastName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "University Data"
        facultyTextField.delegate = self
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
        guard segue.identifier == "showDetailVC" else { return }
        guard let destVC = segue.destination as? DetailStudentViewController else { return }
        let student = Student(name: name ?? "Error", lastName: lastName ?? "Error", faculty: facultyTextField.text ?? "Error")
        destVC.student = student
    }

    // MARK: - Methods
    private func hideKeyboard() {
        view.endEditing(true)
    }

    private func isActiveButton() {
        continueButton.isEnabled = facultyTextField.text == "" ? false : true
        continueButton.alpha = continueButton.isEnabled ? 1.0 : 0.5
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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

// MARK: - TextFieldDelegate
extension FacultyStudentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
}
