//
//  RatingMovieView.swift
//  movies-app
//
//  Created by Eugene on 14.06.23.
//

import UIKit
import SnapKit

final class RatingMovieView: UIView {
    private var ratingImage: UIImageView = {
        var imageView = UIImageView()

        imageView.image = UIImage(named: "star")
        imageView.contentMode = .scaleAspectFill
        imageView.widthAnchor.constraint(equalToConstant: Layout.starImageSize).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Layout.starImageSize).isActive = true
        
        return imageView
    }()
    
    var ratingLabel: UILabel = {
        let label = UILabel()

        label.textColor = UIColor.gray
        label.font = UIFont(name: "Mulish-Regular", size: Layout.textSize)

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RatingMovieView {
    struct Layout {
        static var contentHeight: CGFloat = 22
        static var starImageSize: CGFloat = 12
        static var textSize: CGFloat = 14
        static var leftOffset = 4
    }

    private func setup() {
        self.heightAnchor.constraint(equalToConstant: Layout.contentHeight).isActive = true
    }

    private func setupViews() {
        self.addSubview(ratingImage)
        self.addSubview(ratingLabel)
    }
    
    private func setupConstraints() {
        ratingImage.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.centerY.equalTo(ratingLabel)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.left.equalTo(ratingImage.snp.right).offset(Layout.leftOffset)
            make.top.right.equalTo(self)
            make.centerY.equalTo(self)
        }
    }
}
