//
//  NeverNoteTableViewCell.swift
//  NeverNote
//
//  Created by Einstein Nguyen on 4/28/20.
//  Copyright © 2020 Einstein Nguyen. All rights reserved.
//

import UIKit

class NeverNoteTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var noteDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func updateCell(neverNote: NeverNote) {
        self.title.text = neverNote.noteTitle
        self.noteDescription.text = neverNote.noteDescription
    }

}
