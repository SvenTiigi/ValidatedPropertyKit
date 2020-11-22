//
//  ViewController.swift
//  Example
//
//  Created by Sven Tiigi on 21.11.2020.
//  Copyright © 2020 Sven Tiigi. All rights reserved.
//

import UIKit
import ValidatedPropertyKit

// MARK: - ViewController

/// The ViewController
class ViewController: UIViewController {

    // MARK: Properties
    
    /// The Label
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "🚀\nValidatedPropertyKit\nExample"
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    // MARK: View-Lifecycle
    
    /// View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    /// LoadView
    override func loadView() {
        self.view = self.label
    }

}
