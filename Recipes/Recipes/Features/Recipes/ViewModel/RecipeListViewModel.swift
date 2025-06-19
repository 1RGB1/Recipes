//
//  RecipeListViewModel.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import SwiftUI
import Combine

@MainActor
class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var filteredRecipes: [Recipe] = []
    @Published var isLoading = false
    @Published var error: String?
    @Published var searchText = ""
    @Published var selectedSort: SortOption = .name
    @Published var isSearching = false
    
    private var currentPage = 0
    private let pageSize = 20
    private var canLoadMore = true
    private var cancellables = Set<AnyCancellable>()
    
    private let fetchRecipesUseCase: FetchRecipesUseCaseProtocol
    
    init(fetchRecipesUseCase: FetchRecipesUseCaseProtocol) {
        self.fetchRecipesUseCase = fetchRecipesUseCase
        setupCombineBindings()
        loadInitialData()
    }
    
    private func setupCombineBindings() {
        // Search with debouncing
        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                Task {
                    await self?.performSearch(searchText)
                }
            }
            .store(in: &cancellables)
        
        // Sort recipes when sort option changes
        Publishers.CombineLatest($recipes, $selectedSort)
            .map { recipes, sortOption in
                sortOption.sort(recipes)
            }
            .assign(to: &$filteredRecipes)
    }
    
    func loadInitialData() {
        Task {
            await loadRecipes(reset: true)
        }
    }
    
    func loadMoreRecipes() {
        guard !isLoading && canLoadMore && !isSearching else { return }
        
        Task {
            await loadRecipes(reset: false)
        }
    }
    
    func refresh() async {
        currentPage = 0
        canLoadMore = true
        await loadRecipes(reset: true)
    }
    
    private func loadRecipes(reset: Bool) async {
        if reset {
            currentPage = 0
            isLoading = true
            error = nil
        }
        
        do {
            let response = try await fetchRecipesUseCase.execute(
                limit: pageSize,
                skip: currentPage * pageSize
            )
            
            if reset {
                recipes = response.recipes
            } else {
                recipes.append(contentsOf: response.recipes)
            }
            
            currentPage += 1
            canLoadMore = response.recipes.count == pageSize
            
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
    
    private func performSearch(_ query: String) async {
        guard !query.isEmpty else {
            isSearching = false
            return
        }
        
        isSearching = true
        isLoading = true
        error = nil
        
        do {
            let response = try await fetchRecipesUseCase.search(query: query)
            recipes = response.recipes
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
}
