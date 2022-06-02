//
//  WeatherModels.swift
//  WeatherApp
//
//  Created by admin on 06.05.2022.
//
// использую API https://openweathermap.org/api/one-call-api

import Foundation

// swiftlint:disable identifier_name

class TestWeatherModelDaily: Codable {
    let latitude: Float // Geographical coordinates of the location (latitude)
    let longitude: Float // Geographical coordinates of the location (longitude)
    let timezone: String // Timezone name for the requested location
    let timezoneOffset: Int // Shift in seconds from UTC
    let currentWeather: TestCurrentWeatherModel // Current weather data API response
    let minutelyWeather: [TestMinutelyWeatherModel] // Minute forecast weather data API response
    let hourlyWeather: [TestHourlyWeatherModel] // Hourly forecast weather data API response
    let dailyWeather: [TestDailyWeatherModel] // Daily forecast weather data API response
    let alerts: [TestAlertModel]? // National weather alerts data from major national weather warning systems

    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
        case timezone
        case timezoneOffset = "timezone_offset"
        case currentWeather = "current"
        case minutelyWeather = "minutely"
        case hourlyWeather = "hourly"
        case dailyWeather = "daily"
        case alerts = "alerts"
    }
}

class TestCurrentWeatherModel: Codable {
    let dt: Int // Current time, Unix, UTC
    let sunrise: Int  // Sunrise time, Unix, UTC
    let sunset: Int // Sunset time, Unix, UTC
    let temp: Float // Temperature. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit.
    let feelsLike: Float // Temperature. This temperature parameter accounts for the human perception of weather. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit.
    let pressure: Int // Atmospheric pressure on the sea level, hPa
    let humidity: Int // Humidity, %
    let dewPoint: Float // Atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit.
    let clouds: Int // Cloudiness, %
    let uvi: Float // Current UV index
    let visibility: Int // Average visibility, metres. The maximum value of the visibility is 10km
    let windSpeed: Float // Wind speed. Wind speed. Units – default: metre/sec, metric: metre/sec, imperial: miles/hour. How to change units used
    let windGust: Float?  // (where available) Wind gust. Units – default: metre/sec, metric: metre/sec, imperial: miles/hour. How to change units used
    let windDeg: Int // Wind direction, degrees (meteorological)

    let rain: RainForHour? // (where available) Rain volume for last hour, mm

    let snow: SnowForHour? // (where available) Snow volume for last hour, mm
    let weather: [WeatherModel]

    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case sunrise
        case sunset
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case dewPoint = "dew_point"
        case clouds
        case uvi
        case visibility
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case windDeg = "wind_deg"
        case rain // (where available) Rain volume for last hour, mm
        case snow // (where available) Snow volume for last hour, mm
        case weather
    }
}

class TestMinutelyWeatherModel: Codable {
    let dt: Int // Time of the forecasted data, unix, UTC
    let precipitation: Float // Precipitation volume, mm
}

class TestHourlyWeatherModel: Codable {
    let dt: Int // Current time, Unix, UTC

    let temp: Float // Temperature. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit.
    let feelsLike: Float // Temperature. This temperature parameter accounts for the human perception of weather. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit.
    let pressure: Int // Atmospheric pressure on the sea level, hPa
    let humidity: Int // Humidity, %
    let dewPoint: Float // Atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit.
    let clouds: Int // Cloudiness, %
    let uvi: Float // Current UV index
    let visibility: Int // Average visibility, metres. The maximum value of the visibility is 10km
    let windSpeed: Float // Wind speed. Wind speed. Units – default: metre/sec, metric: metre/sec, imperial: miles/hour. How to change units used
    let windGust: Float?  // (where available) Wind gust. Units – default: metre/sec, metric: metre/sec, imperial: miles/hour. How to change units used
    let windDeg: Int // Wind direction, degrees (meteorological)
    let pop: Float // Probability of pricipitation. from 0 - 0% to 1 - 100%.

