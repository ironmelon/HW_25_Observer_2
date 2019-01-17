//
//  DetailStudentViewController.swift
//  HW_25_Observer_2
//
//  Created by Oleg Dynnikov on 10/27/18.
//  Copyright © 2018 Oleg Dynnikov. All rights reserved.
//

import UIKit

class DetailStudentViewController: UIViewController {

    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var secondNameLabel: UILabel!
    @IBOutlet private weak var facultyLabel: UILabel!

    var student: Student?

    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameLabel.text = student?.name
        secondNameLabel.text = student?.lastName
        facultyLabel.text = student?.faculty
    }
}
