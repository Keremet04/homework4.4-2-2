//
//  NetworkLayer.swift
//  homework4.4
//
//  Created by Zhansuluu Kydyrova on 4/1/23.
//

import UIKit
import RxSwift
//В верстку подвязать RxSwift
//Все запросы кроме GET поменять на async await
//GET запрос написать на RX


final class NetworkLayer {
    
    static let shared = NetworkLayer()
    private init() { }
    
    var baseURL = URL(string: "https://dummyjson.com/products")
    let session = URLSession(configuration: .default)
  //  var dataTask = URLSessionDataTask? = nil
    
    func decodeOrderTypeData(_ json: String) -> [OrderTypeModel] {
        var orderTypeModelArray = [OrderTypeModel]()
        let orderTypeData = Data(json.utf8)
        let jsonDecoder = JSONDecoder()
        do { let orderTypeModelData = try jsonDecoder.decode([OrderTypeModel].self, from: orderTypeData)
            orderTypeModelArray = orderTypeModelData
        } catch {
            print(error.localizedDescription)
        }
        return orderTypeModelArray
    }
    
    
    //
    //    func fetchProductsData(completion: @escaping (Result<MainProductModel, Error>) -> Void) {
    //        guard let url = baseURL else { return }
    //
    //        let request = URLRequest(url: url)
    //
    //        let task = URLSession.shared.dataTask(with: request) { data, response, error in
    //            guard let data = data else { return }
    //            self.decodeData(data: data, completion: completion)
    //            }
    //        task.resume()
    //    }
    //
//    func fetchProductsData() async throws -> MainProductModel {
//        let (data, _) = try await URLSession.shared.data(from: baseURL!)
//        return await decodeData(data: data)
//    }
//    func decodeData<T: Decodable>(data: Data) async -> T {
//        let decoder = JSONDecoder()
//        return try! decoder.decode(T.self, from: data)
//    }
    
//    func fetchRx() -> Observable<[ProductModel]> {
//        return Observable<[ProductModel]>.create { observer in
//            self.baseURL! = self.session.dataTask(with: self.baseURL, completionHandler: {
//                (data, response, error) in
//                do {
//                    let model = try JSONDecoder().decode(MainProductModel, from: data ?? Data())
//                    observer.onNext(model.products)
//                }catch let error {
//                    observer.onError(error)
//                }
//                observer.onCompleted()
//            })
//            self.dataTask?.resume()
//            return Disposables.create {
//            }
//        }
//    }
//
    
    
    func fetchRx(text: String) -> Observable<[ProductModel]> {
        return Observable<[ProductModel]>.create { observer in
          //  let urlQueryItem = URLQueryItem(name: "q", value: text)
           // let request = URLRequest( url: self.baseURL!.appendingPathComponent("").appending(queryItems: [urlQueryItem]))
            Task {
               // let (data, response) = try await URLSession.shared.data(for: request)
               // print("response\(response)")
                do {
                    let (data, _) = try await URLSession.shared.data(from: self.baseURL!)
                    let model = try
                   
                    JSONDecoder().decode(MainProductModel.self, from: data)
                    observer.onNext(model.products)
                }catch {
                    observer.onError(Error.self as! Error)
                }
                observer.onCompleted()
            }
            return Disposables.create {
                
            }
        }
    }
    
    
    
    
    
    
//    func findProductsData(
//        text: String,
//        completion: @escaping (Result<MainProductModel, Error>) -> Void
//    ) {
//        guard let url = baseURL else { return }
//        let urlQueryItem = URLQueryItem(name: "q", value: text)
//
//        let request = URLRequest(url: url.appendingPathComponent("search").appending(queryItems: [urlQueryItem]))
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data else { return }
//            self.decodeData(data: data, completion: completion)
//        }
//
//        task.resume()
//    }
    
