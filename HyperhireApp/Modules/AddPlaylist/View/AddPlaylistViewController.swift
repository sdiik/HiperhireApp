//
//  AddPlaylistViewController.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 07/12/24.
//

import UIKit

protocol AddPlaylistDelegate: AnyObject {
    func dismissAddPlaylistViewController(with namePlaylist: String)
}

class AddPlaylistViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addPlaylistTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    var delegate: AddPlaylistDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.tabBarController?.isTabBarHidden = true
    }
    
    private func setupView() {
        addPlaylistTextField.becomeFirstResponder()
        confirmButton.layer.cornerRadius = 26
        confirmButton.backgroundColor = Colors.colorGreen
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    @objc func confirmButtonTapped() {
        if let alreadyTitle = addPlaylistTextField.text {
            CoreDataLibrary.createPlaylist(name: alreadyTitle)
            dismiss(animated: true) { [weak self] in
                guard let self else { return }
                self.delegate?.dismissAddPlaylistViewController(with: alreadyTitle)
            }
        } else {
            Alert.showMessage(with: "Please input playlist title", controller: self)
        }
    }
}
