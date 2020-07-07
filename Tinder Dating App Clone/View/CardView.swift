//
//  CardView.swift
//  Tinder Dating App Clone
//
//  Created by mac on 7/1/20.
//  Copyright © 2020 EniTony. All rights reserved.
//

import UIKit
class CardView: UIView {
                          //int is the raw value
    enum  SwipeDirection: Int {
        case left = -1
        case right = 1
    }
    
    //MARK: - Properties
private let gradientLayer = CAGradientLayer()
    
private let imageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.image = #imageLiteral(resourceName: "kelly2")
    return iv
}()

private let infoLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    
    let attributedText = NSMutableAttributedString(string: "Jane Doe", attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy), .foregroundColor: UIColor.white])
    
    attributedText.append(NSAttributedString(string: "  20", attributes: [.font: UIFont.systemFont(ofSize: 24), .foregroundColor: UIColor.white]))
    
    label.attributedText = attributedText
    
    return label
}()

private lazy var infoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage( #imageLiteral(resourceName: "photo_placeholder").withRenderingMode(.alwaysOriginal), for: .normal)
    return button
}()

// Lifecycle


    override init(frame: CGRect) {
       super.init(frame: frame)
        
        configureGestureRecognizers()
        
        backgroundColor = .systemPurple
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        configureGradientLayers() // call this fucntion before you add infoLabel and infoButton, this allows both to be added ontop of the gradient layer
        
        addSubview(infoLabel)
        infoLabel.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
        addSubview(infoButton)
        infoButton.setDimensions(height: 40, width: 40)
        infoButton.centerY(inView: infoLabel)
        infoButton.anchor(right: rightAnchor, paddingRight: 16)
    
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer){
         
        
        switch sender.state{
            
      
        case .began:
            superview?.subviews.forEach({ $0.layer.removeAllAnimations() }) // remove all animation before starting panning gestures.
        case .changed:
           panCard(sender: sender)
        case .ended:
            resetCardPosition(sender: sender)
        
        default: break
        }
        
        
    }
    
    @objc func handleChangePhoto() {
        
    }
    
    //MARK: - Helpers
    
    func panCard(sender: UIPanGestureRecognizer) {
        // The translation gives the X AND Y positions
        let translation = sender.translation(in: nil)
        let degrees: CGFloat = translation.x / 20
                   let angle = degrees * .pi / 180
                   let rotationalTransform = CGAffineTransform(rotationAngle: angle)
                   self.transform = rotationalTransform.translatedBy(x: translation.x, y: translation.y)
    }
    
    func resetCardPosition(sender: UIPanGestureRecognizer) {
        // This checks for the swipe direction in the x-axis(left or right direction), if the swift direction is above 100, the swipe was to the right and if less than 100, the swipe was to the left.
        let direction:SwipeDirection = sender.translation(in: nil).x > 100 ? .right : .left
        //This dimiss the card as long as the translation in the x-axis is above 100
        let shouldDismissCard = abs(sender.translation(in: nil).x) > 100
        
        //Animation
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            
            if shouldDismissCard == true {
                let xTranslation = CGFloat(direction.rawValue) * 1000 // This ensures the card in focus is swiped away from the screen to the left or right depending on the "direction" property which will have a raw value of -1 or +1 ensuring the card is floated by a 1000 or -1000 pixel away from the screen
                let offScreenTransform = self.transform.translatedBy(x: xTranslation, y: 0)
                self.transform = offScreenTransform
            }
            else {
                
                 self.transform = .identity // this returns the card to position if user swipes just a little bit to the right or left.
                
            }
           
        }) { _ in
          //  print("DEBUG: aNIMAtion did complete") here, the code for what happens after swipe ends is written here.
            if shouldDismissCard == true {
            self.removeFromSuperview() // this ensure the card in focus is removed from the superview and not just floating around somewhere, this is the completion handler block.
            }
        }
    }
    
    func configureGradientLayers()  {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradientLayer)
        
    }
    
    func configureGestureRecognizers() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangePhoto))
        addGestureRecognizer(tap)
    }
}
