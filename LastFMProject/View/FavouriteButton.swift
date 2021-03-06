//
//  FavouriteButton.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 11.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
import UIKit

enum ButtonState {
    case save
    case delete
}

class FavouriteButton: UIButton {
    enum Constants {
        static let saveImage = "heart"
        static let deleteImage = "heart.fill"
    }

    var buttonState = ButtonState.save
    var action: (() -> Void)?
    enum SaveButtonImages {
        case save
        case delete
        var saveImage: UIImage {
            switch self {
            case .save: return UIImage(systemName: Constants.saveImage) ?? UIImage()
            case .delete: return UIImage(systemName: Constants.deleteImage) ?? UIImage()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    func configureWithState(state: ButtonState) {
        let buttonImage = (state == .save) ? SaveButtonImages.save.saveImage : SaveButtonImages.delete.saveImage

        buttonState = state

        setImage(buttonImage, for: .normal)
        setImage(buttonImage, for: .highlighted)
    }

    func configure() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(saveButtonTapped)))
    }

    @objc func saveButtonTapped() {
        switch buttonState {
        case .save:
            configureWithState(state: .delete)
        case .delete:
            configureWithState(state: .save)
        }
        (action ?? {})()
    }
}
