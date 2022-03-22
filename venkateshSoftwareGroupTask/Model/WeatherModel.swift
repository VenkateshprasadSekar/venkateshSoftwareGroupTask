//
//  WeatherModel.swift
//  venkateshSoftwareGroupTask
//
//  Created by venkatesh prasad on 21/03/22.
//

import Foundation

struct WeatherModel: Codable{
    var location: LocationDataModel?
    var current: CurrentDataModel?
    var forecast: ForecastDataModel?
}
struct LocationDataModel: Codable{
    var name: String?
    var region: String?
    var country: String?
    var lat: Double?
    var lon: Double?
    var tz_id: String?
    var localtime_epoch: Int?
    var localtime: String?
}
struct ConditionDataModel : Codable{
    var text: String?
    var icon: String?
    var code: Int?
}
struct CurrentDataModel: Codable{
    var last_updated_epoch: Int?
    var last_updated: String?
    var temp_c: Double?
    var temp_f: Double?
    var is_day: Int?
    var condition: ConditionDataModel?
    var wind_mph: Double?
    var wind_kph: Double?
    var wind_degree: Int?
    var wind_dir: String?
    var pressure_mb: Double?
    var pressure_in: Double?
    var precip_mm: Double?
    var precip_in: Double?
    var humidity: Int?
    var cloud: Int?
    var feelslike_c: Double?
    var feelslike_f: Double?
    var vis_km: Double?
    var vis_miles: Double?
    var uv: Double?
    var gust_mph: Double?
    var gust_kph: Double?
}
struct ForecastDataModel: Codable{
    var forecastday: [ForecastForDayDataModel]?
}
struct DayDataModel: Codable{
    var maxtemp_c: Double?
    var maxtemp_f: Double?
    var mintemp_c: Double?
    var mintemp_f: Double?
    var avgtemp_c: Double?
    var avgtemp_f: Double?
    var maxwind_mph: Double?
    var maxwind_kph: Double?
    var totalprecip_mm: Double?
    var totalprecip_in: Double?
    var avgvis_km: Double?
    var avgvis_miles: Double?
    var avghumidity: Double?
    var daily_will_it_rain: Int?
    var daily_chance_of_rain: Int?
    var daily_will_it_snow: Int?
    var daily_chance_of_snow: Int?
    var condition: ConditionDataModel?
    var uv: Double?
}
struct AstroDataModel: Codable{
    var sunrise: String?
    var sunset: String?
    var moonrise: String?
    var moonset: String?
    var moon_phase: String?
    var moon_illumination: String?
}
struct HourDataModel: Codable{
    var time_epoch: Int?
    var time: String?
    var temp_c: Double?
    var temp_f: Double?
    var is_day: Int?
    var condition: ConditionDataModel?
    var wind_mph: Double?
    var wind_kph: Double?
    var wind_degree: Int?
    var wind_dir: String?
    var pressure_mb: Double?
    var pressure_in: Double?
    var precip_mm: Double?
    var precip_in: Double?
    var humidity: Int?
    var cloud: Int?
    var feelslike_c: Double?
    var feelslike_f: Double?
    var windchill_c: Double?
    var windchill_f: Double?
    var heatindex_c: Double?
    var heatindex_f: Double?
    var dewpoint_c: Double?
    var dewpoint_f: Double?
    var will_it_rain: Int?
    var chance_of_rain: Int?
    var will_it_snow: Int?
    var chance_of_snow: Int?
    var vis_km: Double?
    var vis_miles: Double?
    var gust_mph: Double?
    var gust_kph: Double?
    var uv: Double?
}
struct ForecastForDayDataModel: Codable{
    var date: String?
    var date_epoch: Int?
    var day: DayDataModel?
    var astro: AstroDataModel?
    var hour: [HourDataModel]?
}
