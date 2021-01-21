import Foundation

struct CurrentWeather: Decodable {
    let locationCoordinate: LocationCoordinate
    let weather: [Weather]
    let base: String
    let main: CurrentWeatherMain
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: CurrentWeatherSys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    enum CodingKeys: String, CodingKey {
        case locationCoordinate = "coord"
        case weather, base, main, wind, clouds, dt, sys, timezone, id, name, cod
    }
    
    struct CurrentWeatherMain: Decodable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Int
        let humidity: Int
       
        var tempConvertedToCelsius: Double {
            let convertedValue = (self.temp - 273)
            return round(convertedValue * 10) / 10
        }
        
        var feelsLikeConvertedToCelsius: Double {
            let convertedValue = (self.feelsLike - 273)
            return round(convertedValue * 10) / 10
        }
        
        var tempMinConvertedToCelsius: Double {
            let convertedValue = (self.tempMin - 273)
            return round(convertedValue * 10) / 10
        }
        
        var tempMaxConvertedToCelsius: Double {
            let convertedValue = (self.tempMax - 273)
            return round(convertedValue * 10) / 10
        }
        
        enum CodingKeys: String, CodingKey {
            case temp, pressure, humidity
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }
    
    struct CurrentWeatherSys: Decodable {
        let type: Int
        let id: Int
        let message: Double
        let country: String
        let sunrise: Int
        let sunset: Int
    }
}
