import UIKit

class ButtonView: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    private func setupButton() {
        self.backgroundColor = .systemBlue
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 10
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }

    func configure(title: String, action: Selector, target: Any) {
        self.setTitle(title, for: .normal)
        self.addTarget(target, action: action, for: .touchUpInside)
    }
}
