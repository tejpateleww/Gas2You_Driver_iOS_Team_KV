//
//  CodableResponseServiceClass.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 04/06/21.
//

import Foundation

class CodableService {
    class func getResponseFromSession<C:Codable>(request: URLRequest, codableObj: C.Type, completion: @escaping  (_ status: Bool,_ apiMessage: String,_ modelObj: C?,_ dataDic: Any) -> ()){
        var responseDic : Any?
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                
                //MARK:- Api Request Error
                if let ERR = error{
                    completion(false, ERR.localizedDescription, nil, [UrlConstant.ResponseMessage,ERR.localizedDescription])
                    
                }else{
                    
                    //MARK:- HTTP Response
                    if let httpResponse = response as? HTTPURLResponse{
                        print("Status code of the request:=>",httpResponse.statusCode)
                        var statusCode : Bool = false
                        
                        //MARK:- Response Data
                            if  let responseData = data {
                            
                            //MARK:- Response Dictionary
                            responseDic = getResponseDicFromData(responseData: responseData)
                            
                            //MARK:- Api Message
                            let alertMessage = Utilities.getMessageFromApiResponse(param: responseDic ?? "")
                            
                            //MARK:- Success Status Code
                            if httpResponse.statusCode == 200{
                                
                                //MARK:- Api Status
                                if let mainDic = responseDic as? [String: Any], let APIStatus = mainDic[UrlConstant.Status] as? Bool {
                                    statusCode = APIStatus
                                }
                                
                                //MARK:- Response Model
                                if let obj = getCodableObjectFromData(jsonData: responseData, codableObj: codableObj){
                                    completion(statusCode, alertMessage, obj, responseDic ?? SomethingWentWrongResponseDic)
                                }else{
                                    completion(statusCode, alertMessage, nil, responseDic ?? SomethingWentWrongResponseDic)
                                }
                                
                                //MARK:- Client Side Error
                            }else if httpResponse.statusCode == 400{
                                completion(statusCode, alertMessage, nil, responseDic ?? SomethingWentWrongResponseDic)
                                
                                //MARK:- Session Expoire -> Do Force Logout
                            }else if httpResponse.statusCode == 403{
                                completion(statusCode, UrlConstant.SessionExpired, nil, SessionExpiredResponseDic)
                                
                                //MARK:- Server Error
                            }else if httpResponse.statusCode == 500{
                                completion(statusCode, UrlConstant.SomethingWentWrong, nil, responseDic ?? SomethingWentWrongResponseDic)
                            }
                        }else{
                            completion(statusCode, UrlConstant.SomethingWentWrong, nil, responseDic ?? SomethingWentWrongResponseDic)
                        }
                    }
                }
            }
        }.resume()
    }
    
    class func getCodableObjectFromData<C:Codable>(jsonData: Data, codableObj: C.Type) -> C?{
        let obj = try? JSONDecoder().decode(codableObj, from: jsonData)
        return obj
    }
    
    class func getResponseDicFromData(responseData: Data) -> Any{
        let jso = try? JSONSerialization.jsonObject(with: responseData)
        
        if let jsonObj = jso{
            print("The webservice call response \n \(String(describing: jso))")
            return jsonObj
        }else{
            return SomethingWentWrongResponseDic
        }
    }
}
