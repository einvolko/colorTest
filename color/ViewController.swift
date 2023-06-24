//
//  ViewController.swift
//  color
//
//  Created by Михаил Супрун on 19.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var redSloder: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var widthSlider: UISlider!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(gesture)
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        changeProperties()
    }
    @objc func didTap() {
        self.view.endEditing(true)
    }
    func changeProperties() {
            colorView.layer.frame = CGRect(x: colorView.frame.origin.x,
                                           y: colorView.frame.origin.y,
                                           width: CGFloat(widthSlider.value),
                                           height: CGFloat(heightSlider.value))
        
            colorView.backgroundColor = UIColor(red: CGFloat(redSloder.value),
                                                green: CGFloat(greenSlider.value),
                                                blue: CGFloat(blueSlider.value),
                                                alpha: CGFloat(alphaSlider.value))
        
        redTextField.text = "\(Int(redSloder.value * 256))"
        greenTextField.text = "\(Int(greenSlider.value * 256))"
        blueTextField.text = "\(Int(blueSlider.value * 256))"
       
        let red = Int(Float(colorView.backgroundColor?.cgColor.components![0] ?? 0) * 256)
        let green = Int(Float(colorView.backgroundColor?.cgColor.components![1] ?? 0) * 256)
        let blue = Int(Float(colorView.backgroundColor?.cgColor.components![2] ?? 0) * 256)
        for (index,array) in colorPropertiesArray.enumerated(){
            if (red == array[0] && green == array[1] && blue == array[2]) {
                colorLabel.text = nameColorArray[index]
                break
            } else {colorLabel.text = "No match"}
        }
    }
    @IBAction func changeGreenSlider(_ sender: Any) {
           changeProperties()
    }
    @IBAction func changeRedSlider(_ sender: Any) {
            changeProperties()
    }
    @IBAction func changeBlueSlider(_ sender: Any) {
            changeProperties()
    }
    @IBAction func changeAlphaSlider(_ sender: Any) {
            changeProperties()
    }
    @IBAction func resetButtonAction(_ sender: Any) {
        greenSlider.value = 0.5
        redSloder.value = 0.5
        blueSlider.value = 0.5
        alphaSlider.value = 0.5
        widthSlider.value = 373
        heightSlider.value = 124
        changeProperties()
    }
    @IBAction func changeWidthSlider(_ sender: Any) {
        changeProperties()
    }
    @IBAction func changeHeightSlider(_ sender: Any) {
        changeProperties()
    }
    @IBAction func redTextFieldAction(_ sender: Any) {
        guard let unwrappedText = redTextField.text else {return}
        guard let unwrappedFloat = Float(unwrappedText) else {return}
        redSloder.value = unwrappedFloat / 256.0
        changeProperties()
    }
    @IBAction func greenTextFieldAction(_ sender: Any) {
        guard let unwrappedText = greenTextField.text else {return}
        guard let unwrappedFloat = Float(unwrappedText) else {return}
        greenSlider.value = unwrappedFloat / 256.0
        changeProperties()
    }
    @IBAction func blueTextFieldAction(_ sender: Any) {
        guard let unwrappedText = blueTextField.text else {return}
        guard let unwrappedFloat = Float(unwrappedText) else {return}
        blueSlider.value = unwrappedFloat / 256.0
        changeProperties()
    }
}
extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
