import UIKit

class ViewController: UIViewController {
    
    var currentWeatherData: CurrentWeather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decodeJSONFile()
        
        guard let data = currentWeatherData else {
            return
        }
        
        print(data.locationCoordinate.latitude)
        print(data.rain)
        print(data.rain?.threeHour)
    }
    
    func decodeJSONFile() {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        let dataAssetName: String = "CurrentWeathertestData"
        guard let dataAsset: NSDataAsset = NSDataAsset.init(name: dataAssetName) else {
            return
        }
        
        do {
            self.currentWeatherData = try jsonDecoder.decode(CurrentWeather.self, from: dataAsset.data)
        } catch DecodingError.dataCorrupted(let context) {
            print("데이터가 손상되었거나 유효하지 않습니다.")
            print(context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
        } catch DecodingError.keyNotFound(let codingkey, let context) {
            print("주어진 키를 찾을수 없습니다.")
            print(codingkey.intValue ?? 0 , codingkey.stringValue , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
        } catch DecodingError.typeMismatch(let type, let context) {
            print("주어진 타입과 일치하지 않습니다.")
            print(type.self , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
        } catch DecodingError.valueNotFound(let type, let context) {
            print("예상하지 않은 null 값이 발견되었습니다.")
            print(type.self , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
        } catch {
            print("그외 에러가 발생했습니다.")
        }
    }
}

