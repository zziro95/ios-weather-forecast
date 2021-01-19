//
//  WeatherForecastTests - WeatherForecastTests.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import XCTest
@testable import WeatherForecast

class WeatherForecastTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCurrentWeatherData() {
        var currentWeatherData: CurrentWeather?
        let jsonDecoder: JSONDecoder = JSONDecoder()
        let dataAssetName: String = "CurrentWeathertestData"
        guard let dataAsset: NSDataAsset = NSDataAsset.init(name: dataAssetName) else {
            return
        }
        
        do {
            currentWeatherData = try jsonDecoder.decode(CurrentWeather.self, from: dataAsset.data)
        } catch DecodingError.dataCorrupted(let context) {
            print("데이터가 손상되었거나 유효하지 않습니다.")
            print(context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
        } catch DecodingError.keyNotFound(let codingkey, let context) {
            print("주어진 키를 찾을수 없습니다.")
            print(codingkey.intValue ?? Optional(nil)! , codingkey.stringValue , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
        } catch DecodingError.typeMismatch(let type, let context) {
            print("주어진 타입과 일치하지 않습니다.")
            print(type.self , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
        } catch DecodingError.valueNotFound(let type, let context) {
            print("예상하지 않은 null 값이 발견되었습니다.")
            print(type.self , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
        } catch {
            print("그외 에러가 발생했습니다.")
        }
        
        guard let data = currentWeatherData else {
            return
        }
        
        var expectedValue: Double = 282.55
        XCTAssertEqual(data.main.temp, expectedValue)
        XCTAssertNotEqual(data.main.tempConvertedToCelsius, expectedValue)
        expectedValue = 281.86
        XCTAssertEqual(data.main.feelsLike, expectedValue)
        expectedValue = 280.37
        XCTAssertEqual(data.main.tempMin, expectedValue)
        expectedValue = 284.26
        XCTAssertEqual(data.main.tempMax, expectedValue)
        
        expectedValue = 9.5
        XCTAssertNotEqual(data.main.tempConvertedToCelsius, expectedValue)
        expectedValue = 9.6
        XCTAssertEqual(data.main.tempConvertedToCelsius, expectedValue)
        expectedValue = 8.9
        XCTAssertEqual(data.main.feelsLikeConvertedToCelsius, expectedValue)
        expectedValue = 7.9
        XCTAssertNotEqual(data.main.tempMinConvertedToCelsius, expectedValue)
        expectedValue = 7.4
        XCTAssertEqual(data.main.tempMinConvertedToCelsius, expectedValue)
        expectedValue = 11.3
        XCTAssertEqual(data.main.tempMaxConvertedToCelsius, expectedValue)
        
        let expectedString = "Mountain View"
        XCTAssertEqual(data.name, expectedString)
    }
    
    func testFiveDayWeatherData() {
        var fiveDayWeatherData: FiveDayWeather?
        let jsonDecoder: JSONDecoder = JSONDecoder()
        let dataAssetName: String = "FiveDayWeathertestData"
        guard let dataAsset: NSDataAsset = NSDataAsset.init(name: dataAssetName) else {
            return
        }
        
        do {
            fiveDayWeatherData = try jsonDecoder.decode(FiveDayWeather.self, from: dataAsset.data)
        } catch DecodingError.dataCorrupted(let context) {
            print("데이터가 손상되었거나 유효하지 않습니다.")
            print(context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
        } catch DecodingError.keyNotFound(let codingkey, let context) {
            print("주어진 키를 찾을수 없습니다.")
            print(codingkey.intValue ?? Optional(nil)! , codingkey.stringValue , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
        } catch DecodingError.typeMismatch(let type, let context) {
            print("주어진 타입과 일치하지 않습니다.")
            print(type.self , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
        } catch DecodingError.valueNotFound(let type, let context) {
            print("예상하지 않은 null 값이 발견되었습니다.")
            print(type.self , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
        } catch {
            print("그외 에러가 발생했습니다.")
        }
        
        guard let data = fiveDayWeatherData else {
            print("**************")
            print("데이터 할당 안됨")
            return
        }
        
        let testData: String = "300"
        XCTAssertEqual(data.cod, testData)
//        var expectedValue: Double = 293.55
//        XCTAssertEqual(data.list[0].main.temp, 3)
//        XCTAssertEqual(data.list[1].main.temp, 4)
    }
}
