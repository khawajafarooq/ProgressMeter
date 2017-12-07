//
//  ProgressControl.swift
//  Example-ProgressControl
//
//  Created by GIB on 11/20/17.
//  Copyright © 2017 Xmen. All rights reserved.
//

import UIKit

@IBDesignable public class ProgressMeter: UIView {

    // MARK: - Properties
    
    private let progressView = UIProgressView(progressViewStyle: .default)
    private var dividers: [ProgressAnnotation] = []
    private let topOffset: CGFloat = 15.0
    
    private var progressViewHeight: CGFloat {
        return progressView.frame.height
    }
    
    /// top anchor of progress bar
    public var progressViewTopAnchor: NSLayoutYAxisAnchor {
        return progressView.topAnchor
    }
    
    /// bottom anchor of progress bar
    public var progressViewBottomAnchor: NSLayoutYAxisAnchor {
        return progressView.bottomAnchor
    }
    
    /// leading anchor of progress bar
    public var progressViewLeadingAnchor: NSLayoutXAxisAnchor {
        return progressView.leadingAnchor
    }
    
    /// set and get data the data of control
    public var data: [Double] = [] {
        didSet {
            updateData()
        }
    }
    
    // MARK: - @IBInspectable Properties
    
    /// set the max value of control
    @IBInspectable public var maxValue: Double = 0.0 {
        didSet {
            setupDivider()
            updateData()
        }
    }
    
    /// set the progress of control (filling area)
    @IBInspectable public var progress: Float = 0.0 {
        didSet {
            progressView.progress = progress
        }
    }
    
    /// set prgoress tint color
    @IBInspectable public var progressTintColor: UIColor = .purple {
        didSet {
            progressView.progressTintColor = progressTintColor
        }
    }
    
    /// set track tint color
    @IBInspectable public var trackTintColor: UIColor = .gray {
        didSet {
            progressView.trackTintColor = trackTintColor
        }
    }
    
    /// set boarder width
    @IBInspectable public var borderWidth: CGFloat = 1 {
        didSet {
            progressView.layer.borderWidth = borderWidth
        }
    }
    
    /// set border color
    @IBInspectable public var borderColor: UIColor = .black {
        didSet {
            progressView.layer.borderColor = borderColor.cgColor
        }
    }
    
    /// set annotation text color
    @IBInspectable public var annotationTextColor: UIColor = .black
    
    /// set divider color
    @IBInspectable public var dividerColor: UIColor = .black
    
    /// set number of division color
    @IBInspectable public var numberOfDivisions: Int = 1
    
    /// set annotation position
    @IBInspectable public var annotationPositionOnTop: Bool = true
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        #if TARGET_INTERFACE_BUILDER
            setupDesignable()
        #endif
        
        progressView.layer.masksToBounds = true
        progressView.layer.cornerRadius = progressViewHeight / 2.0
    }
    
    // MARK: - Setup
    
    private func setup() {
        
        // styling
        progressView.progressTintColor = progressTintColor
        progressView.trackTintColor = trackTintColor
        
        // progress
        progressView.progress = progress
        
        // border
        progressView.layer.borderWidth = borderWidth
        progressView.layer.borderColor = borderColor.cgColor
        
        // self config
        self.backgroundColor = .clear
        self.addSubview(progressView)
        
        // constraint
        setupProgressConstraints()
        
        // divider
        setupDivider()
    }
    
    
    private func setupDesignable() {
        setup()
        setupDivider()
    }
    
    private func setupDivider() {
        guard numberOfDivisions > 0 else {
            return
        }
        
        var rawData: [Double] = []
        let items = numberOfDivisions+1
        for _ in 0..<items {
            
            guard !rawData.isEmpty else {
                var element = Double(maxValue/Double(items))
                
                rawData.append(element.round(to: 0))
                continue
            }
            
            var element = Double(maxValue/Double(items)) + rawData.last!
            rawData.append(element.round(to: 0))
        }
        
        // update the divisions
        data = Array(rawData.prefix(numberOfDivisions))
    }
    
    private func setupProgressConstraints() {

        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchor = progressView.topAnchor.constraint(equalTo: self.topAnchor, constant: topOffset)
        let leadingAnchor = progressView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let trailingAnchor = progressView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        let widthAnchor = progressView.widthAnchor.constraint(equalTo: self.widthAnchor)
        let heightAnchor = progressView.heightAnchor.constraint(equalToConstant: self.frame.height - topOffset)

        NSLayoutConstraint.activate([topAnchor, leadingAnchor, trailingAnchor, widthAnchor, heightAnchor])
    }
    
    private func addDivider() {
        
        // Progress view divider positioning offsets
        let initialOffset = progressView.frame.origin.x
        var index = 0
        
        while (index < data.count) {
            
            let value = data[index]
            let divider = ProgressAnnotation(parentView: self)
            self.addSubview(divider)
            dividers.append(divider)
            
            divider.text = "\(value)"
            divider.dividerHeight = self.frame.height - topOffset
            let xOffset = position(for: value, of: maxValue) + initialOffset
            divider.leadingOffset = xOffset
            divider.dividerColor = dividerColor
            divider.textColor = annotationTextColor
            
            
            // corner cases for positioning
            
            // case 1: leading edge of progress meter
            if xOffset < (0.05 * self.frame.width) {
                divider.dividerColor = .clear
            }
            
            // case 2: trailing edge of progress meter
            if xOffset > (0.95 * self.frame.width) {
                divider.dividerColor = .clear
            }
            
            // corner case: if the last entry of data is equal to the maxValue
            if value == maxValue {
                divider.dividerColor = .clear
            }
            
            index += 1
        }
    }
    
    private func removeDivider() {
        for divider in dividers {
            divider.removeFromSuperview()
        }
        
        dividers.removeAll()
    }
    
    // MARK: - Helper
    
    private func updateData() {
        if !data.isEmpty {
            removeDivider()
            addDivider()
        }
    }
    
    private func position(for value: Double, of maximum: Double) -> CGFloat {
        
        let percentage = value / maximum
        guard !percentage.isNaN else {
            return 0.0
        }
        
        return CGFloat(Double(self.frame.width) * percentage)
    }
}

extension Double {
    /// Rounds the double to N number of decimal places
    mutating func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
}

