//
//  HomeViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/2/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 105, left: 5, bottom: 0, right: 5)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.register(AdHomeViewCell.self, forCellWithReuseIdentifier: AdHomeViewCell.identifier)
        return collection
    }()
    
    var currentAdItem: Int = 0
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
 
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden  = true

    }
    
    var adViewCell: AdHomeDidTapItem?
    func bindingItem() {
        
    }
    
    private func setupUI() {
        view.addsubViews(collectionView)
        
        collectionView.snp.makeConstraints { make in
//            make.top.equalTo(view.snp.top)
            make.top.left.right.bottom.edges.equalToSuperview()
        }
    }
    
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdHomeViewCell.identifier, for: indexPath) as! AdHomeViewCell
//            cell.delegate = self
            cell.didSelectedIndex.subscribe(onNext: { [weak self] index in
                self?.currentAdItem = index
            })
            .disposed(by: bag)
            return cell
            
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemTeal
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.size.width, height: 180)
        case 1:
            return CGSize(width: collectionView.frame.size.width, height: 50)
        case 2:
            return CGSize(width: collectionView.frame.size.width, height: 100)
        case 3:
            return CGSize(width: collectionView.frame.size.width, height: 600)
        default:
            break
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(currentAdItem)
    }
    
    
}

//extension HomeViewController: AdHomeDidTapItem {
//    func didTapItem(selectedItem: Int) {
//        print(selectedItem)
//    }
//
//
//}

extension UIView {
    func addsubViews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
}

