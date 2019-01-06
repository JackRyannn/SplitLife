import Foundation
import Alamofire
enum MethodType {
    case get
    case post
    case put
    case delete
}

class HttpUtil: SessionManager {
    
    static var instance : HttpUtil? = nil
    
    class func shareManager() -> HttpUtil{
        
        var header : HTTPHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        header["Authorization"] = ""
        header.updateValue("application/json", forKey: "Accept")
        //        header.updateValue("application/json", forKey: "Content-Type")
        let configration = URLSessionConfiguration.default
        configration.httpAdditionalHeaders = header
        
        instance = HttpUtil(configuration: configration)
        
        return instance!
    }
    
    func requestData(_ type : MethodType, urlString : String, parameters : [String : AnyObject]?, success : @escaping (_ responseObject : [String : AnyObject]) -> (), failure : @escaping (_ error : NSError) -> ()) -> (){
        let method : HTTPMethod
        
        switch type {
        case .get:
            method = .get
            break
        case .post:
            method = .post
            break
        case .put:
            method = .put
            break
        default:
            method = .get
        }
        print("=====Post=====")
        let header = ["Content-Type":"application/json"]
        
        self.request(urlString, method: method, parameters: parameters,encoding:JSONEncoding.default,headers:header).responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value as? [String : AnyObject]{
                    success(value)
                }
            case .failure(let error):
                failure(error as NSError)
            }
        }
    }
    func upload(){
        
        let manager = FileManager.default
        let urlForDocument = manager.urls( for: .documentDirectory, in:.userDomainMask)
        let url = urlForDocument[0]
        let fileURL = url.appendingPathComponent("splitDB.sqlite")
        print(fileURL.absoluteString)
       
        let parameters = ["user_id":"1"]
        let remoteURL = "http://101.200.61.218:1352/uploadFile" /* your API url */
//        let remoteURL = "http://localhost:1352/uploadFile" /* your API url */

        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            multipartFormData.append(fileURL, withName: "file", fileName: "file", mimeType: "application/octet-stream")
            
        }, usingThreshold: UInt64.init(), to: remoteURL, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    if let err = response.error{
//                        这里会报错，但还没搞懂
                        print("Alamofire ERROR : "+err.localizedDescription)
                        return
                    }
//                  回调方法写在这onCompletion?(nil)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
            }
        }
    }

    func download(webURL:String,filename:String){
        let urlString = URLRequest(url: URL(string:webURL)!)
        
        
        let manager = FileManager.default
        let urlForDocument = manager.urls( for: .documentDirectory, in:.userDomainMask)
        let url = urlForDocument[0]
        let fileURL = url.appendingPathComponent(filename)
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (fileURL, [.createIntermediateDirectories, .removePreviousFile])
        }
       
        Alamofire.download(urlString, to: destination).response { response in // method defaults to `.get`
            print(response.request)
            print(response.response)
            print(response.temporaryURL)
            print(response.destinationURL)
            print(response.error)
        }
     
    }
    
}
