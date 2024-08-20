//
//  SupabaseAuthManager.swift
//  autofill-extension
//
//  Created by Baptiste Veyrard on 20/08/2024.
//

import Foundation
import Supabase

class SupabaseAuthManager {
    static let shared = SupabaseAuthManager()
    private(set) var supabase: SupabaseClient
    
    private init() {
        supabase = SupabaseClient(
            supabaseURL: URL(string: "YOUR-SUPABASE-URL")!,
            supabaseKey: "YOUR-SUPABASE-KEY",
            options: SupabaseClientOptions(
                auth: .init(
                    storage: KeychainLocalStorage(service: "flutter_secure_storage_service", accessGroup: nil),
                    storageKey: "SUPABASE_PERSIST_SESSION_KEY"
                )
            )
        )
        // Attempt to load the session manually
        Task {
            do {
                let session = try await supabase.auth.session
                print("Successfully loaded session: \(session)")
            } catch {
                print("Failed to load session: \(error)")
            }
        }
    }
}
