//
//  MetaDataCollectionView.swift
//  movies-app
//
//  Created by Eugene on 18.06.23.
//

import UIKit

final class MetaDataCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = Layout.cellSize
        layout.minimumLineSpacing = Layout.minimumLineSpacing
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.register(MetaDataCell.self, forCellWithReuseIdentifier: MetaDataCell.reuseId)
        
        self.heightAnchor.constraint(equalToConstant: Layout.contentHeight).isActive = true
        self.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MetaDataCollectionView {
    private struct Layout {
        static var cellSize = CGSize(width: 55, height: 40)
        static var contentHeight: CGFloat = 45
        static var minimumLineSpacing: CGFloat = 25
    }
}
