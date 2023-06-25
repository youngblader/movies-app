//
//  GenresCollectionView.swift
//  movies-app
//
//  Created by Eugene on 14.06.23.
//

import UIKit

final class GenresCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()

        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = Layout.cellSize
        layout.minimumLineSpacing = Layout.minimumLineSpacing
        
        super.init(frame: .zero, collectionViewLayout: layout)

        self.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.reuseId)

        self.heightAnchor.constraint(equalToConstant: Layout.contentSize).isActive = true
        self.showsHorizontalScrollIndicator = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GenresCollectionView {
    private struct Layout {
        static var cellSize = CGSize(width: 100, height: 25)
        static var contentSize: CGFloat = 25
        static var minimumLineSpacing: CGFloat = 8
    }
}
