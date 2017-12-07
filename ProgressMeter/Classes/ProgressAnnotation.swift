//
//  ProgressAnnotation.swift
//  Example-ProgressControl
//
//  Created by GIB on 11/20/17.
//  Copyright © 2017 Xmen. All rights reserved.
//

import UIKit

/// Divider Line View
class ProgressAnnotation: UIView {
    
    // MARK: - Properties

    private let label = UILabel()
    private let divider = UIView()
    private weak var parentView: ProgressMeter?
    private var viewLeading: NSLayoutConstraint!
    
    private var superView: ProgressMeter {
        guard let view = parentView else {
            fatalError("Use init(parentView:)")
        }
        return view
    }
    
    /// Divider line color
    /// Default color is black
    public var dividerColor: UIColor = .black {
        didSet {
            setupDivider()
            setupView()
        }
    }
    
    /// Divider height
    /// Should be equal to the height of progress bar
    public var dividerHeight: CGFloat = 25.0 {
        didSet {
            setupDivider()
        }
    }
    
    /// Text coming on top of divider
    public var text: String = "" {
        didSet {
            setupLabel()
            setupViewConstraint()
        }
    }
    
    /// Text color
    public var textColor: UIColor = .black {
        didSet {
            setupLabel()
            setupViewConstraint()
        }
    }
    
    /// Leading anchor of divider
    public var leadingOffset: CGFloat = 0.0 {
        didSet {
            updateLeadingConstraint()
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(parentView: ProgressMeter) {
        
        self.init(frame: .zero)
        self.parentView = parentView
    }
    
    override func didMoveToSuperview() {
        setupView()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        self.backgroundColor = .clear
    }
    
    private func setupLabel() {
        // Divider label
        
        if #available(iOS 9, *) {
            label.font = UIFont.preferredFont(forTextStyle: .caption2)
        } else {
            label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        }
        
        label.text = text
        label.textColor = textColor
        self.addSubview(label)
        setupLabelConstraint()
    }
    
    private func setupDivider() {
        // Divider line
        divider.backgroundColor = dividerColor
        self.addSubview(divider)
        setupDividerConstraint()
    }
    
    private func setupViewConstraint() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let heightAnchor = self.heightAnchor.constraint(equalTo: superView.heightAnchor)
        let widthAnchor = self.widthAnchor.constraint(equalTo: label.widthAnchor)
        let bottomAnchor = self.bottomAnchor.constraint(equalTo: superView.progressViewBottomAnchor)
        
        viewLeading = self.centerXAnchor.constraint(equalTo: superView.progressViewLeadingAnchor, constant: leadingOffset)
        
        NSLayoutConstraint.activate([heightAnchor, widthAnchor, bottomAnchor, viewLeading])
    }
    
    private func setupLabelConstraint() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let lblCenter = label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        var lblAnchor = label.topAnchor.constraint(equalTo: self.topAnchor, constant: -2.0)
        
        if !superView.annotationPositionOnTop {
            lblAnchor = label.topAnchor.constraint(equalTo: superView.progressViewBottomAnchor, constant: 4.0)
        }
        
        NSLayoutConstraint.activate([
            lblAnchor,
            lblCenter
        ])
    }
    
    private func setupDividerConstraint() {
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        let divTop = divider.topAnchor.constraint(equalTo: superView.progressViewTopAnchor)
        let divHeight = divider.heightAnchor.constraint(equalToConstant: dividerHeight)
        let divWidth = divider.widthAnchor.constraint(equalToConstant: 1)
        let divCenter = divider.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        
        NSLayoutConstraint.activate([
            divTop,
            divHeight,
            divWidth,
            divCenter
            ])
    }
    
    // MARK: - Helper
    
    private func updateLeadingConstraint() {
        if viewLeading.isActive {
            viewLeading.constant = leadingOffset
            self.layoutIfNeeded()
        }
    }
    
}
