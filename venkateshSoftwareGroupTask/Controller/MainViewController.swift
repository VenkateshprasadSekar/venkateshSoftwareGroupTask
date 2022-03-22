//
//  MainViewController.swift
//  venkateshSoftwareGroupTask
//
//  Created by venkatesh prasad on 21/03/22.
//

import UIKit
enum weatherType : String{
    case C = "C"
    case F = "F"
}
class MainViewController: UIViewController {
    var weatherData : WeatherModel?
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    let cardView: UIView = {
        let viewcard = UIView()
        viewcard.translatesAutoresizingMaskIntoConstraints = false
        return viewcard
    }()
    let cityLbl : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    let currentTempLbl : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 28)
        return label
    }()
    let maxTempLbl : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 28)
        return label
    }()
    let typeButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("°C", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    @objc func pressed(sender:UIButton){
        if sender.titleLabel?.text == "°C"{
            tempby = weatherType.F
            sender.setTitle("°F", for: .normal)
            sender.setTitleColor(.white, for: .normal)
        }else{
            tempby = weatherType.C
            sender.setTitle("°C", for: .normal)
            sender.setTitleColor(.white, for: .normal)
        }
        updateUIData()
    }
    var tempby : weatherType = .C
    
    lazy var flowLayout:UICollectionViewFlowLayout = {
        let f = UICollectionViewFlowLayout()
        f.scrollDirection = UICollectionView.ScrollDirection.horizontal
        return f
    }()
    
    
    lazy var hoursClnView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.setCollectionViewLayout(self.flowLayout, animated: true)
        cv.dataSource = self
        cv.delegate = self
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(HoursClnCell.self, forCellWithReuseIdentifier: "MyCell")
        return cv
    }()
    lazy var dayTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(DaysTableViewCell.self, forCellReuseIdentifier: "MyTableCell")
        table.tableFooterView = UIView()
        table.backgroundColor = .clear
        table.allowsSelection = false
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.backgroundColor = .systemGray6
        self.view.addSubview(scrollView)
        scrollView.addSubview(cardView)
        cardView.addSubview(cityLbl)
        cardView.addSubview(maxTempLbl)
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowRadius = 2
        cardView.backgroundColor = .systemGray2
        cityLbl.textColor = .white
        cardView.addSubview(typeButton)
        cardView.addSubview(currentTempLbl)
        scrollView.addSubview(hoursClnView)
        hoursClnView.delegate = self
        hoursClnView.dataSource = self
        hoursClnView.backgroundColor = .clear
        scrollView.addSubview(dayTableView)
        dayTableView.delegate = self
        dayTableView.dataSource = self
        setUp()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDataFromApi(city: "chennai")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUp()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setUp()
    }
    func setUp(){
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            scrollView.heightAnchor.constraint(greaterThanOrEqualToConstant: self.view.frame.height),
            cardView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100),
            cardView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            cardView.heightAnchor.constraint(equalToConstant: 180),
            cardView.widthAnchor.constraint(equalTo: scrollView.widthAnchor,multiplier: 0.9),
            cityLbl.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            cityLbl.heightAnchor.constraint(equalToConstant: 25),
            cityLbl.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 10),
            cityLbl.widthAnchor.constraint(equalToConstant: self.view.frame.width - 50),
            typeButton.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8),
            typeButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            typeButton.heightAnchor.constraint(equalToConstant: 50),
            typeButton.widthAnchor.constraint(equalToConstant: 50),
            currentTempLbl.topAnchor.constraint(equalTo: cityLbl.bottomAnchor, constant: 10),
            currentTempLbl.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            currentTempLbl.heightAnchor.constraint(equalToConstant: 50),
            currentTempLbl.widthAnchor.constraint(equalToConstant: self.view.frame.width - 40),
            maxTempLbl.topAnchor.constraint(equalTo: currentTempLbl.bottomAnchor, constant: 10),
            maxTempLbl.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            maxTempLbl.heightAnchor.constraint(equalToConstant: 50),
            maxTempLbl.widthAnchor.constraint(equalToConstant: self.view.frame.width - 40),
            hoursClnView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            hoursClnView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 10),
            hoursClnView.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: -20),
            hoursClnView.widthAnchor.constraint(equalTo: scrollView.widthAnchor,multiplier: 0.9),
            hoursClnView.heightAnchor.constraint(equalToConstant: 120),
            dayTableView.topAnchor.constraint(equalTo: hoursClnView.bottomAnchor, constant: 8),
            dayTableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            dayTableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            dayTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10),
            dayTableView.widthAnchor.constraint(equalTo: scrollView.widthAnchor,multiplier: 0.9),
            dayTableView.heightAnchor.constraint(equalTo: scrollView.heightAnchor,multiplier: 0.8)
        ])
    }
    private func fetchDataFromApi(city:String){
        ApiHandler.shared.getApiCall(urlstr: ApiUrl.apiURL, city: city) { [weak self](success: WeatherModel?, err) in
            guard let weakSelf = self else{ return }
            if let err = err{
                weakSelf.showAlert(titlestr: "Error", messagestr: err.localizedDescription)
            }else{
                DispatchQueue.main.async {
                    weakSelf.weatherData = success
                    weakSelf.updateUIData()
                }
            }
        }
    }
    func updateUIData(){
        cityLbl.text = weatherData?.location?.name
        currentTempLbl.text = tempby == .C ? ((weatherData?.current?.temp_c?.description ?? "0") + " °C") : ((weatherData?.current?.temp_f?.description ?? "0") + " °F")
        let temp = tempby == .C ? ((weatherData?.forecast?.forecastday?[0].day?.mintemp_c?.description ?? "0") + " / " + (weatherData?.forecast?.forecastday?[0].day?.maxtemp_c?.description ?? "0") + " °C") : ((weatherData?.forecast?.forecastday?[0].day?.mintemp_f?.description ?? "0") + " / " + (weatherData?.forecast?.forecastday?[0].day?.maxtemp_f?.description ?? "0") + " °F")
        maxTempLbl.text = temp
        hoursClnView.reloadData()
        dayTableView.reloadData()
    }

}
extension MainViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData?.forecast?.forecastday?[0].hour?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! HoursClnCell
        let data = weatherData?.forecast?.forecastday?[0].hour?[indexPath.item]
        if let date = data?.time{
            cell.timeLabel.text = getDate(datestring: date)
        }
        if let icon = data?.condition?.icon,let imgurl = URL(string: "https:" + icon), let imgdata = try? Data(contentsOf: imgurl){
            cell.weatherImage.image = UIImage(data: imgdata)
        }else{
            cell.weatherImage.image = UIImage(systemName: "photo")
        }
        cell.backgroundColor = .systemGray3
        cell.layer.cornerRadius = 10
        cell.tempLabel.text = tempby == .C ? ((data?.temp_c?.description ?? "0") + " °C") : ((data?.temp_f?.description ?? "0") + " °F")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension MainViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData?.forecast?.forecastday?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableCell", for: indexPath) as! DaysTableViewCell
        let data = weatherData?.forecast?.forecastday?[indexPath.row]
        if let date = data?.date{
            cell.dateLabel.text = getDayOfWeek(datestring: date)
        }
        if let icon = data?.day?.condition?.icon,let imgurl = URL(string: "https:" + icon), let imgdata = try? Data(contentsOf: imgurl){
            cell.weatherImage.image = UIImage(data: imgdata)
        }else{
            cell.weatherImage.image = UIImage(systemName: "photo")
        }
        cell.backgroundColor = .clear
        cell.layer.cornerRadius = 10
        let daycon = data?.day?.condition?.text ?? ""
        let temp = tempby == .C ? ((data?.day?.mintemp_c?.description ?? "0") + " / " + (data?.day?.maxtemp_c?.description ?? "0") + " °C") : ((data?.day?.mintemp_f?.description ?? "0") + " / " + (data?.day?.maxtemp_f?.description ?? "0") + " °F")
        cell.tempLabel.text = daycon + " " + temp
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
