//
//  AFNetworkingServiceManager.swift
//  Qomply
//
//  Created by AMV Tel Pvt Ltd on 08/08/18.
//  Copyright © 2018 AMV Tel Pvt Ltd. All rights reserved.
//

import UIKit
import AFNetworking

private var serviceManger : AFNetworkingServiceManager!

class AFNetworkingServiceManager: NSObject {
    
    let manager = AFHTTPSessionManager()
    
    class var sharedmanager :AFNetworkingServiceManager {
        if serviceManger == nil {
            
            serviceManger = AFNetworkingServiceManager()
            
        }
        return serviceManger
        
    }
    
    
    
    func initWithManager() -> String {
        let url : URL = URL(string: ObeidiConstants.API.MAIN_DOMAIN)!
        let stringURL : String = url.absoluteString
        
        return stringURL
        
    }
    
    
    
    func cancelRequest() {
        var urlTask = URLSessionTask()
        self.manager.session.getAllTasks { (task) in
            
            //                print("TASK = \(task.count)")
            
            if task.count > 0 {
                
                for tas in task {
                    
                    urlTask = tas
                    
                    urlTask.cancel()
                    
                    //                        print("TASK CANCELED")
                    
                }
                
                
                
            }
            
        }
        
    }
    
    
    
    func parseLinkUsingGetMethod(_ servicename:String,parameter:NSDictionary?,completion:@escaping (Bool?,AnyObject?,NSError?) -> Void){
        
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/html","text/json") as? Set<String>
        
        let strUrl : String = self.initWithManager()
        
        manager.get(strUrl+servicename, parameters: nil, progress: nil, success: { (operation, responseObj) -> Void in
            
            completion(true,responseObj as AnyObject,nil)
            
        }, failure: { (operation, error) in
            
            completion(false,nil,error as NSError)
            
        })
        
    }
    
    
    
    func parseLinkUsingGetMethodAndHeader(_ servicename: String, parameter:NSDictionary?, token:
        String, completion:@escaping (Bool?,AnyObject?,NSError?) -> Void){
        
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: .mutableContainers)
        manager.requestSerializer.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
       // manager.requestSerializer.stringEncoding = String.Encoding.utf8.rawValue
//       manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json","text/plain","text/xml","text/json","text/html") as? Set<String>//, "application/x-www-form-urlencoded", "text/plain", "text/json", "text/javascript"
        //manager.responseSerializer.acceptableStatusCodes = [201,200,203]
        
        let strUrl : String = self.initWithManager()
        
