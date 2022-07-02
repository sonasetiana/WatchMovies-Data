//
//  LocalMovieDataSource.swift
//  Data
//
//  Created by sona setiana on 02/07/22.
//

import Foundation
import Combine
import CoreData


public protocol LocalMovieDataSource {
    func saveFavorite(movie: MovieDetailEntity, completion: @escaping (Result<String, Error>) -> Void)
    func deleteFavorite(movieId: Int, completion: @escaping (Result<String, Error>) -> Void)
    func getListFavorite(completion: @escaping (Result<[MovieTable], Error>) -> Void)
    func findFavorite(id: Int, completion: @escaping (Result<Bool, Error>) -> Void)
}

public class LocalMovieDataSourceImpl : LocalMovieDataSource{
    
    public let presistence : CoreDataManager
    
    public init(presistence: CoreDataManager) {
        self.presistence = presistence
    }
    
    private func provideMovieTable(movie: MovieDetailEntity, context: NSManagedObjectContext){
        let table = MovieTable(context: context)
        table.id = Int64(movie.id ?? 0)
        table.title = movie.title ?? ""
        table.genres = convertGenresToString(items: movie.genres)
        table.image = movie.backdrop_path
        table.releaseAt = movie.release_date ?? ""
    }
    
    public func saveFavorite(movie: MovieDetailEntity, completion: @escaping (Result<String, Error>) -> Void) {
        presistence.getPresistenContainer().performBackgroundTask { context in
            self.provideMovieTable(movie: movie, context: context)
            do {
                try context.save()
                completion(.success("Success save favorite"))
            }catch {
                completion(.failure(error))
            }
        }
    }
    
    public func deleteFavorite(movieId: Int, completion: @escaping (Result<String, Error>) -> Void) {
        presistence.getPresistenContainer().performBackgroundTask{ context in
            do {
                let favorites : NSFetchRequest<MovieTable> = MovieTable.fetchRequest()
                let results = try context.fetch(favorites)
                results.filter{
                    $0.id == movieId
                }.forEach { item in
                    context.delete(item)
                }
                try context.save()
                completion(.success("Success delete favorite"))
            }catch {
                completion(.failure(error))
                context.rollback()
            }
        }
    }
    
    public func getListFavorite(completion: @escaping (Result<[MovieTable], Error>) -> Void) {
        let context = presistence.getViewContext()
        context.perform {
            do {
                let request : NSFetchRequest<MovieTable> = MovieTable.fetchRequest()
                let favorites = try context.fetch(request)
                completion(.success(favorites))
            }catch {
                completion(.failure(error))
            }
        }
    }
    
    public func findFavorite(id: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let context = presistence.getViewContext()
        context.perform {
            do {
                let request : NSFetchRequest<MovieTable> = MovieTable.fetchRequest()
                let favorites = try context.fetch(request).filter{$0.id == id}
                completion(.success(!favorites.isEmpty))
            }catch {
                completion(.failure(error))
            }
        }
    }
}
