//
//  WebViewController.swift
//  movies-app
//
//  Created by Eugene on 18.06.23.
//

import UIKit
import SnapKit

final class WebViewController: UIViewController {
    private var viewModel: WebViewModel
    
    // LoadView
    private var webView: WebView {
        return self.view as! WebView
    }
    
    override func loadView() {
        self.view = WebView(frame: UIScreen.main.bounds)
    }
    
    init(viewModel: WebViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        loadUrl(viewModel.imdbId)
    }
    
    private func loadUrl(_ id: String) {
        let url = URL(string: "https://www.imdb.com/title/\(id)/")
        let request = URLRequest(url: url!)

        webView.webKitView.load(request)
    }
    
    @objc private func dismissController() {
        viewModel.router.dismiss(self)
    }
}

extension WebViewController {
    private func setup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissController))
    }
}
