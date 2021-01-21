import Foundation

struct FiveDayWeather: Decodable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [List]
    let city: City
    
    struct List: Decodable {
        let main: FiveDayWeatherMain
        let weather: [Weather]
        let clouds: Clouds
        let visibility: Int
        let pop: Double
        let rain: Rain
        let sys: FiveDayWeatherSys
        let dtTxt: String
        
        enum CodingKeys: String, CodingKey {
            case main, weather, clouds, visibility, pop, rain, sys
            case dtTxt = "dt_txt"
        }
        
        struct FiveDayWeatherMain: Decodable {
            let temp: Double
            let feelsLike: Double
            let tempMin: Double
            let tempMax: Double
            let pressure: Int
            let seaLevel: Int
            let grndLevel: Int
            let humidity: Int
            let tempKf: Double
           
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
                case seaLevel = "sea_level"
                case grndLevel = "grnd_level"
                case tempKf = "temp_kf"
            }
        }
        
        struct Rain: Decodable {
            let threeHour: Double
            
            enum CodingKeys: String, CodingKey {
                case threeHour = "3h"
            }
        }
        
        struct FiveDayWeatherSys: Decodable {
            let pod: String
        }
    }
    
    struct City: Decodable {
        let id: Int
        let name: String
        let coord: Coord
        let country: String
        let timezone: Int
        let sunrise: Int
        let sunset: Int
    }
}
