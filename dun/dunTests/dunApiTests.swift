//
//  dunTests.swift
//  dunTests
//
//  Created by Sizwe Khathi on 2025/05/03.
//

import XCTest
@testable import dun

final class dunTests: XCTestCase {
    
    private var weatherRequestsMock: WeatherApiMockHelper!
    var viewModelUnderTest: ContentViewModel!
    let dunapiMock = WeatherApiMockHelper()
    
    override func setUpWithError() throws {
        super.setUp()
        weatherRequestsMock = WeatherApiMockHelper()
//        viewModelUnderTest = ContentViewModel(apiClient: weatherRequestsMock! as! DunApiProtocol)
        // TODO: Resolve DunApiProtocol and test ContentViewModel
    }

    override func tearDownWithError() throws {
        weatherRequestsMock.reset()
        weatherRequestsMock = nil
    }

    func testWeather() async throws {
        do {
            dunapiMock.invokeWeather = true
            let result = try await dunapiMock.asyncRequest(endpoint: WeatherEndpoints.getCurrent, responseModel: WeatherResponseModel.self)
            XCTAssertEqual(result.location.country, "South Africa")
            
            XCTAssertEqual(result.current.condition.code, 1000)
            XCTAssertEqual(result.current.condition.text, "Sunny")
            XCTAssertEqual(result.current.tempC, 17.4)
            XCTAssertEqual(result.current.isDay, 1)
        } catch {
            print(error)
            throw error
        }
    }

    func testAstronomy() async throws {
        do {
            dunapiMock.invokeAstronomy = true
            let result = try await dunapiMock.asyncRequest(endpoint: WeatherEndpoints.getCurrent, responseModel: WeatherAstronomyResponseModel.self)
            XCTAssertEqual(result.astronomy.astro.sunrise, "06:22 AM")
            XCTAssertEqual(result.astronomy.astro.sunset, "09:14 PM")
        } catch {
            print(error)
            throw error
        }
    }

    func testError() async throws {
        do {
            dunapiMock.invokeError = true
            let result = try await dunapiMock.asyncRequest(endpoint: WeatherEndpoints.getCurrent, responseModel: WeatherErrorDetails.self)
            XCTAssertEqual(result.weatherError.errorCode, 2008)
            XCTAssertEqual(result.weatherError.errorDescription, "API KEY HAS BEEN DISABLED.")
            XCTAssertEqual(result.localizedDescription, "The operation couldn’t be completed. (dunTests.WeatherErrorDetails error 1.)")
            
        } catch {
            print(error)
            throw error
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
