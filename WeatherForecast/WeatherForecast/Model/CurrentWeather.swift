import Foundation

struct CurrentWeather: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    struct Coord: Codable {
        let lon: Double
        let lat: Double
    }
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Main: Codable {
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
    
    struct Wind: Codable {
        let speed: Double
        let deg: Int
    }
    
    struct Clouds: Codable {
        let all: Int
    }
    
    struct Sys: Codable {
        let type: Int
        let id: Int
        let message: Double
        let country: String
        let sunrise: Int
        let sunset: Int
    }
}
