//
//  ContentCell.swift
//  Example
//
//  Created by Miran Brajsa on 21/09/16.
//  Copyright © 2016 Five Agency. All rights reserved.
//

import Foundation
import UIKit

class ContentCell: UITableViewCell {

    private var viewModel: ContentCellViewModel?

    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var headerMarkerView: UIView!
    @IBOutlet private weak var exampleNumberLabel: UILabel!

    @IBOutlet private weak var descriptionView: UIView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet private weak var resultLabel: UILabel!

    @IBOutlet private weak var actionButtonView: UIView!
    @IBOutlet private weak var actionButton: UIButton!
    
    @IBOutlet private weak var sliderView: UIView!
    @IBOutlet private weak var slider: UISlider!
    @IBOutlet private weak var firstSliderTitleLabel: UILabel!
    @IBOutlet private weak var firstSliderResultTitleLabel: UILabel!
    @IBOutlet private weak var secondSliderResultView: UIView!
    @IBOutlet private weak var secondSliderTitleLabel: UILabel!
    @IBOutlet private weak var secondSliderResultTitleLabel: UILabel!

    override func awakeFromNib() {
        setupAppearance()
    }

    func setup(withViewModel viewModel: ContentCellViewModel) {
        self.viewModel = viewModel

        setupContent()
        setupLayout()
    }

    private func setupAppearance() {
        guard
            let headerTitleFont = UIFont.headerTitleTextFont(),
            let descriptionLabelFont = UIFont.descriptionTextFont(),
            let actionButtonFont = UIFont.buttonTextFont(),
            let resultLabelFont = UIFont.resultLabelTextFont(),
            let resultValueLabelFont = UIFont.resultValueTextFont()
            else {
                return
        }
        
        sliderView.backgroundColor = UIColor.white
        let thumbImage = UIImage(named: "SliderDot")
        slider.setThumbImage(thumbImage, for: .normal)
        slider.setThumbImage(thumbImage, for: .highlighted)
        slider.minimumTrackTintColor = UIColor.highlightRedColor()
        slider.maximumTrackTintColor = UIColor.headerLightGrayColor()
        firstSliderTitleLabel.font = resultLabelFont
        firstSliderTitleLabel.textColor = UIColor.descriptionLightGrayColor()
        firstSliderResultTitleLabel.font = resultValueLabelFont
        firstSliderResultTitleLabel.textColor = UIColor.descriptionDarkGrayColor()
        secondSliderTitleLabel.font = resultLabelFont
        secondSliderTitleLabel.textColor = UIColor.descriptionLightGrayColor()
        secondSliderResultTitleLabel.font = resultValueLabelFont
        secondSliderResultTitleLabel.textColor = UIColor.descriptionDarkGrayColor()
        
        headerView.backgroundColor = UIColor.headerLightGrayColor()
        headerMarkerView.backgroundColor = UIColor.headerDarkGrayColor()
        exampleNumberLabel.font = headerTitleFont
        exampleNumberLabel.textColor = UIColor.headerTitleGrayColor()
        descriptionView.backgroundColor = UIColor.white
        descriptionLabel.font = descriptionLabelFont
        descriptionLabel.textColor = UIColor.descriptionDarkGrayColor()
        actionButtonView.backgroundColor = UIColor.white
        actionButton.titleLabel?.font = actionButtonFont
        actionButton.setTitleColor(UIColor.highlightRedColor(), for: .normal)
        resultTitleLabel.font = resultLabelFont
        resultTitleLabel.textColor = UIColor.descriptionLightGrayColor()
        resultLabel.font = resultValueLabelFont
        resultLabel.textColor = UIColor.descriptionDarkGrayColor()
    }
    
    private func setupContent() {
        guard let viewModel = viewModel else { return }

        exampleNumberLabel.text = viewModel.exampleTitle
        descriptionLabel.text = viewModel.description
        actionButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        resultLabel.text = viewModel.initialResult
        firstSliderTitleLabel.text = viewModel.firstSliderTitle
        secondSliderTitleLabel.text = viewModel.secondSliderTitle

        let (firstResult, secondResult) = viewModel.initialSliderResults
        firstSliderResultTitleLabel.text = firstResult
        secondSliderResultTitleLabel.text = secondResult

        if let sliderConfiguration = viewModel.sliderConfiguration {
            slider.minimumValue = sliderConfiguration.minimumValue
            slider.maximumValue = sliderConfiguration.maximumValue
            slider.value = sliderConfiguration.startingValue
        }
    }

    private func setupLayout() {
        guard let viewModel = viewModel else { return }

        actionButtonView.isHidden = !viewModel.shouldDisplayActionButtonView()
        sliderView.isHidden = !viewModel.shouldDisplaySliderView()
        secondSliderResultView.isHidden = !viewModel.shouldDisplaySecondSliderResultView()
    }

    @IBAction private func actionButtonTapped(_ sender: AnyObject) {
        guard let viewModel = viewModel else { return }

        let result = viewModel.updateButtonTapResult()
        resultLabel.text = result
    }
    
    @IBAction private func sliderValueChanged(_ sender: UISlider) {
        guard let viewModel = viewModel else { return }

        let (firstResult, secondResult) = viewModel.updateSliderResults(newValue: sender.value)
        firstSliderResultTitleLabel.text = firstResult
        secondSliderResultTitleLabel.text = secondResult
    }
}
