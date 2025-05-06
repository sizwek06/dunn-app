//
//  WeatherCardView.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/04.
//

import SwiftUICore

extension TodoView {
    func makeWeatherCard() -> some View {
        HStack(spacing: 10) {
            Image(self.checkWeatherCondition())
                .resizable()
                .frame(width: TodoStrings.returnDesiredWidth() / 6,
                       height: TodoStrings.returnDesiredWidth() / 6)
                .padding(.leading, 20)
            weatherText()
                .padding(.horizontal, 10)
                .padding(.trailing, 20)
        }
        .padding(.top, 10)
        .background(.generalBackround)
        .clipShape(RoundedRectangle(cornerRadius: 24.0))
        .shadow(radius: 8)
        .frame(width: TodoStrings.returnDesiredWidth(),
               alignment: .center)
    }
    
    func weatherText() -> some View {
        VStack() {
            // TODO: DRY on Text
            Text(TodoStrings.currentTemperature + String(self.viewModel.currentTemp) + "°")
                .font(.custom(TodoStrings.sfProRounded,
                              size: dynamicTitleSize,
                              relativeTo: .body))
                .foregroundColor(.appearanceColor)
            VStack {
                Text(TodoStrings.sunriseTime + String(self.viewModel.sunRiseTime))
                    .font(.custom(TodoStrings.sfProRounded,
                                  size: TodoStrings.returnDesiredWidth() / 30))
                    .foregroundColor(.appearanceColor)
                Text(TodoStrings.sunsetTime + String(self.viewModel.sunSetTime))
                    .font(.custom(TodoStrings.sfProRounded,
                                  size: TodoStrings.returnDesiredWidth() / 30))
                    .foregroundColor(.appearanceColor)
            }
            HStack(spacing: 4.0) {
                Image(systemName: "location")
                Text(viewModel.city + ", " + viewModel.country)
            }
            .font(.custom(TodoStrings.sfProRounded,
                          size: TodoStrings.returnDesiredWidth() / 30,
                          relativeTo: .body))
            .foregroundColor(.greyText)
            .padding(.bottom, 16)
        }
        .padding(.top, 16)
        .onTapGesture {
            Task {
                await self.getWeatherDetails()
            }
        }
    }
    
    func checkWeatherCondition() -> String {
        // Note: URL not found for condition.icon URL
        let condition = self.viewModel.condition?.code ?? 0
        
        switch condition {
        case 1000:
            return "Sunny"
        case 1003, 1006:
            return "PartlyCloudy"
        case 1030:
            return "Cloudy"
        case 1009:
            return "CloudyDark"
        case 1063, 1150, 1153, 1168:
            return "Rainy"
        case 1183, 1186, 1189:
            return "LightRain"
        case 1273, 1276, 1279, 1192, 1195, 1198, 1201, 1204, 1207:
            return "HeavyRain"
        default:
            return "SunnyNight"
        }
    }
}
