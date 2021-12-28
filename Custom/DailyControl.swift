//
//  DailyControl.swift
//  WeatherApp
//
//  Created by Art on 29.07.2021.
//

import UIKit

enum Day: Int, CaseIterable {
    case monday
    case tuesday
    case wendsday
    case thursday
    case friday
    case saturday
    case sunday
    
    static var allCases: [Day] = [.monday, .tuesday, .wendsday, .thursday, .friday, .saturday, .sunday]
    
    var description: String {
        switch self {
        case .monday:
            return "ПН"
        case .tuesday:
            return "ВТ"
        case .wendsday:
            return "СР"
        case .thursday:
            return "ЧТ"
        case .friday:
            return "ПТ"
        case .saturday:
            return "СБ"
        case .sunday:
            return "ВС"
        }
    }
}

@IBDesignable
class DailyControl: UIControl {
    
    var selectedDay: Day = .monday {
        didSet {
            updateSelectedDay()
            sendActions(for: .valueChanged)
        }
    }
    
    private var stackView = UIStackView()
    private var buttons = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBaseUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBaseUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    
    private func setupBaseUI() {
        for day in Day.allCases {
            let button = UIButton()
            button.setTitle(day.description, for: .normal)
            button.setTitleColor(.lightGray, for: .normal)
            button.setTitleColor(.black, for: .selected)
            button.addTarget(self, action: #selector(selectNewDay(_:)), for: .touchUpInside)
            buttons.append(button)
        }
        stackView = UIStackView(arrangedSubviews: buttons)
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        self.addSubview(stackView)
    }
    
   @objc private func selectNewDay(_ sender: UIButton) {
        guard let index = buttons.firstIndex(of: sender),
              let day = Day(rawValue: index) else {return}
        selectedDay = day
    }
    
    
    @objc func updateSelectedDay() {
        for (index, button) in buttons.enumerated() {
            if let currentDay = Day(rawValue: index) {
                button.isSelected = currentDay == selectedDay
            }
        }
    }
}
