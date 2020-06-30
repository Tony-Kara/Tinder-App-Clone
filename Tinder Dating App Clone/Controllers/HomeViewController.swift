//
//  HomeViewController.swift
//  Tinder Dating App Clone
//
//  Created by mac on 6/30/20.
//  Copyright © 2020 EniTony. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // Properties
    private let topStack = HomeNavigationStackView()// create an instance of the stackview to connect to it's member fields.
    private let buttomStack = ButtomControlStackview()
    private let deckView: UIView = { // This is for my image, the middle view, this is the UI component is created
        let view = UIView()
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 5
        return view
    }()
    //Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [topStack,deckView, buttomStack])
        stack.axis = .vertical
        view.addSubview(stack) //This adds your main vertical stack as as a subview of the super view.
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        stack.bringSubviewToFront(deckView)
    }
    
}
