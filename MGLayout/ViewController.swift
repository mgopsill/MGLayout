import UIKit

final class ViewController: UIViewController {

    private let headerStackView = UIStackView()
    private let headerBackgroundView = UIView()
    private let icon = UIImageView()
    private let titleLabel = UILabel()
    private let mainImageView = UIView()
    private let mainImageViewLabel = UILabel()
    private let storyByLabel = UILabel()
    private let multilineText = UILabel()
    private let bottomText = UILabel()
    private let bottomIconOne = UIImageView()
    private let bottomIconTwo = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let horizontalPadding: CGFloat = 20
        
        headerStackView.distribution = .fillProportionally
        headerStackView.alignment = .center
        headerStackView.spacing = 10
        headerStackView.place(on: view).pin(.top(to: view.safeAreaLayoutGuide),
                                            .leading(horizontalPadding),
                                            .trailing(horizontalPadding),
                                            .fixedHeight(44))
        headerBackgroundView.place(on: headerStackView).pin(.top,
                                                            .bottom,
                                                            .width)
        headerStackView.addArrangedSubview(icon)
        headerStackView.addArrangedSubview(titleLabel)

        headerBackgroundView.backgroundColor = .systemMint

        titleLabel.text = "Title about Curiosity"
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        icon.image = UIImage(systemName: "logo.playstation")
        
        mainImageView.backgroundColor = .blue
        mainImageView.layer.cornerRadius = 5
        mainImageView.place(on: view).pin(.top(to: headerStackView, .bottom, horizontalPadding),
                                          .leading(horizontalPadding),
                                          .trailing(horizontalPadding),                                          .fixedHeight(200))
        
        mainImageViewLabel.text = "Blue art by Bluey"
        mainImageViewLabel.font = .systemFont(ofSize: 8, weight: .ultraLight)
        mainImageViewLabel.place(on: view).pin(.top(to: mainImageView, .bottom, 2),
                                               .leading(horizontalPadding),
                                               .trailing(horizontalPadding))
        
        storyByLabel.text = "Story by Gigantosaurus"
        storyByLabel.place(on: view).pin(.top(to: mainImageViewLabel, .bottom, 12),
                                         .leading(horizontalPadding),
                                         .trailing(horizontalPadding))
        
        multilineText.text = "I have stolen princesses back from sleeping barrow kings. I burned down the town of Trebon. I have spent the night with Felurian and left with both my sanity and my life. "
        multilineText.numberOfLines = 0
        multilineText.font = .systemFont(ofSize: 20, weight: .thin)
        multilineText.place(on: view).pin(.top(to: storyByLabel, .bottom, 8),
                                          .leading(horizontalPadding),
                                          .trailing(horizontalPadding))
        
        bottomText.text = "LONG READ"
        bottomText.place(on: view).pin(.bottom(horizontalPadding), .leading(horizontalPadding))
        
        bottomIconOne.image = UIImage(systemName: "bolt.slash")
        bottomIconTwo.image = UIImage(systemName: "ladybug")

        bottomIconOne.place(on: view).pin(.bottom(horizontalPadding), .trailing(horizontalPadding))
        bottomIconTwo.place(on: view).pin(.bottom(horizontalPadding), .trailing(to: bottomIconOne, .leading, 10))
    }
}