    let rain: RainForHour? // (where available) Rain volume for last hour, mm

    let snow: SnowForHour? // (where available) Snow volume for last hour, mm
    let weather: [WeatherModel]

    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case dewPoint = "dew_point"
        case clouds
        case uvi
        case visibility
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case windDeg = "wind_deg"
        case pop
        case rain // (where available) Rain volume for last hour, mm
        case snow // (where available) Snow volume for last hour, mm
        case weather
    }
}

class TestDailyWeatherModel: Codable {
    let dt: Int // Current time, Unix, UTC
    let sunrise: Int  // Sunrise time, Unix, UTC
    let sunset: Int // Sunset time, Unix, UTC

    let moonrise: Int // Moonrise time, Unix, UTC
    let moonset: Int // Moonset time, Unix, UTC
    let moonPhase: Float // Moon phase. 0 and 1 are 'new moon', 0.25 is 'first quarter moon', 0.5 is 'full moon' and 0.75 is 'last quarter moon'. The periods in between are called 'waxing crescent', 'waxing gibous', 'waning gibous', and 'waning crescent', respectively.

    let temp: DailyTempModel // Temperature. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit.
    let feelsLike: DailyFeelsLikeModel // Temperature. This temperature parameter accounts for the human perception of weather. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit.
    let pressure: Int // Atmospheric pressure on the sea level, hPa
    let humidity: Int // Humidity, %
    let dewPoint: Float // Atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit.
    let clouds: Int // Cloudiness, %
    let uvi: Float // Current UV index
    let windSpeed: Float // Wind speed. Wind speed. Units – default: metre/sec, metric: metre/sec, imperial: miles/hour. How to change units used
    let windGust: Float?  // (where available) Wind gust. Units – default: metre/sec, metric: metre/sec, imperial: miles/hour. How to change units used
    let windDeg: Int // Wind direction, degrees (meteorological)
//    let rain: RainForHour? // (where available) Rain volume for last hour, mm
    let pop: Float // Probability of pricipitation. from 0 - 0% to 1 - 100%.
//    let snow: SnowForHour? // (where available) Snow volume for last hour, mm
    let weather: [WeatherModel]

    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case sunrise
        case sunset

        case moonset
        case moonrise
        case moonPhase = "moon_phase"

        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case dewPoint = "dew_point"
        case clouds
        case uvi
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case windDeg = "wind_deg"
//        case rain // (where available) Rain volume for last hour, mm
        case pop
//        case snow // (where available) Snow volume for last hour, mm
        case weather
    }
}

class DailyTempModel: Codable {
    let morn: Float?
    let day: Float?
    let eve: Float?
    let nigth: Float?
    let min: Float?
    let max: Float?
}

class DailyFeelsLikeModel: Codable {
    let morn: Float?
    let day: Float?
    let eve: Float?
    let nigth: Float?
}

class TestAlertModel: Codable {
    let senderName: String // Name of the alert source
    let event: String // Alert event name
    let start: Int  // Date and time of the start of the alert, Unix, UTC
    let end: Int // Date and time of the end of the alert, Unix, UTC
    let description: String // Description of the alert
    let tags: [String] // Type of severe weather

    enum CodingKeys: String, CodingKey {
        case senderName = "sender_name"
        case event
        case start
        case end
        case description
        case tags
    }
}

// MARK: общие вложенности для разных моделей
class WeatherModel: Codable {
    let id: Int // Weather condition id
    let main: String // Group of weather parameters (Rain, Snow, Extreme etc.)
    let description: String // Weather condition within the group (full list of weather conditions). Get the output in your language
    let icon: String // Weather icon id. How to get icons
}

class RainForHour: Codable {
    let oneHour: Float?

    enum Codingkeys: String, CodingKey {
        case oneHour = "1h"
    }
}

class SnowForHour: Codable {
    let oneHour: Float?

    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}
