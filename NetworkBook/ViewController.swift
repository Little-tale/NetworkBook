//
//  ViewController.swift
//  NetworkBook
//
//  Created by Jae hyung Kim on 1/17/24.
//

import UIKit
import Kingfisher

let xib = UINib(nibName: BookCollectionViewCell.getidenti, bundle: nil)

class ViewController: UIViewController {
    @IBOutlet var bookListCollView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    var searchText: String = "라면" {
        didSet {
            bookManager.requste(complite: { success in
                self.documets = success
            }, text: searchText)
        }
    }
    
    let bookManager = BookModeler()
    var documets: [Document] = [] {
        didSet {
            bookListCollView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookManager.requste(complite: { success in
            self.documets = success
        }, text: searchText)
        
        bookListCollView.dataSource = self
        bookListCollView.delegate = self
        designLayout()
        
        bookListCollView.register(xib, forCellWithReuseIdentifier: BookCollectionViewCell.getidenti )
        
        navigationItem.title = "나의 책장"
        
        searchBar.delegate = self
        
    }


}
extension ViewController {
    
}




extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // 여기서 시작은 0 일것이다.
        // 하지만 도큐먼트가 변화를 감지하면
        // 다시 그리기 때문에 이코드는 안전해진다.
        return documets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.getidenti, for: indexPath) as! BookCollectionViewCell
        
        cell.bookNameLabel.text = documets[indexPath.row].title
        let saleText = documets[indexPath.row].salePrice
        
        cell.scoreLabel.text = String(saleText) + "원"
        
        guard let url = documets[indexPath.row].thumbnail else {
            print("url : NotFound")
            return cell
        }
        
        let chageUrl = URL(string: url)
        // dump(chageUrl)
        
        cell.bookImageView.kf.setImage(with: chageUrl)
        
       
        
        return cell
    }
    
}

extension ViewController {
    func designLayout() {
        let layout = UICollectionViewFlowLayout()
        
        let contentsCount:CGFloat = 2
        
        let screenWidth = UIScreen.main.bounds.width
        let verSpaicing:CGFloat = 16
        let totalSpacing = verSpaicing * (contentsCount + 1)
        
        
        let width = (screenWidth - totalSpacing) / contentsCount
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: verSpaicing, left: verSpaicing, bottom: verSpaicing, right: verSpaicing)
        
        
        bookListCollView.collectionViewLayout = layout
    }
}

extension ViewController : UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchText = self.searchBar.text ?? "라면"
        // print(searchBar.text!)
        // print(searchText)
        
        view.endEditing(true)
    }
}
