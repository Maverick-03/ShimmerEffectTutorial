//
//  ShimmerEffectCell.swift
//  ShimmerEffectTutorial
//
//  Created by Administrator on 24/07/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit

class ShimmerEffectCell: UITableViewCell {
    @IBInspectable var shimmerImage:UIImage?
    var originalImageVW:UIImageView?
    var newImage:UIImageView?
    var gradientLayer:CAGradientLayer?
    
    fileprivate func animateGradientLayer(_ withFrame: CGRect, _ gradientLayer: CAGradientLayer) {
        //animate
        let shimmerAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        shimmerAnimation.duration = 2.0
        shimmerAnimation.fromValue = -withFrame.maxX
        shimmerAnimation.toValue = withFrame.maxX
        shimmerAnimation.repeatCount = .infinity
        gradientLayer.add(shimmerAnimation, forKey: "ShimmerEffectAnimation")
    }
    
    func addShimmerEffect(withFrame:CGRect){
        self.contentView.isHidden = true
        //        guard newImage != nil,gradientLayer != nil , originalImageVW != nil else {
        originalImageVW?.removeFromSuperview()
        originalImageVW = UIImageView(frame: withFrame)
        originalImageVW?.image = shimmerImage
        self.addSubview(originalImageVW!)
        newImage?.removeFromSuperview()
        newImage = UIImageView(frame: withFrame)
        newImage?.image = shimmerImage?.withRenderingMode(.alwaysTemplate)
        newImage?.contentMode = .scaleToFill
        newImage?.tintColor = UIColor.lightGray
        self.insertSubview(newImage!, aboveSubview: originalImageVW!)
        gradientLayer?.removeFromSuperlayer()
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = withFrame
        gradientLayer?.colors = [UIColor.clear.cgColor,UIColor.white.cgColor,UIColor.clear.cgColor]
        gradientLayer?.locations = [0,0.5,1]
        let angle = (CGFloat.pi/180.0) * 45
        gradientLayer?.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        newImage?.layer.mask = gradientLayer
        animateGradientLayer(withFrame, gradientLayer!)
        return
        //        }
    }
    
    func removeShimmer(){
        newImage?.removeFromSuperview()
        gradientLayer?.removeFromSuperlayer()
        originalImageVW?.removeFromSuperview()
        self.contentView.isHidden = false
    }
    
    
    
    override func awakeFromNib(){
        super.awakeFromNib()
        self.addShimmerEffect(withFrame: self.contentView.frame)
        
    }
    override func prepareForReuse() {
        self.addShimmerEffect(withFrame: self.contentView.frame)
    }
    
    
    func removeShimmerEffect(){
        self.removeShimmer()
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
