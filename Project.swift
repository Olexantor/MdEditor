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

let target = Target(
    name: "MdEditor",
    destinations: [.iPhone],
    product: .app,
    bundleId: "com.Nikolaev.MdEditor",
    deploymentTargets: .iOS("15.0"),
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["MdEditor/Sources/**", "MdEditor/Shared/**"],
    resources: ["MdEditor/Resources/**"],
    scripts: [swiftLintTargetScript],
    dependencies: [.package(product: "TaskManagerPackage")]
)

let uiTestTarget = Target(
    name: "MdEditorUITests",
    destinations: [.iPhone],
    product: .uiTests,
    bundleId: "com.Nikolaev.MdEditor.MdEditorUITests",
    deploymentTargets: .iOS("15.0"),
    sources: ["MdEditor/MdEditorUITests/Sources/**", "MdEditor/Shared/**"],
    dependencies: [.target(name: "MdEditor")]
)

let project = Project(
    name: "MdEditor",
    organizationName: "MyTeam",
    options: .options(
        defaultKnownRegions: ["Base", "ru"],
        developmentRegion: "Base"
    ),
    packages: [.local(path: .relativeToManifest("Packages/TaskManagerPackage"))],
    targets: [target, uiTestTarget],
    schemes: [
        Scheme(
            name: "MdEditor",
            shared: true,
            buildAction: .buildAction(targets: ["MdEditor"]),
            testAction: .targets(["MdEditor"]),
            runAction: .runAction(executable: "MdEditor")
        ),
        Scheme(
            name: "MdEditorUITests",
            shared: true,
            buildAction: .buildAction(targets: ["MdEditorUITests"]),
            testAction: .targets(["MdEditorUITests"]),
            runAction: .runAction(executable: "MdEditorUITests")
        )
    ]
)
