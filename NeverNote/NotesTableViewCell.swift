//
//  NotesTableViewCell.swift
//  NeverNote
//
//  Created by Einstein Nguyen on 4/29/20.
//  Copyright © 2020 Einstein Nguyen. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func createCell(noteTitle: String, noteDescription: String) -> NotesTableViewCell? {
        let nib = UINib(nibName: "NotesTableViewCell", bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).last as? NotesTableViewCell
        cell?.titleLabel.text       = noteTitle
        cell?.descriptionLabel.text = noteDescription
        return cell
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
