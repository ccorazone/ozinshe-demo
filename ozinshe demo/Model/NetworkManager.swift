//
//  NetworkManager.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 03.03.2026.
//

import UIKit
import Alamofire
enum PostType: String{
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}

class NetworkManager{
    
    static let shared = NetworkManager()
    
    var token: String?{
        get{
            return UserDefaults.standard.string(forKey: "userToken")
        }
        set{
            return UserDefaults.standard.set(newValue, forKey: "userToken")
        }
    }

    
    func signUpRequest(userData: SignUpRequest, completion: @escaping (AuthResponse?, String?) -> Void){
        guard let url = URL(string: API.baseURL + API.Auth.register) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = PostType.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(userData)
        URLSession.shared.dataTask(with: request){data, response, error in
            if let error = error{
                print("some error: \(error.localizedDescription)")
                
                return
            }
            guard let data = data else {return}
            
            do{
                let authresult = try JSONDecoder().decode(AuthResponse.self, from: data)
                print("siuuuuu! Токен получен")
//                self.token = authresult.accessToken
                completion(authresult, nil)
            }
            catch{
                print("error - \(error)")
                completion(nil, "some error")
            }
            
                
        }.resume()
    }
    
    
    func loginRequest(userData: LoginRequest, completion: @escaping (Bool)->()){
        guard let url = URL(string: API.baseURL + API.Auth.login) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = PostType.post.rawValue
        request.setValue( "application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(userData)
        
        URLSession.shared.dataTask(with: request){data, response, error in
            if let error = error{
                print("some error - \(error.localizedDescription)")
                completion(false)

                return
            }
            guard let data = data else {return}
            guard let response = response as? HTTPURLResponse else{return }
            do{
                if 200..<300 ~= response.statusCode{
                    let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                    print("siuuuuu! Token: \(result.accessToken)")
                    self.token = result.accessToken
                    completion(true)

                }else{
                    completion(false)
                }
                
            }
            catch{
                print(error)
                completion(false)
            }
        }.resume()
    }
    
    func loadFavorite(completion: @escaping ([Movie]?, String?) -> ()){
        let url = API.baseURL + API.Core.favorite
        
        
        let headers = getHeader()

        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: [Movie].self) { (response) in
                if let error = response.error {
                    print(error)
                    completion(nil, error.localizedDescription)
                }
                
                if let movies = response.value {
                    completion(movies, nil)
                    print("WE GOT IT(FAVORITE)")
                }
            }
    }
    
    func getUserProfile(completion: @escaping (UserProfile?,String?) -> ()){
        let url = API.baseURL + API.Core.userProfile
        
        
        let headers = getHeader()
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: UserProfile.self) { (response) in
                if let error = response.error {
                    print(error)
                    completion(nil, error.localizedDescription)
                }
                
                if let userProfile = response.value {
                    print(userProfile)
                    completion(userProfile, nil)
                    print("WE GOT IT(USER PROFILE)")
                }
            }
    }
    
    func updateUserProfile(profile: UserProfileRequest, completion: @escaping (UserProfile?)-> ()){
        let url = API.baseURL + API.Core.updateUserProfile
        
        let headers = getHeader()
        AF.request(url, method: .put,parameters: profile,encoder: JSONParameterEncoder.default, headers: headers)
            .validate()
            .responseDecodable(of: UserProfile.self){response in
                if let error = response.error{
                    print(error)
                }
                if let userProfile = response.value{
                    print(userProfile)
                    completion(userProfile)
                }
            }

        
    }
    
    
    func changePassword(password: ChangePaswwordRequest,completion:  @escaping (PasswordPesponse?, String?) -> ()){
        let url = API.baseURL + API.Core.changePassword
        let headers = getHeader()
        AF.request(url, method: .put, parameters: password, encoder: JSONParameterEncoder.default, headers: headers)
            .validate()
            .responseDecodable(of: PasswordPesponse.self){response in
                if let error = response.error{
                    print(error)
                    completion(nil, "Error")
                }
                if let userProfile = response.value{
                    completion(userProfile, nil)
                    print("password is updated")
                }
            }
    }
    
    func fetchCategories(completion: @escaping ([CategoryResponse]?) -> ()){
        let url = API.baseURL + API.Core.getAllCategories
        let headers = getHeader()
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: [CategoryResponse].self){response in
                if let error = response.error{
                    print(error)
                    completion(nil)
                }
                if let categories = response.value{
                    completion(categories)
                    print("categories fetched")
                }
            }
    }
    func fetchMoviesByCategory(categoryId: Int, completion: @escaping ([Movie]?,String?) -> ()){
        let url = API.baseURL + API.Core.getMoviesByCategory
        let headers = getHeader()
        
        
        let parametrs: [String: Any] = ["categoryId": categoryId]
        AF.request(url, method: .get, parameters: parametrs,encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: MovieResponse.self){respose in
            
                switch respose.result{
                case .success(let movies):
                    completion(movies.content, nil)
                case .failure(let error):
                    print(error)
                    completion(nil,"Failed to fetch movies")
                }
        }
    }
    
    func fetchMoviesByQuery(query: String, completion: @escaping ([Movie]?,String? ) -> ()){
        let url = API.baseURL + API.Core.getMoviesByQuery
        let header = getHeader()
        let parametrs: [String: Any] = ["search": query]
        
        AF.request(url, method: .get, parameters: parametrs, encoding: URLEncoding.default, headers: header )
            .validate()
            .responseDecodable(of: [Movie].self){response in
                switch response.result{
                case .success(let movies):
                    completion(movies, nil)
                    
                case .failure(let error):
                    completion(nil, error.localizedDescription)
                }
            }
    }
    
    
    func fetchAllBanners() async throws -> [BannerMovie]{
        try await request(path: API.Core.getBannerMovies)
    }
    
    func fetchWatchHistory() async throws -> [Movie]{
        try await request(path: API.Core.getWatchHistory)
    }
    
    func fetchAllMoviesWithCategory() async throws -> [AllMoviesByCategory]{
        try await request(path: API.Core.getAllMoviesForMainPage)
    }
    func fetchAllGenres() async throws -> [Genre]{
        try await request(path: API.Core.getGenres)
    }
    func fetchAgeCategories() async throws -> [AgeCategories]{
        try await request(path: API.Core.getAgeCategories)
    }
    
    
    
    
    
    
    
    private func request<T: Decodable>(path: String, method: HTTPMethod = .get) async throws -> T{
        let url = API.baseURL + path
        let headers = getHeader()
        let responseMovie = try await AF.request(url, method: method, headers: headers)
            .validate()
            .serializingDecodable(T.self)
            .value
        return responseMovie
        
    }
    
    
    
    private func getHeader() -> HTTPHeaders{
        guard let token = self.token else{
            return []
        }
        return ["Authorization": "Bearer \(token)"]
    }
}
