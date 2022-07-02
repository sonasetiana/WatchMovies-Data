//
//  MovieRepository.swift
//  WatchMovies
//
//  Created by sona setiana on 29/06/22.
//

import Foundation
import Combine


public protocol MovieRepository {
    func getListMovie(completion: @escaping (Result<[MovieEntity], Error>) -> Void)
    func getDetailMovie(movieId: Int, completion: @escaping (Result<MovieDetailEntity, Error>) -> Void)
    func searchMovie(keyword: String, completion: @escaping (Result<[MovieEntity], Error>) -> Void)
    func saveFavorite(movie: MovieDetailEntity, completion: @escaping (Result<String, Error>) -> Void)
    func deleteFavorite(movieId: Int, completion: @escaping (Result<String, Error>) -> Void)
    func getListFavorite(completion: @escaping (Result<[MovieTable], Error>) -> Void)
    func findFavorite(id: Int, completion: @escaping (Result<Bool, Error>) -> Void)
}

public class MovieRepositoryImpl : MovieRepository{
    private let localDataSource : LocalMovieDataSource
    private let remoteDataSource : RemoteMovieDataSource
    private var cancellableSet: Set<AnyCancellable> = []
    
    public init(localDataSource: LocalMovieDataSource, remoteDataSource: RemoteMovieDataSource) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
    
    public func getListMovie(completion: @escaping (Result<[MovieEntity], Error>) -> Void) {
        remoteDataSource
            .getListMovie()
            .sink(receiveValue: { (response) in
                switch response.result {
                case .success(let items):
                    completion(.success(items.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }).store(in: &cancellableSet)
    }
    
    public func getDetailMovie(movieId: Int, completion: @escaping (Result<MovieDetailEntity, Error>) -> Void) {
        remoteDataSource
            .getDetailMovie(movieId: movieId)
            .sink(receiveValue: { (response) in
                switch response.result {
                case .success(let items):
                    completion(.success(items))
                case .failure(let error):
                    completion(.failure(error))
                }
            }).store(in: &cancellableSet)
    }
    
    public func searchMovie(keyword: String, completion: @escaping (Result<[MovieEntity], Error>) -> Void) {
        remoteDataSource
            .searchMovie(keyword: keyword)
            .sink(receiveValue: { (response) in
                switch response.result {
                case .success(let items):
                    completion(.success(items.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }).store(in: &cancellableSet)
    }
    
    public func saveFavorite(movie: MovieDetailEntity, completion: @escaping (Result<String, Error>) -> Void) {
        localDataSource.saveFavorite(movie: movie) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    public func deleteFavorite(movieId: Int, completion: @escaping (Result<String, Error>) -> Void) {
        localDataSource.deleteFavorite(movieId: movieId) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    public func getListFavorite(completion: @escaping (Result<[MovieTable], Error>) -> Void) {
        localDataSource.getListFavorite(completion: completion)
    }
    
    public func findFavorite(id: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        localDataSource.findFavorite(id: id, completion: completion)
    }
}
