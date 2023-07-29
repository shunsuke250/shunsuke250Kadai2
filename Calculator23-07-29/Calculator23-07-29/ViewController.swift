//
//  ViewController.swift
//  Calculator23-07-29
//
//  Created by 副山俊輔 on 2023/07/29.
//

import UIKit
import SnapKit
import SwiftUI

class ViewController: UIViewController {
    
    private let firstTextField: UITextField = {
        $0.placeholder = "数値を入力"
        $0.borderStyle = .roundedRect
        $0.keyboardType = .numberPad
        return $0
    }(UITextField())
    
    private let secondTextField: UITextField = {
        $0.placeholder = "数値を入力"
        $0.borderStyle = .roundedRect
        $0.keyboardType = .numberPad
        return $0
    }(UITextField())
    
    private lazy var operationsSegmentedControl: UISegmentedControl = {
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.systemBlue.cgColor
        return $0
    }(UISegmentedControl(items: ["+", "-", "×", "÷"]))
    
    private let calculateButton: UIButton = {
        $0.setTitle("計算", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        return $0
    }(UIButton())
    
    private let answerLabel: UILabel = {
        return $0
    }(UILabel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstrains()
        
        calculateButton.addAction(.init { _ in
            let answer = self.calculate()
            // Validation
            if answer == 0 {
                self.answerLabel.text = "エラーが発生しました"
            } else if answer == 1 {
                self.answerLabel.text = "演算子を選択してください"
            } else {
                self.answerLabel.text = ("\(answer)")
            }
        }, for: .touchUpInside)
    }
    
    func calculate() -> Double {
        guard let num1 = Double(firstTextField.text ?? "0"),
              let num2 = Double(secondTextField.text ?? "0") else {
            return 0 // Error
        }
        let operation = operationsSegmentedControl.selectedSegmentIndex
        
        switch operation {
        case 0:
            return Double(num1 + num2)
        case 1:
            return Double(num1 - num2)
        case 2:
            return Double(num1 * num2)
        case 3:
            return Double(num1 / num2)
        default:
            return 1 // Error
        }
    }
    
    func setConstrains() {
        view.addSubview(firstTextField)
        view.addSubview(secondTextField)
        view.addSubview(operationsSegmentedControl)
        view.addSubview(calculateButton)
        view.addSubview(answerLabel)
        
        firstTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
        }
        secondTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(150)
        }
        operationsSegmentedControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(200)
        }
        calculateButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(250)
        }
        answerLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(300)
        }
    }
}

//MARK: - SwiftUI Preview
struct UIViewControllerPreviewWrapper:UIViewControllerRepresentable{
    let previewController:UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        return self.previewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct ViewController_Preview: PreviewProvider {
    
    static var previews: some View {
        UIViewControllerPreviewWrapper(previewController: ViewController())
    }
}
