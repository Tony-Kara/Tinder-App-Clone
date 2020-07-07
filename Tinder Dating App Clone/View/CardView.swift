//
//  CardView.swift
//  Tinder Dating App Clone
//
//  Created by mac on 7/1/20.
//  Copyright © 2020 EniTony. All rights reserved.
//

import UIKit
class CardView: UIView {
// Properties
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
            print("DEBUG: Pan did begin")
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
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            self.transform = .identity // this returns the
        }) { _ in
            print("DEBUG: aNIMAtion did complete")
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
