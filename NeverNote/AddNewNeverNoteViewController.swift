//
//  AddNewNeverNoteViewController.swift
//  NeverNote
//
//  Created by Einstein Nguyen on 4/29/20.
//  Copyright © 2020 Einstein Nguyen. All rights reserved.
//

import UIKit
import CoreData

class AddNewNeverNoteViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var managedObjectContext: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didSelectCancel() {
        self.titleTextField.text       = ""
        self.descriptionTextField.text = ""
    }

    @IBAction func didSelectCreate() {
        if (titleTextField.text!.isEmpty || descriptionTextField.text!.isEmpty) {
            let alert = UIAlertController(title: "Error", message: "Please enter a title and description", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default))
            self.present(alert, animated: true)
        }

        let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "contentViewController") as! ViewController

        newViewController.noteTitle       = titleTextField.text!
        newViewController.noteDescription = descriptionTextField.text!

        self.present(newViewController, animated: true) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
