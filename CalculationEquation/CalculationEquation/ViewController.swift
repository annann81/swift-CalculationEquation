

import UIKit



class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var equationTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var acbutton: UIButton!
    @IBOutlet weak var backbutton: UIButton!
    @IBOutlet weak var EXPbutton: UIButton!
    @IBOutlet weak var dotbutton: UIButton!
    @IBOutlet weak var char0button: UIButton!
    @IBOutlet weak var char1button: UIButton!
    @IBOutlet weak var char2button: UIButton!
    @IBOutlet weak var char3button: UIButton!
    @IBOutlet weak var char4button: UIButton!
    @IBOutlet weak var char5button: UIButton!
    @IBOutlet weak var char6button: UIButton!
    @IBOutlet weak var char7button: UIButton!
    @IBOutlet weak var char8button: UIButton!
    @IBOutlet weak var char9button: UIButton!
    @IBOutlet weak var plusbutton: UIButton!
    @IBOutlet weak var mulusbutton: UIButton!
    @IBOutlet weak var mulbutton: UIButton!
    @IBOutlet weak var divbutton: UIButton!
    
    @IBOutlet weak var leftCbutton: UIButton!
    @IBOutlet weak var rightCbutton: UIButton!
    @IBOutlet weak var pibutton: UIButton!
    @IBOutlet weak var logbutton: UIButton!
    @IBOutlet weak var lnbutton: UIButton!
    @IBOutlet weak var ebutton: UIButton!
    @IBOutlet weak var exp_10button: UIButton!
    
    @IBOutlet weak var exbutton: UIButton!
    @IBOutlet weak var powerbutton: UIButton!
    @IBOutlet weak var x_1button: UIButton!
    @IBOutlet weak var x_2button: UIButton!
    @IBOutlet weak var x_3button: UIButton!
    @IBOutlet weak var sqrtbutton: UIButton!
    @IBOutlet weak var sqrt_3button: UIButton!
    @IBOutlet weak var sqrt_xbutton: UIButton!
    @IBOutlet weak var negbutton: UIButton!
    @IBOutlet weak var sinbutton: UIButton!
    @IBOutlet weak var cosbutton: UIButton!
    @IBOutlet weak var tanbutton: UIButton!
    @IBOutlet weak var sin_1button: UIButton!
    @IBOutlet weak var cos_1button: UIButton!
    @IBOutlet weak var tan_1button: UIButton!
    @IBOutlet weak var sinhbutton: UIButton!
    @IBOutlet weak var coshbutton: UIButton!
    @IBOutlet weak var tanhbutton: UIButton!
    @IBOutlet weak var sinh_1button: UIButton!
    @IBOutlet weak var cosh_1button: UIButton!
    @IBOutlet weak var tanh_1button: UIButton!
    
    @IBOutlet weak var ansbutton: UIButton!
    
    var equationList: String = ""
    var equArray: [String] = []
    
    
    var ansString : String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        equArray = []
        for i in 0..<equArray.count {
            equationList += equArray[i]
        }
        equationTextField.text = equationList

    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == equationTextField {
            equationTextField.resignFirstResponder()
            equationList = equationTextField.text!.description
        } else {
            textField.resignFirstResponder()
        }
        return true
    }



    @IBAction func equationTextFieldAction(sender: AnyObject) {
        equationTextField.text = equationList.description
    }

    @IBAction func resultButtonAction(sender: AnyObject) {
        resultLabel.text = "\(EquationCalculator(inEquation: equationList).calculate())"
        ansString = "\(EquationCalculator(inEquation: equationList).calculate())"
    }

    @IBAction func backButtonAction(sender: AnyObject) {
        if equationList.length() > 0 {
            equationList = equationList.substring(to: equationList.length()-1)
            equationTextField.text = equationList.description
        }
    }
    @IBAction func acbutton(sender: AnyObject) {
        if equationList.length() > 0 {
            equationList = ""
            equationTextField.text = equationList.description
        }
    }

    @IBAction func ansbutton(sender: AnyObject) {
        equationList += ansString
        equationTextField.text = equationList.description
    }

    @IBAction func char0buttonAction(sender: AnyObject) {
        equationList += "0"
        equationTextField.text = equationList.description
    }

    @IBAction func char1buttonAction(sender: AnyObject) {
        equationList += "1"
        equationTextField.text = equationList.description
    }
    @IBAction func char2buttonAction(sender: AnyObject) {
        equationList += "2"
        equationTextField.text = equationList.description
    }
    @IBAction func char3buttonAction(sender: AnyObject) {
        equationList += "3"
        equationTextField.text = equationList.description
    }
    @IBAction func char4buttonAction(sender: AnyObject) {
        equationList += "4"
        equationTextField.text = equationList.description
    }
    @IBAction func char5buttonAction(sender: AnyObject) {
        equationList += "5"
        equationTextField.text = equationList.description
    }
    @IBAction func char6buttonAction(sender: AnyObject) {
        equationList += "6"
        equationTextField.text = equationList.description
    }
    @IBAction func char7buttonAction(sender: AnyObject) {
        equationList += "7"
        equationTextField.text = equationList.description
    }
    @IBAction func char8buttonAction(sender: AnyObject) {
        equationList += "8"
        equationTextField.text = equationList.description
    }
    @IBAction func char9buttonAction(sender: AnyObject) {
        equationList += "9"
        equationTextField.text = equationList.description
    }
    @IBAction func dotbutton(sender: AnyObject) {
        equationList += "."
        equationTextField.text = equationList.description
    }
    @IBAction func plusbutton(sender: AnyObject) {
        equationList += "+"
        equationTextField.text = equationList.description
    }
    @IBAction func mulusbutton(sender: AnyObject) {
        equationList += "-"
        equationTextField.text = equationList.description
    }
    @IBAction func mulbutton(sender: AnyObject) {
        equationList += "*"
        equationTextField.text = equationList.description
    }
    @IBAction func divbutton(sender: AnyObject) {
        equationList += "/"
        equationTextField.text = equationList.description
    }
    @IBAction func rightCbutton(sender: AnyObject) {
        equationList += ")"
        equationTextField.text = equationList.description
    }
    @IBAction func leftCbutton(sender: AnyObject) {
        equationList += "("
        equationTextField.text = equationList.description
    }
    @IBAction func pibutton(sender: AnyObject) {
        equationList += "π"
        equationTextField.text = equationList.description
    }
    @IBAction func logbutton(sender: AnyObject) {
        equationList += "log"
        equationTextField.text = equationList.description
    }
    @IBAction func lnbutton(sender: AnyObject) {
        equationList += "ln"
        equationTextField.text = equationList.description
    }
    @IBAction func ebutton(sender: AnyObject) {
        equationList += "𝑒"
        equationTextField.text = equationList.description
    }
    @IBAction func exbutton(sender: AnyObject) {
        equationList += "𝑒^"
        equationTextField.text = equationList.description
    }
    @IBAction func powerbutton(sender: AnyObject) {
        equationList += "^"
        equationTextField.text = equationList.description
    }
    @IBAction func x_1button(sender: AnyObject) {
        equationList += "^(-1)"
        equationTextField.text = equationList.description
    }
    @IBAction func x_2button(sender: AnyObject) {
        equationList += "^2"
        equationTextField.text = equationList.description
    }
    @IBAction func x_3button(sender: AnyObject) {
        equationList += "^3"
        equationTextField.text = equationList.description
    }

    @IBAction func sqrtbutton(sender: AnyObject) {
        equationList += "^0.5"
        equationTextField.text = equationList.description
    }

    @IBAction func sqrt_3button(sender: AnyObject) {
        equationList += "^(1/3)"
        equationTextField.text = equationList.description
    }

    @IBAction func sqrt_xbutton(sender: AnyObject) {
        equationList += "ˣ√"
        equationTextField.text = equationList.description
    }

    @IBAction func negbutton(sender: AnyObject) {
        equationList += "*(-1)"
        equationTextField.text = equationList.description
    }

    @IBAction func sinbutton(sender: AnyObject) {
        equationList += "sin"
        equationTextField.text = equationList.description
    }
    @IBAction func cosbutton(sender: AnyObject) {
        equationList += "cos"
        equationTextField.text = equationList.description
    }
    @IBAction func tanbutton(sender: AnyObject) {
        equationList += "tan"
        equationTextField.text = equationList.description
    }
    @IBAction func sin_1button(sender: AnyObject) {
        equationList += "sin⁻¹"
        equationTextField.text = equationList.description
    }
    @IBAction func cos_1button(sender: AnyObject) {
        equationList += "cos⁻¹"
        equationTextField.text = equationList.description
    }
    @IBAction func tan_1button(sender: AnyObject) {
        equationList += "tan⁻¹"
        equationTextField.text = equationList.description
    }

    @IBAction func sinhbutton(sender: AnyObject) {
        equationList += "sinh"
        equationTextField.text = equationList.description
    }
    @IBAction func coshbutton(sender: AnyObject) {
        equationList += "cosh"
        equationTextField.text = equationList.description
    }
    @IBAction func tanhbutton(sender: AnyObject) {
        equationList += "tanh"
        equationTextField.text = equationList.description
    }
    @IBAction func sinh_1button(sender: AnyObject) {
        equationList += "sinh⁻¹"
        equationTextField.text = equationList.description
    }
    @IBAction func cosh_1button(sender: AnyObject) {
        equationList += "cosh⁻¹"
        equationTextField.text = equationList.description
    }
    @IBAction func tanh_1button(sender: AnyObject) {
        equationList += "tanh⁻¹"
        equationTextField.text = equationList.description
    }
    @IBAction func EXPbutton(sender: AnyObject) {
        equationList += "e"
        equationTextField.text = equationList.description
    }
    @IBAction func exp_10button(sender: AnyObject) {
        equationList += "10^"
        equationTextField.text = equationList.description
    }
    
    
}

