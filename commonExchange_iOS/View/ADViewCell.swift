//
//  ADViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/2/25.
//

import UIKit

class ADViewCell: UICollectionViewCell {
    static let identifier = "AdHomeViewCell"
    
    let adImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func configue(imageName: String) {
        self.adImage.image = UIImage(named: imageName)
    }
    
    func setupUI() {
        addSubview(adImage)
        
        adImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
