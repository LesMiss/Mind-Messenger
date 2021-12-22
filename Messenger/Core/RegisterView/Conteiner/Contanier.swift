//
//  Contanier.swift
//  Messenger
//
//  Created by Migel Lestev on 07.12.2021.
//

import UIKit
import SnapKit

protocol ContainerProtocol {
    var emailTextField: CustomTextField { get }
    var passwordTextField: CustomTextField { get }
}

class Container: UIView, ContainerProtocol {
    
    // constraints for animsting, file: Animate + ext.swift
    var nameTextFieldWidthConstraint: Constraint?
    var avatarHeightConstraint: Constraint?
    var emailTextFieldYConstraint: Constraint?
    var passwordTextFieldYConstraint: Constraint?
    var avatarWidthYconstraint: Constraint?
    
    
    //MARK: UI Elements
    lazy var scrollView = UIScrollView()
    
    // Text Filds
    lazy var nameTextField = CustomTextField(placeholder: " Name", keyboardType: .default)
    lazy var emailTextField = CustomTextField(placeholder: " Email", keyboardType: .default)
    lazy var passwordTextField = CustomTextField(placeholder: " Password", secure: true, keyboardType: .default)
    
    // Different elements
    // logo and user avatar (picker)
    lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "idia")
        logo.contentMode = .scaleAspectFit
        logo.clipsToBounds = true
        logo.layer.cornerRadius = 12
        return logo
    }()
    
    lazy var avatar: UIImageView = {
        let avatar = UIImageView()
        avatar.backgroundColor = .secondarySystemBackground
        avatar.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 12
        return avatar
    }()
    
    // text ....
    lazy var title: UILabel = {
        let title = UILabel()
        title.text = "Mind Mes"
        title.font = UIFont.systemFont(ofSize: 31, weight: .medium)
        return title
    }()
    
    lazy var bottomDescription: UILabel = {
        let description = UILabel()
        description.text = "i hope you enjoy this little idea, thanks for being a part of it all"
        description.lineBreakMode = .byWordWrapping
        description.numberOfLines = 0
        description.textColor = .dynamic
        description.font = UIFont.systemFont(ofSize: 10, weight: .light)
        return description
    }()
    
    // load spinner + blur
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.backgroundColor = .secondarySystemFill
        spinner.layer.cornerRadius = 10
        spinner.hidesWhenStopped = true
        spinner.color = .dynamic
        return spinner
    }()
    
    lazy var visualEffectView: UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        visualEffectView.frame = CGRect(x: 0, y: 0, width: scrollView.bounds.width, height: scrollView.contentSize.height * 2)
        visualEffectView.alpha = 0
        return visualEffectView
    }()
    
    // other
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Sign In", "Register"])
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.apportionsSegmentWidthsByContent = true
        segmentedControl.selectedSegmentTintColor = .systemBlue
        return segmentedControl
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        button.layer.cornerRadius = 12
        button.backgroundColor = .systemBlue
        return button
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemRed
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return label
    }()
    
    //MARK: closure for action
    var regButtonClosure: (() -> Void)?
    var segmentClosure: (() -> Void)?
    
    // Designated Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        setupTargets()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // add action for button and segmentedControl
    private func setupTargets() {
        segmentedControl.addTarget(self, action: #selector(segmentAction), for: .primaryActionTriggered)
        registerButton.addTarget(self, action: #selector(handleTap), for: .primaryActionTriggered)
    }
    
    @objc func handleTap() {
        regButtonClosure?()
    }
    
    @objc func segmentAction() {
        segmentClosure?()
    }
}
