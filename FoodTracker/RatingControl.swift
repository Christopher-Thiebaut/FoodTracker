//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Christopher Thiebaut on 12/4/17.
//  Copyright © 2017 Christopher Thiebaut. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    // MARK: Properties:
    
    private var ratingButtons = [UIButton]()
    var rating = 0{
        didSet{
            updateButtonSelectionStates()
        }
    }
    // TODO: IB DOES NOT UNDERSTAND THE SIZE OF THE STARS HERE.
    @IBInspectable var starSize: CGFloat = 44.0{
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5{
        didSet{
            setupButtons()
        }
    }
    

    // MARK: Initialization:
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    // MARK: Button Action:
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else{
            fatalError("The button \(button) is not in the ratings button array \(ratingButtons)")
        }
        //Determine what rating the user selected
        let selectedRating = index + 1
        //If the user tapped on the existing rating, we assume they intended to clear the rating (since they're not updating it)
        if selectedRating == rating{
            rating = 0
        }else{
            rating = selectedRating
        }
        
    }
    
    // MARK: Private Methods:
    
    private func setupButtons(){
        //Remove any existing buttons so control will conform to user specifications from IB when setup is complete.
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        //Set up new buttons
        //Load the images for the buttons
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        //Create the buttons
        for index in 0..<starCount{
            let button = UIButton()
            
            
            // Set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            //Set up constraints:
            
            //Disable automatically generated constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            
            //Set width and to value specified in IB (or default value if none was specified in IB)
            let widthConstraint = button.widthAnchor.constraint(lessThanOrEqualToConstant: starSize)
            widthConstraint.isActive = true
            widthConstraint.priority = .required
            
            let heightConstraint = button.widthAnchor.constraint(lessThanOrEqualToConstant: starSize)
            heightConstraint.isActive = true
            heightConstraint.priority = .required
            
            //Constrain width and height to be equal.  Required because the StackView the buttons inhabit may shrink the width if there is not enough space.
            let synchronizeHeightAndWidth = button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1)
            synchronizeHeightAndWidth.isActive = true
            synchronizeHeightAndWidth.priority = .required
            
            
            //Set the accessibility label
            button.accessibilityLabel = "Set \(index + 1) star rating."
            
            //Add the button to self
            addArrangedSubview(button)
            //Handle Button Presses
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            //Add to the rating button array
            ratingButtons.append(button)
        }
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates(){
        for (index, button) in ratingButtons.enumerated(){
            //If the button's index is less than the selected rating, highlight the button
            button.isSelected = index < rating
            //Set up accessibility
            
            //Set the hint for the currently selected star
            let hintString: String?
            if rating == index + 1{
                hintString = "Tap to reset rating to zero."
            }else{
                hintString = nil
            }
            //Calculate a value for the accessibility string
            let valueString: String
            switch (rating){
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set"
            default:
                valueString = "\(rating) stars set."
            }
            
            //Assign the hint string and value string
            button.accessibilityLabel = valueString
            button.accessibilityHint = hintString
        }
    }
    
}
