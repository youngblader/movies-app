//
//  WebView.swift
//  movies-app
//
//  Created by Eugene on 19.06.23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

enum IndicatorAction {
    case start
    case stop
}

final class WebView: UIView {
    lazy var webKitView = WebKitView()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupViews()
        setupConstraints()
        
        webKitView.onIndicatorAction = { action in
            self.handlingIndicatorAction(action)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func handlingIndicatorAction(_ action: IndicatorAction) {
        switch action {
        case .start:
            activityIndicator.startAnimating()
        case .stop:
            activityIndicator.stopAnimating()
        }
    }
}

extension WebView {
    private func setup() {
        self.backgroundColor = .white
    }
    
    private func setupViews() {
        self.addSubview(webKitView)
        self.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        webKitView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
        }
    }
}
