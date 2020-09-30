//
//  CollectionView.swift
//  RapidApp
//
//  Created by Carlos Pava on 01/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

class CollectionView: UICollectionView {
    
    var flowLayout: CollectionViewHorizontalCustom = {
        return CollectionViewHorizontalCustom(display: .list)
    }()
    
    init(frame: CGRect, layout: CollectionDisplay) {
        flowLayout = CollectionViewHorizontalCustom(display: layout)
        super.init(frame: frame, collectionViewLayout: flowLayout)
        setBackgroundWhiteColor()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setBackgroundWhiteColor() {
        self.backgroundColor = .white
        self.indicatorStyle = .white
    }
    
    func setHeight(_ height: CGFloat) {
        flowLayout.height = height
    }
    
    func setAdapter<Cell:BaseCollectionCell<T>, T>(_ adapter: GenericDataSource<Cell, T>) {
        self.delegate = adapter
        self.dataSource = adapter
    }
}
