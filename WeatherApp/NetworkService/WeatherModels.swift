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
    /// Geographical coordinates of the location (latitude)
    let latitude: Float
    /// Geographical coordinates of the location (longitude)
    let longitude: Float
    /// Timezone name for the requested location
    let timezone: String
    /// Shift in seconds from UTC
    let timezoneOffset: Int
    /// Current weather data API response
    let currentWeather: TestCurrentWeatherModel
    /// Minute forecast weather data API response
    let minutelyWeather: [TestMinutelyWeatherModel]
    /// Hourly forecast weather data API response
    let hourlyWeather: [TestHourlyWeatherModel]
    /// Daily forecast weather data API response
    let dailyWeather: [TestDailyWeatherModel]
    /// National weather alerts data from major national weather warning systems
    let alerts: [TestAlertModel]?

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
    /// Current time, Unix, UTC
    let dt: Int
    /// Sunrise time, Unix, UTC
    let sunrise: Int
    /// Sunset time, Unix, UTC
    let sunset: Int
    /// Temperature. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit.
    let temp: Float
    /// Temperature. This temperature parameter accounts for the human perception of weather. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit.
    let feelsLike: Float
    /// Atmospheric pressure on the sea level, hPa
    let pressure: Int
    /// Humidity, %
    let humidity: Int
    /// Atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit.
    let dewPoint: Float
    /// Cloudiness, %
    let clouds: Int
    /// Current UV index
    let uvi: Float
    /// Average visibility, metres. The maximum value of the visibility is 10km
    let visibility: Int
    /// Wind speed. Wind speed. Units – default: metre/sec, metric: metre/sec, imperial: miles/hour. How to change units used
    let windSpeed: Float
    /// (where available) Wind gust. Units – default: metre/sec, metric: metre/sec, imperial: miles/hour. How to change units used
    let windGust: Float?
    /// Wind direction, degrees (meteorological)
    let windDeg: Int

    /// (where available) Rain volume for last hour, mm
    let rain: RainForHour?

    /// (where available) Snow volume for last hour, mm
    let snow: SnowForHour?
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
        /// (where available) Rain volume for last hour, mm
        case rain
        /// (where available) Snow volume for last hour, mm
        case snow
        case weather
    }
}

class TestMinutelyWeatherModel: Codable {
    /// Time of the forecasted data, unix, UTC
    let dt: Int
    /// Precipitation volume, mm
    let precipitation: Float
}

class TestHourlyWeatherModel: Codable {
    /// Current time, Unix, UTC
    let dt: Int
    /// Temperature. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit.
    let temp: Float
    /// Temperature. This temperature parameter accounts for the human perception of weather. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit.
    let feelsLike: Float
    /// Atmospheric pressure on the sea level, hPa
    let pressure: Int
    /// Humidity, %
    let humidity: Int
    /// Atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit.
    let dewPoint: Float
    /// Cloudiness, %
    let clouds: Int
    /// Current UV index
    let uvi: Float
    /// Average visibility, metres. The maximum value of the visibility is 10km
    let visibility: Int
    /// Wind speed. Wind speed. Units – default: metre/sec, metric: metre/sec, imperial: miles/hour. How to change units used
    let windSpeed: Float
    /// (where available) Wind gust. Units – default: metre/sec, metric: metre/sec, imperial: miles/hour. How to change units used
    let windGust: Float?
    /// Wind direction, degrees (meteorological)
    let windDeg: Int
    /// Probability of pricipitation. from 0 - 0% to 1 - 100%.
    let pop: Float
    /// (where available) Rain volume for last hour, mm
    let rain: RainForHour?
    /// (where available) Snow volume for last hour, mm
    let snow: SnowForHour?
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
        /// (where available) Rain volume for last hour, mm
        case rain
        /// (where available) Snow volume for last hour, mm
        case snow
        case weather
    }
}

class TestDailyWeatherModel: Codable {
    /// Current time, Unix, UTC
    let dt: Int
    /// Sunrise time, Unix, UTC
    let sunrise: Int
    /// Sunset time, Unix, UTC
    let sunset: Int
    /// Moonrise time, Unix, UTC
    let moonrise: Int
    /// Moonset time, Unix, UTC
    let moonset: Int
    /// Moon phase. 0 and 1 are 'new moon', 0.25 is 'first quarter moon', 0.5 is 'full moon' and 0.75 is 'last quarter moon'. The periods in between are called 'waxing crescent', 'waxing gibous', 'waning gibous', and 'waning crescent', respectively.
    let moonPhase: Float
    /// Temperature. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit.
    let temp: DailyTempModel
    /// Temperature. This temperature parameter accounts for the human perception of weather. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit.
    let feelsLike: DailyFeelsLikeModel
    /// Atmospheric pressure on the sea level, hPa
    let pressure: Int
    /// Humidity, %
    let humidity: Int
    /// Atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit.
    let dewPoint: Float
    /// Cloudiness, %
    let clouds: Int
    /// Current UV index
    let uvi: Float
    /// Wind speed. Wind speed. Units – default: metre/sec, metric: metre/sec, imperial: miles/hour. How to change units used
    let windSpeed: Float
    /// (where available) Wind gust. Units – default: metre/sec, metric: metre/sec, imperial: miles/hour. How to change units used
    let windGust: Float?
    /// Wind direction, degrees (meteorological)
    let windDeg: Int
    /// Probability of pricipitation. from 0 - 0% to 1 - 100%.
    let pop: Float
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
        case pop
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
    /// Name of the alert source
    let senderName: String
    /// Alert event name
    let event: String
    /// Date and time of the start of the alert, Unix, UTC
    let start: Int
    /// Date and time of the end of the alert, Unix, UTC
    let end: Int
    /// Description of the alert
    let description: String
    /// Type of severe weather
    let tags: [String]

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
    /// Weather condition id
    let id: Int
    /// Group of weather parameters (Rain, Snow, Extreme etc.)
    let main: String
    /// Weather condition within the group (full list of weather conditions). Get the output in your language
    let description: String
    /// Weather icon id. How to get icons
    let icon: String
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
