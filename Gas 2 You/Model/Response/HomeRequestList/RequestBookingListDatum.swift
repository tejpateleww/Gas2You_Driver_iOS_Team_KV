//
//  RequestBookingListDatum.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 20, 2021

import Foundation

class RequestBookingListDatum : Codable {
    
    let colorName : String?
    let completeOrderDateTime : String?
    let customerContactNumber : String?
    let customerContactNumberCode : String?
    let customerId : String?
    let date : String?
    let finalAmount : String?
    let id : String?
    let invoiceNumber : String?
    let latitude : String?
    let longitude : String?
    let mainServiceName : String?
    let makeName : String?
    let modelName : String?
    let orderStatus : String?
    let parkingLocation : String?
    let plateNumber : String?
    let price : String?
    let pricePerGallon : String?
    let serviceId : String?
    let status : String?
    let statusLabel : String?
    let subServiceId : String?
    let subServiceName : String?
    let time : String?
    let totalAmount : String?
    let totalGallon : String?
    let vehicleId : String?
    let invoiceUrl : String?
    let services : [OrderComplateService]?
    
    
    enum CodingKeys: String, CodingKey {
        case colorName = "color_name"
        case completeOrderDateTime = "complete_order_date_time"
        case customerContactNumber = "customer_contact_number"
        case customerContactNumberCode = "customer_contact_number_code"
        case customerId = "customer_id"
        case date = "date"
        case finalAmount = "final_amount"
        case id = "id"
        case invoiceNumber = "invoice_number"
        case latitude = "latitude"
        case longitude = "longitude"
        case mainServiceName = "main_service_name"
        case makeName = "make_name"
        case modelName = "model_name"
        case orderStatus = "order_status"
        case parkingLocation = "parking_location"
        case plateNumber = "plate_number"
        case price = "price"
        case pricePerGallon = "price_per_gallon"
        case serviceId = "service_id"
        case status = "status"
        case statusLabel = "status_label"
        case subServiceId = "sub_service_id"
        case subServiceName = "sub_service_name"
        case time = "time"
        case totalAmount = "total_amount"
        case totalGallon = "total_gallon"
        case vehicleId = "vehicle_id"
        case invoiceUrl = "invoice_url"
        case services = "services"
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        colorName = try values.decodeIfPresent(String.self, forKey: .colorName)
        completeOrderDateTime = try values.decodeIfPresent(String.self, forKey: .completeOrderDateTime)
        customerContactNumber = try values.decodeIfPresent(String.self, forKey: .customerContactNumber)
        customerContactNumberCode = try values.decodeIfPresent(String.self, forKey: .customerContactNumberCode)
        customerId = try values.decodeIfPresent(String.self, forKey: .customerId)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        finalAmount = try values.decodeIfPresent(String.self, forKey: .finalAmount)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        invoiceNumber = try values.decodeIfPresent(String.self, forKey: .invoiceNumber)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        mainServiceName = try values.decodeIfPresent(String.self, forKey: .mainServiceName)
        makeName = try values.decodeIfPresent(String.self, forKey: .makeName)
        modelName = try values.decodeIfPresent(String.self, forKey: .modelName)
        orderStatus = try values.decodeIfPresent(String.self, forKey: .orderStatus)
        parkingLocation = try values.decodeIfPresent(String.self, forKey: .parkingLocation)
        plateNumber = try values.decodeIfPresent(String.self, forKey: .plateNumber)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        pricePerGallon = try values.decodeIfPresent(String.self, forKey: .pricePerGallon)
        serviceId = try values.decodeIfPresent(String.self, forKey: .serviceId)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        statusLabel = try values.decodeIfPresent(String.self, forKey: .statusLabel)
        subServiceId = try values.decodeIfPresent(String.self, forKey: .subServiceId)
        subServiceName = try values.decodeIfPresent(String.self, forKey: .subServiceName)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        totalAmount = try values.decodeIfPresent(String.self, forKey: .totalAmount)
        totalGallon = try values.decodeIfPresent(String.self, forKey: .totalGallon)
        vehicleId = try values.decodeIfPresent(String.self, forKey: .vehicleId)
        invoiceUrl = try values.decodeIfPresent(String.self, forKey: .invoiceUrl)
        services = try values.decodeIfPresent([OrderComplateService].self, forKey: .services)
    }
    
}
