import ProjectDescription

let infoPlist: [String: Plist.Value] = [
    "UIApplicationSceneManifest": [
        "UIApplicationSupportMultipleScenes": false,
        "UISceneConfigurations": [
            "UIWindowSceneSessionRoleApplication": [
                [
                    "UISceneConfigurationName": "Default Configuration",
                    "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                ]
            ]
        ]
    ],
    "UILaunchStoryboardName": "LaunchScreen",
    "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"]
]

var swiftLintTargetScript: TargetScript {
    let script = """
        export PATH="$PATH:/opt/homebrew/bin"
        if which swiftlint > /dev/null; then
            swiftlint
        else
            echo: "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
        fi
    """
    
    return .pre(
        script: script,
        name: "Run SwiftLint",
        basedOnDependencyAnalysis: false
    )
}

let project = Project(
    name: "MdEditor",
    packages: [.local(path: .relativeToManifest("Packages/TaskManagerPackage"))],
    targets: [
        Target(
            name: "MdEditor",
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.Nikolaev.MdEditor",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            scripts: [swiftLintTargetScript],
            dependencies: [.package(product: "TaskManagerPackage")]
        )
    ]
)
