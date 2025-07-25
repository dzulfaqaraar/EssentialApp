# EssentialApp

## Project Overview

This is an iOS application project implementing the Essential Developer's iOS Lead Essentials course work. The project follows Clean Architecture principles with modular design and comprehensive testing.

### Architecture

The project is structured as a multi-module iOS application with the following main components:

- **EssentialApp**: Main iOS application target that composes the entire app
- **EssentialFeed**: Core business logic framework containing feed functionality, image loading, and caching
- **EssentialFeediOS**: iOS-specific UI components and view controllers
- **Prototype**: Simple prototype implementation for reference

#### Key Architectural Patterns

- **Clean Architecture**: Clear separation between business logic, presentation, and infrastructure layers
- **Composition Root**: Dependencies are composed in `SceneDelegate.swift` using the Composer pattern
- **MVP (Model-View-Presenter)**: UI follows MVP pattern with presenters handling business logic
- **Repository Pattern**: Local and remote data sources with fallback mechanisms
- **Publisher/Subscriber**: Combines framework used for reactive programming and data flow

#### Core Modules Structure

**EssentialFeed Framework:**
- `Feed Feature/`: Core domain models (`FeedImage`, `ImageComment`)
- `Feed API/`: Remote data loading and mapping (`FeedEndpoint`, `FeedItemsMapper`)
- `Feed Cache/`: Local persistence with CoreData (`CoreDataFeedStore`, `LocalFeedLoader`)
- `Feed Presentation/`: Presentation logic and view models (`FeedPresenter`, `FeedImagePresenter`)
- `Shared API/`: Common networking infrastructure (`HTTPClient`, `URLSessionHTTPClient`)
- `Shared Presentation/`: Reusable presentation components (`LoadResourcePresenter`)

**EssentialFeediOS Framework:**
- `Shared UI/`: Reusable UI components (`ListViewController`, `ErrorView`)
- `Feed UI/`: Feed-specific UI components (`FeedImageCell`, `FeedImageCellController`)
- `Image Comments UI/`: Comments UI components

#### Data Flow

1. `SceneDelegate` acts as the composition root, setting up all dependencies
2. Remote data is fetched via `HTTPClient` and cached locally using `CoreDataFeedStore`
3. Local fallback mechanism ensures offline functionality
4. UI composers (`FeedUIComposer`, `CommentsUIComposer`) wire up view controllers with business logic
5. Presenters handle view state and formatting logic

## Development Commands

### Building and Testing

**Build the project:**
```bash
xcodebuild clean build -workspace EssentialApp/EssentialApp.xcworkspace -scheme "EssentialApp" -sdk iphonesimulator -destination "platform=iOS Simulator,name=iPhone 16 Pro,OS=18.5"
```

**Run all tests:**
```bash
xcodebuild clean build test -workspace EssentialApp/EssentialApp.xcworkspace -scheme "CI_iOS" -sdk iphonesimulator -destination "platform=iOS Simulator,name=iPhone 16 Pro,OS=18.5" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO ONLY_ACTIVE_ARCH=YES
```

**Run specific test target:**
```bash
xcodebuild test -workspace EssentialApp/EssentialApp.xcworkspace -scheme "EssentialFeed" -destination "platform=iOS Simulator,name=iPhone 16 Pro,OS=18.5"
```

### Target Information

- **Target Device**: iPhone 16 Pro (as specified in README.md)
- **Main Workspace**: `EssentialApp/EssentialApp.xcworkspace`
- **CI Scheme**: `CI_iOS` (runs all tests across modules)

## Testing Strategy

The project follows comprehensive testing practices:

- **Unit Tests**: Business logic and presentation layer testing
- **Integration Tests**: Testing interaction between components (`FeedUIIntegrationTests`, `CommentsUIIntegrationTests`)
- **Acceptance Tests**: End-to-end testing (`FeedAcceptanceTests`)
- **Snapshot Tests**: UI testing with visual regression (`FeedSnapshotTests`, `ImageCommentsSnapshotTests`)
- **End-to-End Tests**: API integration testing (`EssentialFeedAPIEndToEndTests`)

### Test Helpers

Extensive test helpers are provided in test targets:
- Memory leak tracking (`XCTestCase+MemoryLeakTracking`)
- UI testing utilities (`UIButton+TestHelpers`, `ListViewController+TestHelpers`)
- Stub implementations (`HTTPClientStub`, `InMemoryFeedStore`)

## Key Files and Dependencies

### Main Entry Points
- `EssentialApp/SceneDelegate.swift`: Main composition root and dependency injection
- `EssentialApp/FeedUIComposer.swift`: Composes feed UI with business logic
- `EssentialApp/CommentsUIComposer.swift`: Composes comments UI

### Core Infrastructure
- `EssentialFeed/Shared API/HTTPClient.swift`: Network layer abstraction
- `EssentialFeed/Feed Cache/CoreDataFeedStore.swift`: Persistent storage implementation
- `EssentialFeediOS/Shared UI/Controllers/ListViewController.swift`: Generic list UI component

### Business Logic
- `EssentialFeed/Feed Feature/FeedImage.swift`: Core domain model
- `EssentialFeed/Feed Cache/LocalFeedLoader.swift`: Local data access
- `EssentialFeed/Feed Presentation/FeedPresenter.swift`: Presentation logic

## Development Notes

- The project uses dependency injection extensively - avoid adding singletons or global state
- All network operations use the `HTTPClient` protocol for testability
- UI components are generic and reusable (`ListViewController` can display any content)
- Memory leak detection is built into tests - ensure proper cleanup of combine subscriptions and delegates
- The app supports offline functionality through local caching with remote fallback
- Localization is implemented for multiple languages (English, Portuguese, Greek)