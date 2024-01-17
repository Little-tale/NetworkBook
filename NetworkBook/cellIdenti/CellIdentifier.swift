//
//  CellIdentifier.swift
//  NetworkBook
//
//  Created by Jae hyung Kim on 1/17/24.
//

import UIKit

extension UIViewController {
    static var getIdenti: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    static var getidenti: String{
        return String(describing: self)
    }
}
