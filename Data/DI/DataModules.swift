//
//  DataModules.swift
//  WatchMovies
//
//  Created by sona setiana on 30/06/22.
//

import Foundation

public class DataModules {
    public init(){}
    public static let shared = DataModules()
    
    public func provideLocalMovieDataSource() -> LocalMovieDataSource {
        let manager = CoreDataManager()
        return LocalMovieDataSourceImpl(presistence: manager)
    }
    
    public func provideRemoteMovieDataSource() -> RemoteMovieDataSource {
        return RemoteMovieDataSourceImpl()
    }
    
    public func provideMovieRepository() -> MovieRepository {
        return MovieRepositoryImpl(
            localDataSource: provideLocalMovieDataSource(),
            remoteDataSource: provideRemoteMovieDataSource()
        )
    }
}
