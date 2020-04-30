//
//  ViewController.swift
//  NeverNote
//
//  Created by Einstein Nguyen on 4/27/20.
//  Copyright © 2020 Einstein Nguyen. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var noteTitle       = ""
    var noteDescription = ""
    var noteContents    = ""
    
    @IBOutlet weak var pauseButton: UIBarButtonItem!
    @IBOutlet weak var contentTextView: UITextView!

    @IBOutlet weak var decoyContentTextView: UITextView!
    var managedObjectContext: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = self.noteTitle
        self.contentTextView.text = self.noteContents
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    @IBAction func didSelectPause(_ sender: Any) {
        self.contentTextView.isHidden = !self.contentTextView.isHidden
        if self.contentTextView.isHidden {
            self.pauseButton.isEnabled = false
            self.decoyContentTextView.isHidden = false
            self.navigationItem.title = "Lovely recipes"
        } else {
            self.pauseButton.isEnabled = true
            self.decoyContentTextView.isHidden = true
            self.navigationItem.title = self.noteTitle
        }
    }
    
    @IBAction func didSelectSave() {
        print(noteTitle)
        let neverNote = NSEntityDescription.insertNewObject(
            forEntityName: "NeverNote",
            into: self.managedObjectContext!
            ) as! NeverNote

        neverNote.noteTitle       = self.noteTitle
        neverNote.noteDescription = self.noteDescription
        neverNote.noteContents    = self.contentTextView.text

        do {
            try self.managedObjectContext!.save()
            self.dismiss(animated: true)
            print("Saved title and descrition successful")
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
}

