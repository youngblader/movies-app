//
//  GenreCell.swift
//  movies-app
//
//  Created by Eugene on 14.06.23.
//

import UIKit
import SnapKit

final class GenreCell: UICollectionViewCell {
    static var reuseId = "GenreCell"

    private var textLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "Mulish-Bold", size: Layout.textSize)
        
        label.textAlignment = .center
        label.textColor = UIColor.textPurple

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

    //MARK: Public update
    func update(_ genre: String) {
        textLabel.text = genre.uppercased()
    }
}

extension GenreCell {
    struct Layout {
        static var contentViewRadius: CGFloat = 12
        static var textSize: CGFloat = 12
        static var verticalInset = 4
        static var horizontalInset = 14
    }
    
    private func setup() {
        contentView.backgroundColor = UIColor.backgroundPurple
        contentView.layer.cornerRadius = Layout.contentViewRadius
    }

    private func setupViews() {
        contentView.addSubview(textLabel)
    }

    private func setupConstraints() {
        textLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(Layout.verticalInset)
            make.left.right.equalTo(contentView).inset(Layout.horizontalInset)
        }
    }
}
