//
//  ViewController.swift
//  color
//
//  Created by Михаил Супрун on 19.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var referenceView: UIView!
    @IBOutlet weak var currentView: UIView!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var redSloder: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var colorLabel: UILabel!
    var currenColorName = ""
    var referenceColorName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        randomColor()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(gesture)
        changeProperties(red: redSloder.value, green: greenSlider.value, blue: blueSlider.value, view: currentView)
        
    }
    
    fileprivate func randomColor() {
        let count  = nameColorArray.count
        let randomIndex = Int.random(in: 0...count-1)
        referenceColorName = nameColorArray[randomIndex]
        changeProperties(red: Float(colorPropertiesArray[randomIndex][0])/256.0,
                         green: Float(colorPropertiesArray[randomIndex][1])/256.0,
                         blue: Float(colorPropertiesArray[randomIndex][2])/256.0,
                         view: referenceView)
        
        
        
    }
    
    @IBAction func againBtn(_ sender: UIButton) {

        randomColor()
        redSloder.value = 0.5
        greenSlider.value = 0.5
        blueSlider.value = 0.5
        colorLabel.text = ""
        //print(nameColorArray[randomIndex])
    }
    
    func getViewRGB (view : UIView) -> [Int]{
        let red = Int(Float(view.backgroundColor?.cgColor.components![0] ?? 0) * 256)
        let green = Int(Float(view.backgroundColor?.cgColor.components![1] ?? 0) * 256)
        let blue = Int(Float(view.backgroundColor?.cgColor.components![2] ?? 0) * 256)
        return [red,green, blue]
    }
    
    @IBAction func tryBtn(_ sender: Any) {
        // create the alert
        let title = currenColorName == referenceColorName ? "True" : "False"
        let message = "Reference  color: \(referenceColorName) \n Current color : \(currenColorName)."
        
         let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

         // add an action (button)
         alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

         // show the alert
         self.present(alert, animated: true, completion: nil)
    }
    
    @objc func didTap() {
        self.view.endEditing(true)
    }
<<<<<<< Updated upstream
    
    func rgbToLab (red: Int, green:Int, blue:Int) -> [Double]{
        
        let r = Double(red) / 255.000
        let g = Double(green) / 255.000
        let b = Double(blue) / 255.000
        //print ("rgb")
        //print (r, g ,b)
        let varR = r > 0.04045 ? pow((r+0.055)/1.055, 2.4)*100 : r / 12.92 * 100
        let varG = g > 0.04045 ? pow((g+0.055)/1.055, 2.4)*100 : g / 12.92 * 100
        let varB = b > 0.04045 ? pow((b+0.055)/1.055, 2.4)*100 : b / 12.92 * 100
        //print ("varR, varG, varB")
        //print (varR, varG, varB)
        

        let x = varR*0.4124+varG*0.3576+varB*0.1805
        let y = varR*0.2126+varG*0.7152+varB*0.0722
        let z = varR*0.0193+varG*0.1192+varB*0.9505
        
        //print ("XYZ")
        //print( x,y,z)

        let refWhiteX = 95.05
        let refWhiteY = 100.00
        let refWhiteZ = 108.89999999

        let refx = x/refWhiteX
        let refy = y/refWhiteY
        let refz = z/refWhiteZ

        
        let refX = refx > 0.008856 ? pow(refx, 1/3) : (refx * 7.787 + 16/116)
        let refY = refy > 0.008856 ? pow(refy, 1/3) : (refy * 7.787 + 16/116)
        let refZ = refz > 0.008856 ? pow(refz, 1/3) : (refz * 7.787 + 16/116)
        

        let cieL = 116 * refY - 16
        let cieA = 500 * (refX - refY)
        let cieB = 200 * (refY - refZ)
        return [cieL,cieA,cieB]
=======
    func changeProperties() {
            colorView.backgroundColor = UIColor(red: CGFloat(redSloder.value),
                                                green: CGFloat(greenSlider.value),
                                                blue: CGFloat(blueSlider.value),
                                                alpha: CGFloat(1))
>>>>>>> Stashed changes
        
    }
    func changeProperties(red: Float, green: Float, blue: Float, view: UIView) {

        
            view.backgroundColor = UIColor(red: CGFloat(red),
                                                green: CGFloat(green),
                                                blue: CGFloat(blue),
                                                alpha: CGFloat(1))
        var currentRGb = getViewRGB(view: currentView)
        let currentLab = rgbToLab(red: currentRGb[0], green: currentRGb[1], blue: currentRGb[2])
        let currentL = currentLab[0]
        let currenta = currentLab[1]
        let currentb = currentLab[2]
        var min = 999.0
        var i = -1
        var currentIndex = 0
        for (index,array) in colorPropertiesArray.enumerated(){
            let colorPrppertiesArrayLab = rgbToLab(red: array[0], green: array[1], blue: array[2])
            let colorPrppertiesArrayL = colorPrppertiesArrayLab[0]
            let colorPrppertiesArrayA = colorPrppertiesArrayLab[1]
            let colorPrppertiesArrayB = colorPrppertiesArrayLab[2]
            let delta = sqrt(pow(currentL-colorPrppertiesArrayL, 2)+pow(currenta-colorPrppertiesArrayA, 2)+pow(currentb-colorPrppertiesArrayB, 2))
            i = i+1
            //print("Delta = \(delta), i = \(i), min = \(min), currentIndex = \(currentIndex)")
            if delta < min{
                min = delta
                currentIndex = i
                //print("delta < min. New min = \(min)), currentIndex = \(currentIndex)")
                
            }
            
        }
        currenColorName = nameColorArray[currentIndex]
        
        
        //print("MIN")
        //print (min)
        
        
//        print ("currentRGB")
//        var currentRGB = getViewRGB(view: currentView)
//        print (getViewRGB(view: currentView))
//        print ("currentLab")
//        print (rgbToLab(red: currentRGB[0], green: currentRGB[1], blue: currentRGB[2]))
//        print ("referenceRGB")
//        var referenceRGB  = getViewRGB(view: referenceView)
//        print (getViewRGB(view: referenceView))
//        print ("referenceLab")
//        print (rgbToLab(red: referenceRGB[0], green: referenceRGB[1], blue: referenceRGB[2]))
        }
        
    
    @IBAction func changeGreenSlider(_ sender: Any) {
        changeProperties(red: redSloder.value, green: greenSlider.value, blue: blueSlider.value, view: currentView)
    }
    @IBAction func changeRedSlider(_ sender: Any) {
        changeProperties(red: redSloder.value, green: greenSlider.value, blue: blueSlider.value, view: currentView)
    }
    @IBAction func changeBlueSlider(_ sender: Any) {
<<<<<<< Updated upstream
        changeProperties(red: redSloder.value, green: greenSlider.value, blue: blueSlider.value, view: currentView)
=======
            changeProperties()
    }
    @IBAction func resetButtonAction(_ sender: Any) {
        greenSlider.value = 0.5
        redSloder.value = 0.5
        blueSlider.value = 0.5
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
>>>>>>> Stashed changes
    }


}


