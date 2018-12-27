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
}
