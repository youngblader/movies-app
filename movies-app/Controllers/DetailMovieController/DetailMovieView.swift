//
//  DetailMovieView.swift
//  movies-app
//
//  Created by Eugene on 17.06.23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher
import RxKingfisher

final class DetailMovieView: UIView {
    private let bag = DisposeBag()
    
    private var ratingView = RatingMovieView()
    private lazy var genreCollectionView = GenresCollectionView()
    private lazy var metaDataCollectionView = MetaDataCollectionView()
    
    var onRedirectButtonTapped: (()->())?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.init(name: "Mulish-Bold", size: Layout.titleLabelSize)
        label.textAlignment = .left
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Description"
        
        label.font = UIFont(name: "Merriweather-Black", size: Layout.subTitleLabelSize)
        label.textAlignment = .left
        label.textColor = .darkBlue
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "Mulish-Regular", size: Layout.descLabelSize)
        label.textAlignment = .left
        label.textColor = .textGray
        label.numberOfLines = 0
        
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        
        return scroll
    }()
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        
        stack.layoutMargins = Layout.stackContentInset
        stack.isLayoutMarginsRelativeArrangement = true
        
        stack.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        return stack
    }()
    
    private let headerStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    private var moviePosterView: UIView = {
        var view = UIView()
        
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowColor = UIColor.gray.cgColor
        
        return view
    }()
    
    private var moviePosterImage: UIImageView = {
        var imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.widthAnchor.constraint(equalToConstant: Layout.posterImageSize.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Layout.posterImageSize.height).isActive = true
        
        imageView.layer.cornerRadius = Layout.posterImageCornerRadius
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var redirectButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.tintColor = .black
        
        button.setImage(UIImage(systemName: "arrow.up.forward.square"), for: .normal)
        
        button.widthAnchor.constraint(equalToConstant: Layout.buttonSize).isActive = true
        button.heightAnchor.constraint(equalToConstant: Layout.buttonSize).isActive = true
        
        return button
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
    func update(_ movie: Observable<Movie>) {
        let genres = movie.map({ movie in
            movie.genre.components(separatedBy: ",")
        })
        
        let metaData = movie.map { movie in
            [MetaData(key: "Length", value: movie.runtime), MetaData(key: "Language", value: movie.language), MetaData(key: "Rating", value: movie.rated)]
        }
        
        movie
            .map { $0.title }
            .bind(to: titleLabel.rx.text)
            .disposed(by: bag)

        movie
            .map { $0.plot }
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: bag)
        
        movie
            .map { movie in URL(string: movie.poster) }
            .bind(to: moviePosterImage.kf.rx.image(options: [.transition(.fade(0.2))]))
            .disposed(by: bag)
        
        movie
            .map { "\($0.imdbRating)/10 IMDb" }
            .bind(to: ratingView.ratingLabel.rx.text)
            .disposed(by: bag)
        
        genres.bind(to: genreCollectionView.rx.items(cellIdentifier: GenreCell.reuseId, cellType: GenreCell.self)) { index, model, cell in
            cell.update(model)
        }.disposed(by: bag)
        
        metaData.bind(to: metaDataCollectionView.rx.items(cellIdentifier: MetaDataCell.reuseId, cellType: MetaDataCell.self)) { index, model, cell in
            cell.update(model)
        }.disposed(by: bag)
    }
}

extension DetailMovieView {
    struct Layout {
        static var buttonSize: CGFloat = 24
        static var stackContentInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        static var titleLabelSize: CGFloat = 20
        static var subTitleLabelSize: CGFloat = 16
        static var descLabelSize: CGFloat = 15
        static var posterImageSize = (width: CGFloat(250), height: CGFloat(350))
        static var posterImageCornerRadius: CGFloat = 8
        static var stackBottomInset: CGFloat = 24
        static var bottomInset: CGFloat = 16
        static var subTitleBottomInset: CGFloat = 8
    }
    
    private func setup() {
        self.backgroundColor = .white
    }
    
    private func setupViews() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentStack)
        
        contentStack.addArrangedSubview(moviePosterView)
        contentStack.setCustomSpacing(Layout.stackBottomInset, after: moviePosterView)
        moviePosterView.addSubview(moviePosterImage)
        
        contentStack.addArrangedSubview(headerStack)
        
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(redirectButton)
        
        contentStack.addArrangedSubview(ratingView)
        contentStack.setCustomSpacing(Layout.bottomInset, after: ratingView)
        
        contentStack.addArrangedSubview(genreCollectionView)
        contentStack.setCustomSpacing(Layout.bottomInset, after: genreCollectionView)
        
        contentStack.addArrangedSubview(metaDataCollectionView)
        contentStack.setCustomSpacing(Layout.bottomInset, after: metaDataCollectionView)
        
        contentStack.addArrangedSubview(subTitleLabel)
        contentStack.setCustomSpacing(Layout.subTitleBottomInset, after: subTitleLabel)
        
        contentStack.addArrangedSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentStack.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
        }
        
        moviePosterImage.snp.makeConstraints { make in
            make.edges.equalTo(moviePosterView)
        }
    }
}
