//
//  HoursClnCell.swift
//  venkateshSoftwareGroupTask
//
//  Created by venkatesh prasad on 22/03/22.
//

import UIKit

class HoursClnCell: UICollectionViewCell {

    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.label
        label.text = ""
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let weatherImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.label
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = ""
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addViews()
    }

    func addViews(){

        addSubview(timeLabel)
        addSubview(tempLabel)
        addSubview(weatherImage)
      
        

        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 5),
            weatherImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            weatherImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
            weatherImage.topAnchor.constraint(equalTo: timeLabel.bottomAnchor,constant: 5),
            weatherImage.heightAnchor.constraint(equalToConstant: 50),
            weatherImage.widthAnchor.constraint(equalToConstant: 50),
        tempLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
        tempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
        tempLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor,constant: 5)])


    }



    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
