//
//  DetailAlbumTableViewCell.swift
//  GLTest
//
//  Created by Jimmy Hernandez on 22-04-20.
//  Copyright © 2020 Jimmy Hernandez. All rights reserved.
//

import UIKit

class DetailAlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var songName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(event: [Result], index: IndexPath) {
        self.songName.text = event[index.row].trackName

    }

}
