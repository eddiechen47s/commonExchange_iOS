//
//  UserAClassDetailViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/20.
//

import UIKit
import RxSwift
import RxCocoa

class UserAClassDetailViewController: UIViewController {

    var model: UserAClass!
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 0.9968166947, green: 1, blue: 0.9963441491, alpha: 1)
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.register(UserAClassDetailViewCell.self, forCellWithReuseIdentifier: UserAClassDetailViewCell.identifier)
        return cv
    }()
    var idcardResult = ""
    var idcardauths = 0
    lazy var modelResult = [
        UserAClassDetail(title: "國籍", detail: model.country),
        UserAClassDetail(title: "姓名", detail: model.username),
        UserAClassDetail(title: "身分證字號", detail: model.idcard),
        UserAClassDetail(title: "身分證正面", detail: idcardResult),
    ]
    
    private let reverifyButton: UIButton = {
       let button = UIButton()
        button.setTitle("重新審核", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1)
        button.addTarget(self, action: #selector(didTapReverify), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9762050509, green: 0.976318419, blue: 0.9761529565, alpha: 1)
        setupUI()
        if model.idcardauth == 1 {
            self.idcardResult = "等待審核"
            idcardauths = 1
        } else if model.idcardauth == 2 {
            self.idcardResult = "未通過"
            idcardauths = 2
            self.reverifyButton.isHidden = false
        } else {
            self.idcardResult = "審核通過"
            idcardauths = 3
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupUI() {
        view.addSubViews(collectionView, reverifyButton)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.35)
        }
        
        reverifyButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
    
    @objc private func didTapReverify() {
        self.navigationController?.popViewController(animated: false)
    }
}

extension UserAClassDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let vm = modelResult[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserAClassDetailViewCell.identifier, for: indexPath) as? UserAClassDetailViewCell else { fatalError("UserAClassDetailViewCell nil") }
        cell.configure(with: vm)
        if indexPath.row == 3 {
            switch idcardauths {
            case 1:
                cell.detailLabel.textColor = #colorLiteral(red: 0.9768365026, green: 0.7539469004, blue: 0.1767497361, alpha: 1)
            case 2:
                cell.detailLabel.textColor = .systemRed
            default:
                cell.detailLabel.textColor = .systemGreen
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    
    
}
