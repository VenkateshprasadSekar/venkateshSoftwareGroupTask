//
//  DaysTableViewCell.swift
//  venkateshSoftwareGroupTask
//
//  Created by venkatesh prasad on 22/03/22.
//

import UIKit

class DaysTableViewCell: UITableViewCell {


    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.label
        label.text = ""
        label.textAlignment = .left
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
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        
    }
   

    func addViews(){

        addSubview(dateLabel)
        addSubview(tempLabel)
        addSubview(weatherImage)
      
        

        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 0),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 5),
            dateLabel.heightAnchor.constraint(equalToConstant: 50),
//            weatherImage.leadingAnchor.constraint(lessThanOrEqualTo: dateLabel.trailingAnchor, constant: 5),
            weatherImage.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: 5),
            weatherImage.topAnchor.constraint(equalTo: self.topAnchor,constant: 0),
            weatherImage.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 5),
            weatherImage.heightAnchor.constraint(equalToConstant: 50),
            weatherImage.widthAnchor.constraint(equalToConstant: 50),
            tempLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 8),
            tempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            tempLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 0),
            tempLabel.heightAnchor.constraint(equalToConstant: 50)])


    }



    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
