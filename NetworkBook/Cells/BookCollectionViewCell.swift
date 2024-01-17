//
//  BookCollectionViewCell.swift
//  NetworkBook
//
//  Created by Jae hyung Kim on 1/17/24.
//

import UIKit


class BookCollectionViewCell: UICollectionViewCell {
    @IBOutlet var bookNameLabel: UILabel!
    @IBOutlet var bookImageView: UIImageView!
    @IBOutlet var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.backgroundColor = UIColor(red: CGFloat.random(in: 0...0.5), green: CGFloat.random(in: 0...0.5), blue: CGFloat.random(in: 0...0.5), alpha: 1)
        self.layer.cornerRadius = 16
        
        design()
    }

}
extension BookCollectionViewCell {
    func design() {
        bookNameLabel.textColor = .white
        bookNameLabel.font = .boldSystemFont(ofSize: 20)
        scoreLabel.font = .systemFont(ofSize: 12)
        scoreLabel.textColor = .white
    }
}
