//
//  ViewController.swift
//  Hava Durumu
//
//  Created by Barış Aydemir on 28.08.2023.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var havaDurumuLabel: UILabel!
    
    @IBOutlet weak var sehirTextField: UITextField!
    
    @IBOutlet weak var btn: UIButton!
    
    var pickerView:UIPickerView?
    
    var sehirler:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sehirler = [
            "Adana", "Adiyaman", "Afyonkarahisar", "Agri", "Aksaray", "Amasya", "Ankara",
            "Antalya", "Ardahan", "Artvin", "Aydin", "Balikesir", "Bartin", "Batman",
            "Bayburt", "Bilecik", "Bingol", "Bitlis", "Bolu", "Burdur", "Bursa", "Canakkale",
            "Cankiri", "Corum", "Denizli", "Diyarbakir", "Duzce", "Edirne", "Elazig",
            "Erzincan", "Erzurum", "Eskisehir", "Gaziantep", "Giresun", "Gumushane",
            "Hakkari", "Hatay", "Igdir", "Isparta", "Istanbul", "Izmir", "Kahramanmaras",
            "Karabuk", "Karaman", "Kars", "Kastamonu", "Kayseri", "Kirikkale", "Kirklareli",
            "Kirsehir", "Kilis", "Kocaeli", "Konya", "Kutahya", "Malatya", "Manisa",
            "Mardin", "Mersin", "Mugla", "Mus", "Nevsehir", "Nigde", "Ordu", "Osmaniye",
            "Rize", "Sakarya", "Samsun", "Sanliurfa", "Siirt", "Sinop", "Sivas", "Sirnak",
            "Tekirdag", "Tokat", "Trabzon", "Tunceli", "Usak", "Van", "Yalova", "Yozgat", "Zonguldak"
        ]
        
        pickerView = UIPickerView()
        pickerView?.delegate = self
        pickerView?.dataSource = self
        
        sehirTextField.inputView = pickerView
        
        let toolbar = UIToolbar()
        toolbar.tintColor = UIColor.red
        toolbar.sizeToFit()
        
        let tamamButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(ViewController.tamamTikla))
        
        let boslukButon = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let iptalButton = UIBarButtonItem(title: "İptal", style: .plain, target: self, action: #selector(self.iptalTikla))
        
        toolbar.setItems([iptalButton,boslukButon,tamamButton], animated: true)
        
        sehirTextField.inputAccessoryView = toolbar
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sehirler.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sehirler[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sehirTextField.text = sehirler[row]
    }
    @objc func tamamTikla(){
       view.endEditing(true)
    }
    
    @objc func iptalTikla(){
        sehirTextField.text = ""
        sehirTextField.placeholder = "Lütfen bir şehir seçiniz."
         view.endEditing(true)
    }

    @IBAction func sonucButton(_ sender: Any) {
        
        let city = sehirTextField.text ?? ""
        
        if city.isEmpty {
            
        let alert = UIAlertController(title: "UYARI!", message: "Lütfen şehir adı giriniz.", preferredStyle: .alert)
            
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
        alert.addAction(cancelButton)
            
         self.present(alert, animated: true, completion: nil)
            
        }else {
            
            let vc = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as! SonucVC
            
            vc.city = city
            
            self.show(vc, sender: nil)
            
        }
    }
    
}

