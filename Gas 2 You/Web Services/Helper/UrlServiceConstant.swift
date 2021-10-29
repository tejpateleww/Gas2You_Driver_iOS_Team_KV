//
//  UrlServiceConstant.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 04/06/21.
//

import Foundation

class UrlConstant{
    //MARK:- WebService Header Key
    static let HeaderKey = "key"
    static let XApiKey = "x-api-key"
    static let AppHostKey = "Gas2You951*#*"
    
    static let ResponseMessage = "message"
    
    //MARK:- Message Title
    static let Required = "Required"
    static let Success = "Success"
    static let Failed = "Failed"
    static let Error = "Error"
    static let Status = "status"
    static let SessionExpired = "Your session is expired! Please login again."
    static let SomethingWentWrong = "There is some server side error, Please try again after some time!"
    static let NoInternetConnection =  "The Internet connection appears to be offline, Please connect to the internet."
    static let RequestTimeOut = "Poor internet connection, Check your internet connection or try again."
    static let LocationRequired = "Location service is disabled. To re-enable, please go to Settings and turn on Location Service for this application."
    static let Submit = "USubmit"
    static let OTPSent = "Your OTP for Verification"
    
    
    static let Ok = "Ok"
    static let Yes = "Yes"
    static let Cancel = "Cancel"
    static let No = "No"
    static let Retry = "Retry"
    static let SelectCard = "Select Card"
    static let Continue = "Continue"
    static let Settings = "Settings"
    static let Logout = "Logout"
    static let Help = "Help"
    static let Invalid = "Invalid"
    static let Expiry = "Expires"
    
    //Validation Message
    static let ValidPhoneNo = "Please enter valid mobile number."
    static let ValidOtpNo = "Please enter valid otp."
    static let AgeIsRequired = "Age is required"
    static let AgeMustNumber = "Age must be a number!"
    static let InvalidAgeNumber = "Invalid age number!"
    static let Age18YearsOld = "You have to be over 18 years old to user our app :)"
    static let RequiredVerificationCode = "Please enter verification code"
    static let InvalidVerificationCode = "Please enter valid verification code"
    static let LogoutMessage = "Are you sure you want to logout?"
    static let InvalidEmail = "Invalid e-mail Address."
    static let EnterEmail = "Please enter email"
    static let InvalidCardNumber = "Your card number is invalid"
    static let PasswordNotMatch = "Password and confirm password does not match."
    
    
}

let SessionExpiredResponseDic = [UrlConstant.ResponseMessage: UrlConstant.SessionExpired]
let SomethingWentWrongResponseDic = [UrlConstant.ResponseMessage: UrlConstant.SomethingWentWrong]
let NoInternetResponseDic = [UrlConstant.ResponseMessage: UrlConstant.NoInternetConnection]



