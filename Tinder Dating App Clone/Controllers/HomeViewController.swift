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
    private let deckView: UIView = { // This is for my image, the middle view, this is how the UI component is created
        let view = UIView()
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 5
        return view
    }()
    //Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCards()
    }
    
    //Helpers
    
    func configureCards() {
        let cardView1 = CardView()
        let cardView2 = CardView()
        
        deckView.addSubview(cardView1)
        deckView.addSubview(cardView2)
        
        cardView1.fillSuperview()
        cardView2.fillSuperview()
    }
    
    func configureUI(){
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [topStack,deckView, buttomStack])
        stack.axis = .vertical
        view.addSubview(stack) //This adds your main vertical stackview as as a subview of the super view.
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor) //We have set the stackview to fill the whole screen by setting height for both topstack and bottomStack without any for the deckView, this means that height will be automatically calculated for deckview
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        stack.bringSubviewToFront(deckView)
    }
    
}
