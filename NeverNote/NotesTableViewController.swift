//
//  NotesTableViewController.swift
//  NeverNote
//
//  Created by Einstein Nguyen on 4/28/20.
//  Copyright © 2020 Einstein Nguyen. All rights reserved.
//

import UIKit
import CoreData

class NotesTableViewController: UITableViewController {
    
    var neverNotes = [NeverNote]()
    var managedObjectContext: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.backgroundColor = .darkGray
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(refreshTable), for: .valueChanged)
        self.refreshControl = refreshControl
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadNeverNotes()
        tableView.reloadData()
    }
    
    @objc func refreshTable() {
        loadNeverNotes()
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return neverNotes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "notes")

        if cell == nil {
            let currentNote: NeverNote = neverNotes[indexPath.row]
            cell = NotesTableViewCell.createCell(noteTitle: currentNote.noteTitle ?? "", noteDescription: currentNote.noteDescription ?? "")
        }
        
        return cell!
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            managedObjectContext?.delete(self.neverNotes[indexPath.row])
            self.neverNotes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentNote: NeverNote = neverNotes[indexPath.row]
        let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "contentViewController") as! ViewController

        newViewController.noteTitle       = currentNote.noteTitle ?? ""
        newViewController.noteDescription = currentNote.noteDescription ?? ""
        newViewController.noteContents    = currentNote.noteContents ?? ""

        self.show(newViewController, sender: nil)
    }
    
    func loadNeverNotes() {
        managedObjectContext?.perform {
            self.getNotes { (neverNotes) in
                if let neverNotes = neverNotes {
                    self.neverNotes = neverNotes
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func getNotes(completion: @escaping ([NeverNote]?) -> Void) {
        managedObjectContext?.perform {
            var neverNotes = [NeverNote]()
            let request: NSFetchRequest<NeverNote> = NeverNote.fetchRequest()
            guard let managedObjectContext = self.managedObjectContext else { return }
            
            do {
                neverNotes = try managedObjectContext.fetch(request)
                completion(neverNotes)
            }
            catch {
                let alert = UIAlertController(
                    title: "Error",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "ok", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
}
