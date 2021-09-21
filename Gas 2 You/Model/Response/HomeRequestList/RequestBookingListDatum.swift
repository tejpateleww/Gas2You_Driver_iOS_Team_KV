//
//  RequestBookingListDatum.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 20, 2021

import Foundation

class RequestBookingListDatum : Codable {
    
    let colorName : String?
    let customerId : String?
    let date : String?
    let id : String?
    let latitude : String?
    let longitude : String?
    let mainServiceName : String?
    let makeName : String?
    let modelName : String?
    let parkingLocation : String?
    let plateNumber : String?
    let serviceId : String?
    let status : String?
    let statusLabel : String?
    let subServiceId : String?
    let subServiceName : String?
    let time : String?
    let vehicleId : String?
    
    enum CodingKeys: String, CodingKey {
        case colorName = "color_name"
        case customerId = "customer_id"
        case date = "date"
        case id = "id"
        case latitude = "latitude"
        case longitude = "longitude"
        case mainServiceName = "main_service_name"
        case makeName = "make_name"
        case modelName = "model_name"
        case parkingLocation = "parking_location"
        case plateNumber = "plate_number"
        case serviceId = "service_id"
        case status = "status"
        case statusLabel = "status_label"
        case subServiceId = "sub_service_id"
        case subServiceName = "sub_service_name"
        case time = "time"
        case vehicleId = "vehicle_id"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        colorName = try values.decodeIfPresent(String.self, forKey: .colorName)
        customerId = try values.decodeIfPresent(String.self, forKey: .customerId)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        mainServiceName = try values.decodeIfPresent(String.self, forKey: .mainServiceName)
        makeName = try values.decodeIfPresent(String.self, forKey: .makeName)
        modelName = try values.decodeIfPresent(String.self, forKey: .modelName)
        parkingLocation = try values.decodeIfPresent(String.self, forKey: .parkingLocation)
        plateNumber = try values.decodeIfPresent(String.self, forKey: .plateNumber)
        serviceId = try values.decodeIfPresent(String.self, forKey: .serviceId)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        statusLabel = try values.decodeIfPresent(String.self, forKey: .statusLabel)
        subServiceId = try values.decodeIfPresent(String.self, forKey: .subServiceId)
        subServiceName = try values.decodeIfPresent(String.self, forKey: .subServiceName)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        vehicleId = try values.decodeIfPresent(String.self, forKey: .vehicleId)
    }
    
}
