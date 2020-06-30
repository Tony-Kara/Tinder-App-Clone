//
//  HomeNavigationStackView.swift
//  Tinder Dating App Clone
//
//  Created by mac on 6/30/20.
//  Copyright © 2020 EniTony. All rights reserved.
//

import UIKit
class HomeNavigationStackView: UIStackView {
    
    //Mark: - Properties
    
    let settingsButton = UIButton(type: .system)
    let messageButton = UIButton(type: .system)
    let tinderIcon = UIImageView(image: #imageLiteral(resourceName: "app_icon"))
    
    //Mark: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame )
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        tinderIcon.contentMode = .scaleAspectFit
        settingsButton.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "top_messages_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        
        
        // Here is where we create an array of elements(buttons)and we add each element of the array to the stackview as a subview using a foreach loop. The UIView() helps creates spacing between each element(for less elements in the array eg 3 elements, you can add it but for elements around 5, no need as seen in the "buttomControllersViewStack")
        [settingsButton,UIView(), tinderIcon,UIView(), messageButton].forEach { view in
            addArrangedSubview(view)
        }
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
