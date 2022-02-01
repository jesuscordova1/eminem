import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate  {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var SearchTextField: UITextField!
    
    var weatherManager =  WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conditionImageView.layer.cornerRadius = 20
        
        SearchTextField.delegate = self
        weatherManager.delegate = self
        
    }

    @IBAction func SearchPressed(_ sender: UIButton) {
        SearchTextField.endEditing(true)
        print(SearchTextField.text!)
    }
    
    @IBAction func LabelUpdate(_ sende: UIButton){
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        SearchTextField.endEditing(true)
        print(SearchTextField.text!)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = SearchTextField.text {
            weatherManager.fetchWeather(id: city)
        }
        SearchTextField.text = ""
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager,artist: ArtistModel) {
           DispatchQueue.main.async {
               
               let url = URL(string: artist.pictureArtist)
                   if let data = try? Data(contentsOf: url!)
                   {
                       self.conditionImageView.image = UIImage(data: data)!
                   }

               
               self.temperatureLabel.text = artist.nameArtist
               self.cityLabel.text = String(artist.idArtist)
               
           }
       }
    
}

