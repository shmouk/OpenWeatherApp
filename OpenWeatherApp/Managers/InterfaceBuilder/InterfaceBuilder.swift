import UIKit

final class InterfaceBuilder {
    static func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .blue.withAlphaComponent(0.2)
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }
   
    static func makeLabel(title: TitleForUI = .undefined, font: FontForUI, textAlignment: NSTextAlignment = .center) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.textColor = UIColor(named: "TintColor")
        label.textAlignment = textAlignment
        label.font = font.size
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = title.text
        return label
    }
    
    static func makeView(blurIsNeeded: Bool = false) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        if blurIsNeeded {
            let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
            view.addSubview(blurView)
            blurView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                blurView.topAnchor.constraint(equalTo: view.topAnchor),
                blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        return view
    }
    
    static func makeSeparatorView(alpha: CGFloat = 0.4) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white.withAlphaComponent(alpha)
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = false
        return view
    }
    
    static func makeButton(withTitle: TitleForUI) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(withTitle.text, for: .normal)
        button.tintColor = UIColor(named: "TintColor")
        button.titleLabel?.font = FontForUI.big.size
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(named: "FgColor")
        return button
    }
    
    static func makeTextField(isPassword: Bool, placeholder: TitleForUI) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = isPassword
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.borderStyle = .line
        textField.font = FontForUI.regular.size
        textField.layer.borderColor = UIColor(named: "FgColor")?.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 16
        textField.layer.masksToBounds = true
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lightGray]
        let attributedPlaceholder = NSAttributedString(string: placeholder.text, attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        let leftPaddingView = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 48))
        leftPaddingView.isUserInteractionEnabled = false
        leftPaddingView.backgroundColor = .clear
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        return textField
    }
    
    static func makeImageView(contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = IconForUI.weatherIcon.image
        imageView.contentMode = contentMode
        imageView.clipsToBounds = true
        return imageView
    }
    static func makeRightBarButtonItem() -> UIBarButtonItem {
        let rightButton = UIBarButtonItem()
        rightButton.image = IconForUI.add.image
        rightButton.style = .plain
        return rightButton
    }
    
    static func makeLeftBarButtonItem() -> UIBarButtonItem {
        let rightButton = UIBarButtonItem()
        rightButton.image = IconForUI.reload.image
        rightButton.style = .plain
        return rightButton
    }
    
    static func makeActivityIndicatorView() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        return activityIndicator
    }
}

