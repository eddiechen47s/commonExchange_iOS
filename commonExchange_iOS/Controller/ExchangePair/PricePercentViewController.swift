//
//  PricePercentViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/12.
//

import UIKit
import RxSwift
import RxCocoa

class PricePercentViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.register(PricePercentViewCell.self, forCellWithReuseIdentifier: PricePercentViewCell.identifier)
        return cv
    }()
    
    var type = 0
    var selectedIndex = PublishRelay<Int>()
    init(type: Int) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        reload()
    }
    
    private func setupUI() {
        view.addSubViews(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func reload() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    

}

extension PricePercentViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PricePercentType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PricePercentViewCell.identifier, for: indexPath) as! PricePercentViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = .init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        cell.configure(with: PricePercentType.allCases[indexPath.item])
        if type == 0 {
            cell.percentLabel.textColor = #colorLiteral(red: 0.2776432037, green: 0.6590948701, blue: 0.4378901124, alpha: 1)
        } else {
            cell.percentLabel.textColor = .red
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/4, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)
        self.selectedIndex.accept(indexPath.item)
    }
    
}
