//
//  MetaDataCell.swift
//  movies-app
//
//  Created by Eugene on 18.06.23.
//

import UIKit
import SnapKit

final class MetaDataCell: UICollectionViewCell {
    static var reuseId = "MetaDataCell"

    private let containerStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = Layout.stackSpacing
        
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "Mulish-Regular", size: Layout.titleLabelSize)
        label.textColor = .textGray
        
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "Mulish-SemiBold", size: Layout.subtitleLabelSize)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ metadata: MetaData) {
        titleLabel.text = metadata.key
        subTitleLabel.text = metadata.value
    }
}

extension MetaDataCell {
    struct Layout {
        static var titleLabelSize: CGFloat = 15
        static var subtitleLabelSize: CGFloat = 14
        static var stackSpacing: CGFloat = 4
    }
    
    private func setupViews() {
        contentView.addSubview(containerStack)
        
        containerStack.addArrangedSubview(titleLabel)
        containerStack.addArrangedSubview(subTitleLabel)
    }
    
    private func setupConstraints() {
        containerStack.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
