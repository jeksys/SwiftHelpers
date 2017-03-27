import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import CocoaLumberjack

enum RouterTemplate: URLRequestConvertible {
    
    static let baseURLString = Configuration.environment.baseURL
    case Get(Int, Bool, Bool)
    case Put(Int, Bool, Bool)
    
    func asURLRequest() throws -> URLRequest{
        
        var method: HTTPMethod {
            switch self {
            case .Get:
                return .get
            case .Put:
                return .put
            }
        }
        
        let params: ([String: Any]?) = {
            switch self {
            case .Get:
                return ([:])
            case .Put:
                return ([:])
            }
        }()
        
        let url:URL = {
            // build up and return the URL for each endpoint
            let relativePath:String?
            switch self {
            case .Get:
                relativePath = ""
            case .Put:
                relativePath = ""
            }
            
            var url = URL(string: ProjectRouter.baseURLString)!
            if let relativePath = relativePath {
                url.appendPathComponent(relativePath)
            }
            return url
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let encoding = URLEncoding.default//JSONEncoding.default
        return try encoding.encode(urlRequest, with: params)
    }
    
}