    func findRx(text: String) -> Observable<[ProductModel]> {
        return Observable<[ProductModel]>.create { observer in
            let urlQueryItem = URLQueryItem(name: "q", value: text)
            let request = URLRequest( url: self.baseURL!.appendingPathComponent("search").appending(queryItems: [urlQueryItem]))
            Task {
                let (data, response) = try await URLSession.shared.data(for: request)
                print("response\(response)")
                do {
                    let model = try
                    JSONDecoder().decode(MainProductModel.self, from: data)
                    observer.onNext(model.products)
                }catch {
                    observer.onError(Error.self as! Error)
                }
                observer.onCompleted()
            }
            return Disposables.create {
                
            }
        }
    }
    
   func encodeFunction<T: Encodable>(data: T) async throws -> Data {
        let encoder = JSONEncoder()
        return try! encoder.encode(data)
    }
    
    func postProductsData() async throws -> Data {
        var encodeDataModel: Data?
        encodeDataModel = try await encodeFunction(data: encodeDataModel)
        var request = URLRequest(url: (baseURL?.appendingPathComponent("add"))!)
        request.httpMethod = "Post"
        request.httpBody = encodeDataModel
        var dataToPost = Data()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("response: \(String(describing: response))")
            guard let data = data else { return }
            dataToPost = data
        }
        task.resume()
        return dataToPost
    }
    
    func putAsync() async throws -> Data {
        var encodeDataModel: Data?
        encodeDataModel = try await encodeFunction(data: encodeDataModel)
        var request = URLRequest(url:
                                    (baseURL?.appendingPathComponent("add"))!)
        request.httpMethod = "Put"
        request.httpBody = encodeDataModel
        var dataToPut = Data()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("response: \(String(describing: response))")
            guard let data = data else { return }
            dataToPut = data
        }
        task.resume()
        return dataToPut
    }
    
    //    func putProductsData(
    //        id:Int,
    //        model: ProductModel,
    //        completion: @escaping (Result<Data, Error>) -> Void
    //    ) {
    //        guard let url = baseURL else { return }
    //
    //        var encodedProductModel: Data?
    //        encodedProductModel = initializeData(product: encodedProductModel)
    //        guard encodedProductModel != nil else { return }
    //
    //        var request = URLRequest(url: url.appendingPathComponent("\(id)"))
    //        request.httpMethod = "PUT"
    //        request.httpBody = encodedProductModel
    //
    //        let task = URLSession.shared.dataTask(with: request) { data, response, error in
    //            if let error = error {
    //                completion(.failure(error))
    //            }
    //            print("RESPONSE:\(String(describing: response))")
    //            guard let data = data else { return }
    //            completion(.success(data))
    //        }
    //        task.resume()
    //    }
    
    //    func deleteProductsData(id: Int, completion: @escaping (Result<Data, Error>) -> Void) {
    //        guard let url = baseURL else { return }
    //
    //        var request = URLRequest(url: url.appendingPathComponent("\(id)"))
    //        request.httpMethod = "DELETE"
    //
    //        let task = URLSession.shared.dataTask(with: request) { data, response, error in
    //            if let error = error {
    //                completion(.failure(error))
    //            }
    //            print("RESPONSE:\(String(describing: response))")
    //        }
    //        task.resume()
    //    }
    
    func deleteAsync(id: Int) async throws -> Data {
        var request = URLRequest(url: (baseURL?.appendingPathComponent("add"))!)
        request.httpMethod = "Delete"
        var dataToDelete = Data()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("response: \(String(describing: response))")
            guard let data = data else { return }
            dataToDelete = data
        }
        task.resume()
        return dataToDelete
        
        func decodeData<T: Decodable>(data: Data, completion: @escaping (Result<T, Error>) -> Void) {
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        
        func encodeData<T: Encodable>(product: T, completion: @escaping (Result<Data, Error>) -> Void) {
            let encoder = JSONEncoder()
            do {
                let encodedData = try encoder.encode(product)
                completion(.success(encodedData))
            } catch {
                completion(.failure(error))
            }
        }
        
        func initializeData<T: Encodable>(product: T) -> Data? {
            var encodedData: Data?
            encodeData(product: product) { result in
                switch result {
                case .success(let model):
                    encodedData = model
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            return encodedData
        }
        
        
    }
    
}
