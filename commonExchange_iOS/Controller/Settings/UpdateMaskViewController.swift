//
//  UpdateMaskViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/15.
//

import UIKit
import RxSwift
import RxCocoa
typealias Parameters = [String: String]

protocol UploadDelegate: AnyObject {
    func uploadStatus(isSuccess: Bool)
}

class UpdateMaskViewController: UIViewController {
    var delegate: UploadDelegate?
    private let takePicButton = BaseButton(title: "拍照", titleColor: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 14, weight: .regular), backgroundColor: .white)
    private let updateButton = BaseButton(title: "上傳", titleColor: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 14, weight: .regular), backgroundColor: .white)
    private let cancelButton = BaseButton(title: "取消", titleColor: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 14, weight: .regular), backgroundColor: .white)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBtttonAction()
    }
    
    // MARK: - Helpers
    private func setupUI() {
        view.addSubViews(cancelButton,
                         updateButton,
                         takePicButton
                        )
        cancelButton.layer.cornerRadius = 7
        updateButton.layer.cornerRadius = 7
        takePicButton.layer.cornerRadius = 7
        
        cancelButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        updateButton.snp.makeConstraints { make in
            make.bottom.equalTo(cancelButton.snp.top).offset(-20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        takePicButton.snp.makeConstraints { make in
            make.bottom.equalTo(updateButton.snp.top).offset(-10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    private func setupBtttonAction() {
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        updateButton.addTarget(self, action: #selector(didTapUpdate), for: .touchUpInside)
        takePicButton.addTarget(self, action: #selector(didTapTakePic), for: .touchUpInside)
        
        cancelButton.setBackgroundColor(.white, forState: .normal)
        updateButton.setBackgroundColor(.white, forState: .normal)
        takePicButton.setBackgroundColor(.white, forState: .normal)

        cancelButton.setBackgroundColor(#colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1), forState: .highlighted)
        updateButton.setBackgroundColor(#colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1), forState: .highlighted)
        takePicButton.setBackgroundColor(#colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1), forState: .highlighted)

        cancelButton.setTitleColor(.white, for: .highlighted)
        updateButton.setTitleColor(.white, for: .highlighted)
        takePicButton.setTitleColor(.white, for: .highlighted)
    }
    
    // MARK: - Selector
    @objc private func didTapCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapUpdate() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }

    @objc private func didTapTakePic() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }

}

extension UpdateMaskViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            LoadingView.shared.showLoader()
            AFManager.shared.uploadImg(image: image) { [weak self] (result) in
                // callback
                self?.dismiss(animated: false, completion: nil)
                self?.delegate?.uploadStatus(isSuccess: result)
                LoadingView.shared.hideLoader()
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

