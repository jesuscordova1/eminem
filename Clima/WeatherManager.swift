

import Foundation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, artist: ArtistModel)
    
}

struct WeatherManager {
    let musicUrl = "https://api.deezer.com/artist/"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(id: String) {
        let urlString = "\(musicUrl)\(id)"
        perfomRequest(urlString: urlString)
    }
    
    
    
    
    func perfomRequest(urlString: String) {
        // Hacemos los 4 pasos
        
        //1.Crear un URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            
            let session = URLSession(configuration: .default)
            //3. Darle la session una tarea
            let task = session.dataTask(with: url) {(data, response, error)
                in
                if error != nil{
                    print(error)
                    return
                }
                if let safeData = data {
                    if  let artist = self.parseJSON(weatherData: safeData) {
                            delegate?.didUpdateWeather(self, artist: artist)
                    }
                }
                
            }
            //4. empezar la tarea
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> ArtistModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let artistName = decodedData.name
            let artistId = decodedData.id
            let artistPicture = decodedData.picture
            
            let artist = ArtistModel(idArtist: artistId, nameArtist: artistName, pictureArtist: artistPicture)
            return artist
            
        } catch {
            print(error)
            return nil
        }
        
    }
   
  
    
}
