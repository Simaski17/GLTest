//
//  ItunesTableViewCell.swift
//  
//
//  Created by Jimmy Hernandez on 22-04-20.
//

import UIKit
import SDWebImage

class ItunesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var songImage: UIImageView!
    
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
        songImage.sd_setImage(with: URL(string: event[index.row].artworkUrl100))

    }
    
}
