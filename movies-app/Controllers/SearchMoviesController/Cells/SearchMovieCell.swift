//
//  SearchMovieCell.swift
//  movies-app
//
//  Created by Eugene on 13.06.23.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchMovieCell: UITableViewCell {
    static var reuseId = "MoviePopularCell"
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 2
        label.font = UIFont.init(name: "Mulish-Bold", size: Layout.labelSize)
        
        return label
    }()
    
    private var yearLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.init(name: "Mulish-Regular", size: Layout.labelSize)
        label.textColor = .textGray
        
        return label
    }()
    
    private var posterImageView: UIImageView = {
        var imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.widthAnchor.constraint(equalToConstant: Layout.posterImageSize.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Layout.posterImageSize.height).isActive = true
        
        imageView.layer.cornerRadius = Layout.posterImageCorderRadius
        imageView.clipsToBounds = true
        
        return imageView
        
    }()
    
    private var contentContainerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ movie: SearchMovie) {
        posterImageView.kf.setImage(with: URL(string: movie.poster), options: [.transition(.fade(0.2)), .cacheOriginalImage])
        
        titleLabel.text = movie.title
        yearLabel.text = movie.year
    }
}

extension SearchMovieCell {
    struct Layout {
        static var labelSize: CGFloat = 14
        static var paddingInset: CGFloat = 16
        static var topOffset: CGFloat = 8
        static var bottomInset: CGFloat = 12
        static var posterImageSize = (width: CGFloat(94), height: CGFloat(148))
        static var posterImageCorderRadius: CGFloat = 8
    }
    
    private func setupViews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(contentContainerView)
        
        contentContainerView.addSubview(titleLabel)
        contentContainerView.addSubview(yearLabel)
    }
    
    private func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.left.equalTo(contentView).inset(Layout.paddingInset)
            make.bottom.equalTo(contentView).inset(Layout.bottomInset)
        }
        
        contentContainerView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.left.equalTo(posterImageView.snp.right).offset(Layout.paddingInset)
            make.right.equalTo(contentView).inset(Layout.paddingInset)
            make.bottom.equalTo(contentView).inset(Layout.bottomInset)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentContainerView)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Layout.topOffset)
            make.left.right.equalTo(contentContainerView)
        }
    }
}