        manager.get(strUrl+servicename, parameters: nil, progress: nil, success: { (operation, responseObj) -> Void in
            if let _response = operation.response as?  HTTPURLResponse, let status = _response.allHeaderFields[Constant.Names.ExpirationStatusKey] as? String{
                print(status)
                CCUtility.showExpirationAlert(statusValue: status)
            }
            completion(true,responseObj as AnyObject,nil)
            
        }, failure: { (operation, error) in
            
            completion(false,nil,error as NSError)
            
        })
        
    }
    
    
    
    func parseLinkUsingPutMethod(_ servicename:String,parameter:NSDictionary?, token: String, completion:@escaping (Bool?,AnyObject?,NSError?) -> Void){
        
        // let serializer = AFJSONRequestSerializer()
        
        // let serializerResponse = AFJSONRequestSerializer()
        
        //serializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // manager.requestSerializer = serializer
        
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "Authorization")
        
        
        
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: JSONSerialization.ReadingOptions.allowFragments)
        
        //manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "application/x-www-form-urlencoded") as? Set<String>
        
        let  strUrl : String = self.initWithManager()
        
        
        
        //        let postData = try! JSONSerialization.data(withJSONObject: parameter!, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        //        print(postData)
        
        manager.put(strUrl+servicename, parameters: parameter!, success: { (operation, responseObj) -> Void in
            
            completion(true, responseObj as? NSDictionary, nil)
            
        }) { (operation, error) in
            
            completion(false, nil, error as NSError)
            
        }
        
    }
    
    
    
    func parseLinkUsingPostMethod(_ servicename:String,parameter:NSDictionary?,completion:@escaping (Bool?,AnyObject?,NSError?) -> Void){
        
        let serializer = AFJSONRequestSerializer()
        
        // let serializerResponse = AFJSONRequestSerializer()
        
        //serializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        manager.requestSerializer = serializer
        
        
        
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: JSONSerialization.ReadingOptions.allowFragments)
        
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "application/x-www-form-urlencoded") as? Set<String>
        
        let  strUrl : String = self.initWithManager()
        
        
        
        //        let postData = try! JSONSerialization.data(withJSONObject: parameter!, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        //        print(postData)
        
        
        
        manager.post(strUrl+servicename, parameters: parameter!, progress: nil, success: { (operation, responseObj) -> Void in
            
            completion(true, responseObj as? NSDictionary, nil)
            
        }) { (operation, error) in
            
            completion(false, nil, error as NSError)
            
        }
        
    }
    
    
    
    
    
    func parseLinkUsingPostMethodforXML(_ servicename:String,parameter:NSDictionary?,completion:@escaping (Bool?,AnyObject?,NSError?) -> Void){
        
        manager.responseSerializer = AFXMLParserResponseSerializer()
        
        // manager.responseSerializer = AFXMLParserResponseSerializer(coder: NSJSONReadingOptions.AllowFragments)
        
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/xml", "text/xml") as? Set<String>
        
        manager.post(servicename, parameters: parameter, progress: nil, success: { (operation, responseObj) -> Void in
            
            completion(true, responseObj as AnyObject, nil)
            
        }) { (operation, error) in
            
            completion(false, nil, error as NSError)
            
        }
        
    }
    
    
    
    func parseLinkWithHeaderUsingPostMethod(_ servicename:String,parameter:NSDictionary?,token:String,completion:@escaping (Bool?,AnyObject?,NSError?) -> Void){
        
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: JSONSerialization.ReadingOptions.allowFragments)
        
        manager.requestSerializer.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/html", "application/x-www-form-urlencoded") as? Set<String>
        
        let  strUrl : String = self.initWithManager()
        
        manager.post(strUrl+servicename, parameters: parameter, progress: nil, success: { (operation, responseObj) -> Void in
            
            completion(true, responseObj as AnyObject, nil)
            
        }) { (operation, error) in
            
            completion(false, nil, error as NSError)
            
        }
        
    }
    
    
    
    func parseLinkWithImage(_ servicename:String,parameter:NSDictionary?,imgData : Data?,pathKey:String,completion:@escaping (Bool?,AnyObject?,NSError?) -> Void){
        
        manager.responseSerializer.acceptableContentTypes = NSSet(objects:"application/json","text/html") as? Set<String>
        
        let strUrl : String = self.initWithManager()
        
        manager.post(strUrl+servicename, parameters: parameter, constructingBodyWith: { (formData:AFMultipartFormData) -> Void in
            
            formData.appendPart(withFileData: imgData!, name: pathKey, fileName: "\(self.makeFileName()).jpg", mimeType: "image/jpeg")
            
        }, progress: nil, success: { (operation, responseObj) -> Void in
            
            completion(true, responseObj as AnyObject, nil)
            
        }) { (operation, error) in
            
            completion(false, nil, error as NSError)
            
        }
        
    }
    
    
    
    func parseLinkWithImageAndHeaderUsingPostMethod(_ servicename:String,parameter:NSDictionary?,imgData : Data?,pathKey:String,token:String,completion:@escaping (Bool?,AnyObject?,NSError?) -> Void){
        let _tok = "Bearer " + token
        manager.requestSerializer.setValue(_tok, forHTTPHeaderField: "Authorization")
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/html") as? Set<String>
        let  strUrl : String = self.initWithManager()
        manager.post(strUrl+servicename, parameters: parameter, constructingBodyWith: { (formData:AFMultipartFormData) -> Void in
            if let imData = imgData{
                formData.appendPart(withFileData: imData, name: pathKey, fileName: "\(self.makeFileName()).jpg", mimeType: "image/jpeg")
            }
            
        }, progress: nil, success: { (operation, responseObj) -> Void in
            
            completion(true, responseObj as AnyObject, nil)
            
        }) { (operation, error) in
            
            completion(false, nil, error as NSError)
            
        }
        
    }
    
    
    
    func parseLinkWithMultipleFiles(_ servicename:String,parameter:NSDictionary?,filesArray:NSArray?,completion:@escaping (Bool?,AnyObject?,NSError?)->Void ){
        
        manager.responseSerializer.acceptableContentTypes = NSSet(objects:"application/json", "text/html", "text/plain", "text/json", "text/javascript") as? Set<String>
        
        manager.requestSerializer.timeoutInterval = 60
        
        let arrayFilePath : NSArray = ["jobseekerImage" , "form1" , "form2" , "resume"]
        
        let strUrl : String = self.initWithManager()
        
        manager.post(strUrl+servicename, parameters: parameter, constructingBodyWith: { (formData:AFMultipartFormData) -> Void in
            
            filesArray?.enumerateObjects({ (filedata, idx, stop) -> Void in
                
                if idx == 0{
                    
                    formData.appendPart(withFileData: filedata as! Data, name: arrayFilePath.object(at: idx) as! String, fileName: "\(self.makeFileName()).jpg", mimeType: "image/jpeg")
                    
                }
                    
                else{
                    
                    formData.appendPart(withFileData: filedata as! Data, name: arrayFilePath.object(at: idx) as! String, fileName: "\(self.makeFileName()).pdf", mimeType: "application/pdf")
                    
                }
                
            })
            
        }, progress: nil, success: { (operation, responseObj) -> Void in
            
            completion(true,responseObj as AnyObject,nil)
            
        }) { (operation, error) in
            
            completion(false,nil,error as NSError)
            
        }
        
    }
    
    
    
    func parseLinkWithMultipleFilesAndHeaderUsingPostMethod(_ servicename:String,parameter:NSDictionary?,token:String,filesArray:NSArray?,completion:@escaping (Bool?,AnyObject?,NSError?)->Void){
        
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "token")
        
        manager.responseSerializer.acceptableContentTypes = NSSet(objects:"application/json", "text/html", "text/plain", "text/json", "text/javascript") as? Set<String>
        
        manager.requestSerializer.timeoutInterval = 60
        
        let arrayFilePath : NSArray = ["jobseekerImage" , "form1" , "form2" , "resume"]
        
        let strUrl : String = self.initWithManager()
        
        manager.post(strUrl+servicename, parameters: parameter, constructingBodyWith: { (formData:AFMultipartFormData) -> Void in
            
            filesArray?.enumerateObjects({ (filedata, idx, stop) -> Void in
                
                if idx == 0{
                    
                    formData.appendPart(withFileData: filedata as! Data, name: arrayFilePath.object(at: idx) as! String, fileName: "\(self.makeFileName()).jpg", mimeType: "image/jpeg")
                    
                }
                    
                else{
                    
                    formData.appendPart(withFileData: filedata as! Data, name: arrayFilePath.object(at: idx) as! String, fileName: "\(self.makeFileName()).pdf", mimeType: "application/pdf")
                    
                }
                
            })
            
        }, progress: nil, success: { (operation, responseObj) -> Void in
            
            completion(true,responseObj as AnyObject,nil)
            
        }) { (operation, error) in
            
            completion(false,nil,error as NSError)
            
        }
        
    }
    
    
    
    func makeFileName() ->String{
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyMMddHHmmssSSS"
        
        let filename = dateFormatter.string(from: Date()) as String
        
        return filename
        
    }
    
}
