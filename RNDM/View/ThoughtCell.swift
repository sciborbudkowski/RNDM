//
//  ThoughtCell.swift
//  RNDM
//
//  Created by Ścibor Budkowski on 11/09/2020.
//  Copyright © 2020 Ścibor Budkowski. All rights reserved.
//

import UIKit

class ThoughtCell: UITableViewCell {

    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var thoughtTxtLbl: UILabel!
    @IBOutlet weak var numLikesLbl: UILabel!
    @IBOutlet weak var likesImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(thought: Thought) {
        usernameLbl.text = thought.username
        thoughtTxtLbl.text = thought.thoughtTxt
        numLikesLbl.text = String(thought.numLikes)
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        let dt = formatter.string(from: thought.timestamp)
        timestampLbl.text = dt
    }
}
