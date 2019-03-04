//
//  CustomSwitch.swift
//  CustomUISwitch
//
//  Created by Dimitrios Kalaitzidis on 15/02/2019.
//  Copyright © 2019 Dimitrios Kalaitzidis. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class CustomSwitch: UIControl {

    @IBInspectable
    public var onTintColor: UIColor = UIColor(red: 208/255, green: 208/255, blue: 208/255, alpha: 1.0) {
        didSet {
            self.layoutSubviews()
        }
    }

    @IBInspectable
    public var offTintColor: UIColor = UIColor(red: 208/255, green: 208/255, blue: 208/255, alpha: 1.0) {
        didSet {
            self.layoutSubviews()
        }
    }

    @IBInspectable
    public var thumbOnTintColor: UIColor = UIColor(red: 40/255, green: 170/255, blue: 144/255, alpha: 1.0) {
        didSet {
            self.layoutSubviews()
        }
    }

    @IBInspectable
    public var thumbOffTintColor: UIColor = UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1.0) {
        didSet {
            self.layoutSubviews()
        }
    }

    @IBInspectable
    public var thumbTintColor: UIColor = UIColor.white {
        didSet {
            self.layoutSubviews()
        }
    }

    @IBInspectable
    public var padding: CGFloat = 0 {
        didSet {
            self.layoutSubviews()
        }
    }

    @IBInspectable
    public var isOnImage: String = "isOnImage" {
        didSet {
            self.layoutSubviews()
        }
    }

    @IBInspectable
    public var isOffImage: String = "isOffImage" {
        didSet {
            self.layoutSubviews()
        }
    }

    public var isOn: Bool = true {
        didSet {
            process(with: isOn)
        }
    }
    public var animationDuration: Double = 0.5
    fileprivate var cornerRadius: CGFloat = 0.5
    fileprivate var thumbCornerRadius: CGFloat = 0.5
    fileprivate var thumbSize: CGSize = .zero
    fileprivate var thumbView: UIView = UIView(frame: .zero)
    fileprivate var thumbImageView: UIImageView = UIImageView(frame: .zero)
    fileprivate var onPoint: CGPoint = .zero
    fileprivate var offPoint: CGPoint = .zero
    fileprivate var isAnimating: Bool = false
    fileprivate var isOnHandler: ((Bool) -> Void)?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    //
    // Remove everything from the view hierarchy in case we need
    // to reset our UI.
    //
    private func clear() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }

    //
    // Initial configuration of the UI.
    //
    func setupUI() {

        self.clear()
        self.clipsToBounds = false
        self.thumbView.backgroundColor = self.isOn ? self.thumbOnTintColor : self.thumbOffTintColor
        self.thumbView.isUserInteractionEnabled = false

        self.thumbImageView.backgroundColor = .clear
        self.thumbImageView.contentMode = .scaleAspectFit
        self.thumbImageView.clipsToBounds = true
        self.thumbImageView.isUserInteractionEnabled = false
        self.thumbImageView.image = self.isOn ? UIImage(named: self.isOnImage) : UIImage(named: self.isOffImage)

        self.addSubview(self.thumbView)
        self.insertSubview(self.thumbImageView, aboveSubview: self.thumbView)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        if !self.isAnimating {

            self.layer.cornerRadius = self.bounds.size.height * self.cornerRadius
            self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor

            let thumbSize = self.thumbSize != CGSize.zero ? self.thumbSize : CGSize(width: self.bounds.size.width / 2, height: self.bounds.height * 1.714)
            let yPostition = (self.bounds.size.height - thumbSize.height) / 2

            self.onPoint = CGPoint(x: self.bounds.size.width - thumbSize.width - self.padding, y: yPostition)
            self.offPoint = CGPoint(x: self.padding, y: yPostition)

            self.thumbView.frame = CGRect(origin: self.isOn ? self.onPoint : self.offPoint, size: thumbSize)
            self.thumbView.layer.cornerRadius = thumbSize.height * self.thumbCornerRadius

            self.thumbImageView.frame = CGRect(origin: self.isOn ? self.onPoint : self.offPoint, size: CGSize(width: 10, height: 10))
            self.thumbImageView.center = self.thumbView.center

        }
    }

    private func animate() {

        self.isOn = !self.isOn
        self.isAnimating = true

        UIView.animate(withDuration: self.animationDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseOut,.beginFromCurrentState],
                       animations: {
                        self.thumbView.frame.origin.x = self.isOn ? self.onPoint.x : self.offPoint.x
                        self.thumbImageView.center.x = self.thumbView.center.x
                        self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
                        self.thumbView.backgroundColor = self.isOn ? self.thumbOnTintColor : self.thumbOffTintColor
                        self.thumbImageView.image = self.isOn ? UIImage(named: self.isOnImage) : UIImage(named: self.isOffImage)

        }, completion: { [weak self] _ in
            self?.isAnimating = false
            self?.sendActions(for: .valueChanged)
        })

    }

    //
    // Create closure to get isOn value
    //
    func isOn(handler: @escaping (_ value: Bool) -> Void) {
        isOnHandler = handler
    }

    private func process(with value:Bool) {
        if let isOn = isOnHandler {
            isOn(value)
        }
    }

    //
    // Manage touch events on UIControl
    //
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        self.animate()
        return true
    }

}
