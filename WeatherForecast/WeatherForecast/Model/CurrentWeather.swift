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
        let temperature: Double
        let feelsLike: Double
        let minTemperature: Double
        let maxTemperature: Double
        let pressure: Int
        let humidity: Int
       
        var temperatureInCelsius: Double {
            let convertedValue = (self.temperature - 273)
            return round(convertedValue * 10) / 10
        }
        
        var feelsLikeInCelsius: Double {
            let convertedValue = (self.feelsLike - 273)
            return round(convertedValue * 10) / 10
        }
        
        var minTemperatureInCelsius: Double {
            let convertedValue = (self.minTemperature - 273)
            return round(convertedValue * 10) / 10
        }
        
        var maxTemperatureInCelsius: Double {
            let convertedValue = (self.maxTemperature - 273)
            return round(convertedValue * 10) / 10
        }
        
        enum CodingKeys: String, CodingKey {
            case temperature = "temp"
            case pressure, humidity
            case feelsLike = "feels_like"
            case minTemperature = "temp_min"
            case maxTemperature = "temp_max"
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
