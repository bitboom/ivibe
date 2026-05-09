import SwiftUI
import AVFoundation

struct RootView: View {
    private let screenshotMode = ScreenshotMode.current
    @State private var selectedTab: AppTab
    @State private var isFilterPresented = false

    init() {
        _selectedTab = State(initialValue: ScreenshotMode.current.initialTab)
    }

    var body: some View {
        Group {
            switch screenshotMode {
            case .structureDetail:
                NavigationStack { LessonDetailScreen() }
            case .navigationTitleLarge:
                NavigationStack { NavigationTitleLargeScreen() }
            case .navigationInlineBack:
                NavigationBackDemoContainer()
            case .navigationToolbar:
                NavigationStack { NavigationToolbarScreen() }
            case .formOverview:
                NavigationStack { FormLessonScreen(mode: .overview) }
            case .formKeyboard:
                NavigationStack { FormLessonScreen(mode: .keyboard) }
            case .formValidation:
                NavigationStack { FormLessonScreen(mode: .validation) }
            case .privacyPrePrompt:
                NavigationStack { PrivacyLessonScreen(mode: .prePrompt) }
            case .privacySystemPrompt:
                NavigationStack { PrivacyLessonScreen(mode: .systemPrompt) }
            case .privacyRecovery:
                NavigationStack { PrivacyLessonScreen(mode: .recovery) }
            case .feedbackLoading:
                NavigationStack { FeedbackStateScreen(mode: .loading) }
            case .feedbackEmpty:
                NavigationStack { FeedbackStateScreen(mode: .empty) }
            case .feedbackError:
                NavigationStack { FeedbackStateScreen(mode: .error) }
            case .accessibilityDynamicType:
                NavigationStack { AccessibilityLessonScreen(mode: .dynamicType) }
                    .environment(\.dynamicTypeSize, .accessibility1)
            case .accessibilityVoiceOver:
                NavigationStack { AccessibilityLessonScreen(mode: .voiceOver) }
            case .accessibilityTouchTarget:
                NavigationStack { AccessibilityLessonScreen(mode: .touchTarget) }
            case .normal, .compare, .checklist, .filterSheet:
                tabContent
            }
        }
        .onAppear {
            if screenshotMode == .filterSheet {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                    isFilterPresented = true
                }
            }
        }
    }

    private var tabContent: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                LearnScreen(isFilterPresented: $isFilterPresented)
            }
            .tabItem { Label("Learn", systemImage: "book") }
            .tag(AppTab.learn)

            NavigationStack {
                CompareScreen()
            }
            .tabItem { Label("Compare", systemImage: "rectangle.split.2x1") }
            .tag(AppTab.compare)

            NavigationStack {
                LabScreen()
            }
            .tabItem { Label("Lab", systemImage: "hand.tap") }
            .tag(AppTab.lab)

            NavigationStack {
                ChecklistScreen()
            }
            .tabItem { Label("Review", systemImage: "checkmark.circle") }
            .tag(AppTab.checklist)
        }
        .tint(.blue)
        .sheet(isPresented: $isFilterPresented) {
            FilterSheet()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
}

enum ScreenshotMode: String {
    case normal
    case compare
    case checklist
    case structureDetail
    case filterSheet
    case navigationTitleLarge
    case navigationInlineBack
    case navigationToolbar
    case formOverview
    case formKeyboard
    case formValidation
    case privacyPrePrompt
    case privacySystemPrompt
    case privacyRecovery
    case feedbackLoading
    case feedbackEmpty
    case feedbackError
    case accessibilityDynamicType
    case accessibilityVoiceOver
    case accessibilityTouchTarget

    static var current: ScreenshotMode {
        guard let index = CommandLine.arguments.firstIndex(of: "--ivibe-screenshot"),
              CommandLine.arguments.indices.contains(index + 1) else {
            return .normal
        }
        return ScreenshotMode(rawValue: CommandLine.arguments[index + 1]) ?? .normal
    }

    var initialTab: AppTab {
        switch self {
        case .compare:
            return .compare
        case .checklist:
            return .checklist
        case .normal, .structureDetail, .filterSheet, .navigationTitleLarge, .navigationInlineBack, .navigationToolbar, .formOverview, .formKeyboard, .formValidation, .privacyPrePrompt, .privacySystemPrompt, .privacyRecovery, .feedbackLoading, .feedbackEmpty, .feedbackError, .accessibilityDynamicType, .accessibilityVoiceOver, .accessibilityTouchTarget:
            return .learn
        }
    }
}

enum AppTab: Hashable {
    case learn
    case compare
    case lab
    case checklist
}

struct LearnScreen: View {
    @Binding var isFilterPresented: Bool

    private let mapItems: [UXMapItem] = [
        UXMapItem(
            label: "Structure",
            title: "Tab Bar · Stack · Sheet",
            subtitle: "큰 영역, 깊이, 잠깐 작업을 역할별로 분리합니다.",
            symbol: "rectangle.3.group",
            tint: .blue,
            destination: .structure
        ),
        UXMapItem(
            label: "Navigation UI",
            title: "Title · Back · Toolbar",
            subtitle: "현재 위치와 주요 행동을 시스템 내비게이션에 둡니다.",
            symbol: "rectangle.topthird.inset.filled",
            tint: .indigo,
            destination: .navigation
        ),
        UXMapItem(
            label: "Input",
            title: "Form · Keyboard · Validation",
            subtitle: "라벨, 키보드 타입, 오류 회복을 입력 흐름 안에 둡니다.",
            symbol: "keyboard",
            tint: .green,
            destination: .input
        ),
        UXMapItem(
            label: "System",
            title: "Permission · Privacy · Settings",
            subtitle: "권한은 필요한 순간에 설명하고 거절 후 복구를 제공합니다.",
            symbol: "lock.shield",
            tint: .orange,
            destination: .privacy
        ),
        UXMapItem(
            label: "Feedback",
            title: "Loading · Empty · Error",
            subtitle: "대기, 빈 상태, 실패 후 다음 행동을 명확히 보여줍니다.",
            symbol: "exclamationmark.arrow.trianglehead.2.clockwise.rotate.90",
            tint: .red,
            destination: .feedback
        ),
        UXMapItem(
            label: "Accessibility",
            title: "Dynamic Type · VoiceOver · 44pt",
            subtitle: "큰 글자, 읽기 순서, 터치 영역을 기본 품질로 확인합니다.",
            symbol: "accessibility",
            tint: .purple,
            destination: .accessibility
        )
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("iOS UX/UI Map")
                        .font(.title.weight(.bold))
                        .tracking(-0.8)
                    Text("AI로 만든 앱을 iOS답게 점검하는 기본 지도")
                        .font(.headline.weight(.semibold))
                    Text("각 카드는 실제 iOS 컴포넌트 화면으로 이어집니다. 문서는 읽고, 앱에서는 만져보며 확인합니다.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    LinearGradient(
                        colors: [.blue.opacity(0.16), .cyan.opacity(0.08)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    in: RoundedRectangle(cornerRadius: 26, style: .continuous)
                )

                VStack(alignment: .leading, spacing: 10) {
                    Text("CORE COMPONENTS")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.secondary)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                        ForEach(mapItems) { item in
                            NavigationLink {
                                destination(for: item.destination)
                            } label: {
                                UXMapCard(item: item)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Bad → Good으로 확인")
                        .font(.headline)
                    Text("탭을 버튼처럼 쓰기, 키보드가 CTA를 가리기, 앱 실행 즉시 권한 요청처럼 AI 앱에서 자주 생기는 문제를 비교합니다.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 110)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("ivibe")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isFilterPresented = true
                } label: {
                    Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                }
            }
        }
    }

    @ViewBuilder
    private func destination(for destination: UXMapDestination) -> some View {
        switch destination {
        case .structure:
            LessonDetailScreen()
        case .navigation:
            NavigationTitleLargeScreen()
        case .input:
            FormLessonScreen(mode: .overview)
        case .privacy:
            PrivacyLessonScreen(mode: .prePrompt)
        case .feedback:
            FeedbackStateScreen(mode: .loading)
        case .accessibility:
            AccessibilityLessonScreen(mode: .dynamicType)
        }
    }
}

struct UXMapItem: Identifiable {
    let id = UUID()
    let label: String
    let title: String
    let subtitle: String
    let symbol: String
    let tint: Color
    let destination: UXMapDestination
}

enum UXMapDestination {
    case structure
    case navigation
    case input
    case privacy
    case feedback
    case accessibility
}

struct UXMapCard: View {
    let item: UXMapItem

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(alignment: .top) {
                Image(systemName: item.symbol)
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(item.tint)
                    .frame(width: 32, height: 32)
                    .background(item.tint.opacity(0.14), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                Spacer(minLength: 6)
                Image(systemName: "chevron.right")
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(.tertiary)
                    .padding(.top, 6)
            }

            Text(item.label.uppercased())
                .font(.caption2.weight(.heavy))
                .foregroundStyle(item.tint)

            Text(item.title)
                .font(.caption.weight(.bold))
                .foregroundStyle(.primary)
                .lineLimit(2)
                .minimumScaleFactor(0.86)

            Text(item.subtitle)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(10)
        .frame(maxWidth: .infinity, minHeight: 112, alignment: .topLeading)
        .background(.background, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(Color(.separator).opacity(0.28), lineWidth: 0.5)
        }
    }
}

struct LessonRow: View {
    let title: String
    let subtitle: String
    let symbol: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: symbol)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.blue)
                .frame(width: 34, height: 34)
                .background(.blue.opacity(0.12), in: RoundedRectangle(cornerRadius: 10, style: .continuous))

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body.weight(.semibold))
                Text(subtitle)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
    }
}

struct LessonDetailScreen: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                Text("iOS 앱 구조는 화면 모양보다 역할로 나눕니다.")
                    .font(.title2.weight(.bold))
                    .padding(.top, 8)

                ComponentExplanationCard(
                    label: "Top-level",
                    title: "Tab Bar",
                    description: "앱의 최상위 목적지를 오갈 때 사용합니다.",
                    symbol: "rectangle.bottomthird.inset.filled"
                )

                ComponentExplanationCard(
                    label: "Depth",
                    title: "NavigationStack",
                    description: "한 영역 안에서 목록 → 상세처럼 깊이가 생길 때 사용합니다.",
                    symbol: "chevron.right.square"
                )

                ComponentExplanationCard(
                    label: "Temporary task",
                    title: "Sheet",
                    description: "현재 화면 위에서 짧게 끝나는 작업을 처리할 때 사용합니다.",
                    symbol: "rectangle.bottomhalf.inset.filled"
                )
            }
            .padding()
        }
        .navigationTitle("Structure")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ComponentExplanationCard: View {
    let label: String
    let title: String
    let description: String
    let symbol: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: symbol)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.blue)
                Spacer()
                Text(label.uppercased())
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(.secondary)
            }

            Text(title)
                .font(.title3.weight(.bold))

            Text(description)
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
    }
}

enum FormLessonMode {
    case overview
    case keyboard
    case validation
}

struct FormLessonScreen: View {
    let mode: FormLessonMode
    @State private var appName = "ivibe"
    @State private var email = "sangwan@example.com"
    @State private var message = ""
    @State private var agreeToUpdates = true
    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case email
        case message
    }

    var body: some View {
        Form {
            Section {
                LabeledContent("목적", value: "iOS UX 점검")
                TextField("앱 이름", text: $appName)
                    .textInputAutocapitalization(.words)
                TextField("이메일", text: $email)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .focused($focusedField, equals: .email)
                    .submitLabel(.done)

                if mode == .validation {
                    Label("올바른 이메일 주소를 입력해 주세요.", systemImage: "exclamationmark.circle.fill")
                        .font(.footnote)
                        .foregroundStyle(.red)
                }
            } header: {
                Text("기본 정보")
            } footer: {
                Text("입력 화면은 사용자가 무엇을 넣어야 하는지 바로 이해할 수 있게 라벨, 키보드 타입, 도움말을 같이 설계합니다.")
            }

            Section {
                TextField("개선하고 싶은 점", text: $message, axis: .vertical)
                    .lineLimit(3...5)
                    .focused($focusedField, equals: .message)
                    .submitLabel(.done)

                if mode == .validation {
                    Label("최소 10자 이상 입력해 주세요.", systemImage: "exclamationmark.circle.fill")
                        .font(.footnote)
                        .foregroundStyle(.red)
                } else {
                    Text("예: 권한 요청 타이밍, 키보드가 버튼을 가리는 문제")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            } header: {
                Text("상세 설명")
            }

            Section {
                Toggle("업데이트 소식 받기", isOn: $agreeToUpdates)
            }

            Section {
                Button("검토 요청") {}
                    .disabled(mode == .validation)
            } footer: {
                if mode == .validation {
                    Text("오류는 제출 후 한꺼번에 숨기기보다, 사용자가 바로 고칠 수 있는 위치에 표시합니다.")
                        .foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("Form")
        .navigationBarTitleDisplayMode(mode == .overview ? .large : .inline)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("완료") { focusedField = nil }
            }
        }
        .onAppear {
            if mode == .keyboard {
                email = "review@example.com"
                message = "키보드가 입력 중인 필드와 완료 버튼을 가리지 않게 확인합니다."
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                    focusedField = .email
                }
            } else if mode == .validation {
                appName = ""
                email = "wrong-email"
                message = "짧음"
            }
        }
    }
}

enum PrivacyLessonMode {
    case prePrompt
    case systemPrompt
    case recovery
}

struct PrivacyLessonScreen: View {
    let mode: PrivacyLessonMode
    @State private var didRequestCamera = false

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 12) {
                    Image(systemName: mode.symbol)
                        .font(.system(size: 42, weight: .semibold))
                        .foregroundStyle(mode.tint)
                        .frame(width: 58, height: 58)
                        .background(mode.tint.opacity(0.14), in: RoundedRectangle(cornerRadius: 18, style: .continuous))

                    Text(mode.headline)
                        .font(.title2.weight(.bold))

                    Text(mode.explanation)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 8)
            }

            Section("좋은 권한 요청") {
                Label("기능을 쓰려는 순간에 요청", systemImage: "checkmark.circle")
                Label("요청 전에 이유와 이점을 설명", systemImage: "text.bubble")
                Label("거절 후에는 설정 복구 경로 제공", systemImage: "gearshape")
            }

            Section {
                Button(mode.primaryActionTitle) {
                    requestCameraAccessIfNeeded()
                }
                .buttonStyle(.borderedProminent)
                .disabled(mode == .recovery)

                if mode == .recovery {
                    Button("설정에서 카메라 접근 켜기") {}
                    Text("권한이 거절된 뒤에는 같은 시스템 요청을 반복할 수 없습니다. 사용자가 설정에서 직접 바꿀 수 있게 안내해야 합니다.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                } else {
                    Text("앱 실행 직후가 아니라 사용자가 사진 리뷰 기능을 시작할 때 요청하는 예시입니다.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Privacy")
        .navigationBarTitleDisplayMode(mode == .prePrompt ? .large : .inline)
        .onAppear {
            if mode == .systemPrompt {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                    requestCameraAccessIfNeeded()
                }
            }
        }
    }

    private func requestCameraAccessIfNeeded() {
        guard !didRequestCamera else { return }
        didRequestCamera = true
        AVCaptureDevice.requestAccess(for: .video) { _ in }
    }
}

private extension PrivacyLessonMode {
    var symbol: String {
        switch self {
        case .prePrompt: return "camera.viewfinder"
        case .systemPrompt: return "hand.raised.fill"
        case .recovery: return "gearshape.fill"
        }
    }

    var tint: Color {
        switch self {
        case .prePrompt: return .blue
        case .systemPrompt: return .orange
        case .recovery: return .red
        }
    }

    var headline: String {
        switch self {
        case .prePrompt:
            return "사진 리뷰를 시작할 때 카메라 접근이 필요해요"
        case .systemPrompt:
            return "시스템 권한 요청은 한 번만 분명하게"
        case .recovery:
            return "거절 후에는 설정에서 다시 켤 수 있게"
        }
    }

    var explanation: String {
        switch self {
        case .prePrompt:
            return "먼저 왜 필요한지 설명하고, 사용자가 기능을 시작할 준비가 되었을 때 iOS 권한 요청을 띄웁니다."
        case .systemPrompt:
            return "iOS 시스템 alert는 앱이 마음대로 꾸미는 화면이 아닙니다. 그래서 띄우기 전 맥락을 충분히 만들어야 합니다."
        case .recovery:
            return "권한을 거절한 사용자를 탓하지 말고, 기능 제한과 복구 방법을 짧고 명확하게 안내합니다."
        }
    }

    var primaryActionTitle: String {
        switch self {
        case .prePrompt: return "사진 리뷰 시작"
        case .systemPrompt: return "카메라 접근 요청"
        case .recovery: return "현재 접근 불가"
        }
    }
}


enum FeedbackStateMode {
    case loading
    case empty
    case error
}

struct FeedbackStateScreen: View {
    let mode: FeedbackStateMode

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 16) {
                    stateHero

                    Text(mode.headline)
                        .font(.title2.weight(.bold))

                    Text(mode.explanation)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
            }

            Section("사용자가 알아야 할 것") {
                ForEach(mode.signals, id: \.self) { signal in
                    Label(signal, systemImage: "checkmark.circle")
                }
            }

            Section {
                if mode == .error {
                    Button("다시 시도") {}
                        .buttonStyle(.borderedProminent)
                    Button("문제 신고") {}
                } else if mode == .empty {
                    Button("첫 점검 항목 만들기") {}
                        .buttonStyle(.borderedProminent)
                } else {
                    Button("불러오는 중") {}
                        .disabled(true)
                }
            } footer: {
                Text(mode.footer)
            }
        }
        .navigationTitle(mode.title)
        .navigationBarTitleDisplayMode(mode == .loading ? .large : .inline)
    }

    @ViewBuilder
    private var stateHero: some View {
        switch mode {
        case .loading:
            HStack(spacing: 14) {
                ProgressView()
                    .controlSize(.large)
                VStack(alignment: .leading, spacing: 4) {
                    Text("가이드를 불러오는 중")
                        .font(.headline)
                    Text("잠시만 기다려 주세요.")
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.blue.opacity(0.10), in: RoundedRectangle(cornerRadius: 20, style: .continuous))

        case .empty:
            ContentUnavailableView(
                "아직 점검 항목이 없습니다",
                systemImage: "tray",
                description: Text("첫 점검 항목을 만들면 여기에서 iOS 기본기 리뷰를 이어갈 수 있습니다.")
            )
            .frame(maxWidth: .infinity, minHeight: 210)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 22, style: .continuous))

        case .error:
            VStack(alignment: .leading, spacing: 12) {
                Image(systemName: "wifi.exclamationmark")
                    .font(.system(size: 42, weight: .semibold))
                    .foregroundStyle(.red)
                    .frame(width: 58, height: 58)
                    .background(.red.opacity(0.12), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                Text("가이드를 불러오지 못했습니다")
                    .font(.headline)
                Text("연결 상태를 확인한 뒤 다시 시도해 주세요.")
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.red.opacity(0.08), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        }
    }
}

private extension FeedbackStateMode {
    var title: String {
        switch self {
        case .loading: return "Loading"
        case .empty: return "Empty"
        case .error: return "Error"
        }
    }

    var headline: String {
        switch self {
        case .loading: return "기다리는 이유가 보여야 합니다"
        case .empty: return "빈 화면도 하나의 상태입니다"
        case .error: return "실패 후 다음 행동이 있어야 합니다"
        }
    }

    var explanation: String {
        switch self {
        case .loading:
            return "데이터를 가져오는 동안 사용자가 앱이 멈췄다고 느끼지 않게 진행 중임을 보여줍니다."
        case .empty:
            return "아직 콘텐츠가 없을 때는 빈 공간을 방치하지 말고, 왜 비어 있는지와 다음 행동을 알려줍니다."
        case .error:
            return "실패 원인을 개발자식 코드로 노출하기보다, 사용자가 시도할 수 있는 복구 행동을 제공합니다."
        }
    }

    var signals: [String] {
        switch self {
        case .loading:
            return ["앱이 작업 중임을 즉시 표시", "가능하면 기다리는 대상을 설명", "완료 후 이동할 위치를 예측 가능하게 유지"]
        case .empty:
            return ["비어 있는 이유를 짧게 설명", "첫 행동을 명확히 제안", "오류와 빈 상태를 섞지 않음"]
        case .error:
            return ["사용자가 이해할 수 있는 말로 설명", "다시 시도 또는 설정 변경 제공", "위험한 작업은 확인 절차 추가"]
        }
    }

    var footer: String {
        switch self {
        case .loading:
            return "무한 spinner만 두면 사용자는 실패인지 대기인지 알 수 없습니다."
        case .empty:
            return "빈 상태는 문제 상황이 아니라 다음 행동을 시작하게 만드는 안내 화면입니다."
        case .error:
            return "복구 가능한 오류는 retry를, 파괴적 작업은 confirmation을 함께 설계합니다."
        }
    }
}


enum AccessibilityLessonMode {
    case dynamicType
    case voiceOver
    case touchTarget
}

struct AccessibilityLessonScreen: View {
    let mode: AccessibilityLessonMode

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 16) {
                    Image(systemName: mode.symbol)
                        .font(.system(size: 42, weight: .semibold))
                        .foregroundStyle(mode.tint)
                        .frame(width: 58, height: 58)
                        .background(mode.tint.opacity(0.14), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .accessibilityHidden(true)

                    Text(mode.headline)
                        .font(.title2.weight(.bold))
                        .fixedSize(horizontal: false, vertical: true)

                    Text(mode.explanation)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.vertical, 8)
            }

            Section("좋은 기본값") {
                ForEach(mode.goodSignals, id: \.self) { signal in
                    Label(signal, systemImage: "checkmark.circle")
                }
            }

            Section {
                if mode == .touchTarget {
                    VStack(alignment: .leading, spacing: 12) {
                        Button("주요 작업 계속하기") {}
                            .buttonStyle(.borderedProminent)
                            .frame(minHeight: 44)

                        HStack(spacing: 12) {
                            Button {
                            } label: {
                                Label("좋아요", systemImage: "hand.thumbsup")
                                    .frame(minWidth: 44, minHeight: 44)
                            }
                            .buttonStyle(.bordered)

                            Button {
                            } label: {
                                Label("공유", systemImage: "square.and.arrow.up")
                                    .frame(minWidth: 44, minHeight: 44)
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                } else if mode == .voiceOver {
                    HStack(spacing: 14) {
                        Image(systemName: "bell.badge")
                            .font(.title2)
                            .foregroundStyle(.orange)
                            .frame(width: 44, height: 44)
                            .background(.orange.opacity(0.12), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .accessibilityHidden(true)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("권한 요청 전에 알림")
                                .font(.headline)
                            Text("VoiceOver는 아이콘이 아니라 의미를 읽어야 합니다.")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("권한 요청 전에 알림")
                    .accessibilityHint("아이콘만 보이는 버튼에도 읽을 수 있는 이름이 필요합니다.")
                } else {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("큰 글자에서도 정보가 잘리지 않아야 합니다.")
                            .font(.headline)
                        Text("고정 높이 카드나 한 줄 제한은 Dynamic Type에서 중요한 설명을 숨길 수 있습니다. 텍스트가 여러 줄로 늘어나도 구조가 유지되는지 확인합니다.")
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            } header: {
                Text("실제 컨트롤")
            } footer: {
                Text(mode.footer)
            }
        }
        .navigationTitle(mode.title)
        .navigationBarTitleDisplayMode(mode == .dynamicType ? .large : .inline)
    }
}

private extension AccessibilityLessonMode {
    var title: String {
        switch self {
        case .dynamicType: return "Dynamic Type"
        case .voiceOver: return "VoiceOver"
        case .touchTarget: return "Touch Target"
        }
    }

    var symbol: String {
        switch self {
        case .dynamicType: return "textformat.size"
        case .voiceOver: return "speaker.wave.2"
        case .touchTarget: return "hand.tap"
        }
    }

    var tint: Color {
        switch self {
        case .dynamicType: return .blue
        case .voiceOver: return .purple
        case .touchTarget: return .green
        }
    }

    var headline: String {
        switch self {
        case .dynamicType: return "큰 글자에서도 화면이 무너지지 않아야 합니다"
        case .voiceOver: return "보이는 모양보다 읽히는 의미가 중요합니다"
        case .touchTarget: return "누를 수 있는 영역은 충분히 커야 합니다"
        }
    }

    var explanation: String {
        switch self {
        case .dynamicType:
            return "텍스트 크기를 키워도 제목, 설명, 버튼이 잘리지 않고 자연스럽게 여러 줄로 흐르는지 확인합니다."
        case .voiceOver:
            return "아이콘만 있는 버튼, 상태 카드, 이미지에는 VoiceOver가 읽을 수 있는 이름과 힌트가 필요합니다."
        case .touchTarget:
            return "작아 보이는 아이콘 버튼도 실제 터치 영역은 최소 44pt 이상 확보해야 안정적으로 누를 수 있습니다."
        }
    }

    var goodSignals: [String] {
        switch self {
        case .dynamicType:
            return ["시스템 폰트와 text style 사용", "한 줄 고정 대신 자연스러운 줄바꿈", "큰 글자에서 버튼과 설명이 겹치지 않음"]
        case .voiceOver:
            return ["아이콘 버튼에 명확한 accessibility label", "장식 이미지는 accessibilityHidden 처리", "상태와 다음 행동을 함께 읽을 수 있음"]
        case .touchTarget:
            return ["주요 버튼은 쉽게 누를 수 있는 높이", "아이콘 버튼도 44pt 이상 터치 영역", "버튼 사이 간격이 너무 좁지 않음"]
        }
    }

    var footer: String {
        switch self {
        case .dynamicType:
            return "접근성은 별도 모드가 아니라 기본 UI가 다양한 사용자 설정을 견디는 능력입니다."
        case .voiceOver:
            return "화면을 보지 않고도 현재 상태와 가능한 행동을 이해할 수 있어야 합니다."
        case .touchTarget:
            return "시각적으로 작은 아이콘이라도 실제 hit target은 충분히 커야 합니다."
        }
    }
}


struct NavigationTitleLargeScreen: View {
    var body: some View {
        List {
            Section {
                NavigationLink("상세 화면으로 들어가기") {
                    NavigationInlineDetailScreen()
                }
                Label("큰 제목은 현재 영역을 먼저 인식하게 합니다.", systemImage: "textformat.size")
                Label("Toolbar 액션은 화면 전체에 필요한 작업만 둡니다.", systemImage: "slider.horizontal.3")
            } header: {
                Text("Navigation Bar")
            } footer: {
                Text("최상위 화면에서는 large title이 사용자의 위치를 빠르게 알려줍니다.")
            }

            Section("이 화면에서 확인할 것") {
                Label("제목은 콘텐츠의 목적을 말하는가", systemImage: "checkmark.circle")
                Label("액션은 오른쪽 상단 한두 개로 충분한가", systemImage: "checkmark.circle")
                Label("목록에서 상세로 들어가는 흐름이 보이는가", systemImage: "checkmark.circle")
            }
        }
        .navigationTitle("Titles")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                } label: {
                    Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                }
            }
        }
    }
}

struct NavigationBackDemoContainer: View {
    @State private var path = ["detail"]

    var body: some View {
        NavigationStack(path: $path) {
            NavigationTitleLargeScreen()
                .navigationDestination(for: String.self) { _ in
                    NavigationInlineDetailScreen()
                }
        }
    }
}

struct NavigationInlineDetailScreen: View {
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text("상세 화면")
                        .font(.headline)
                    Text("한 단계 안으로 들어온 화면은 보통 inline title과 시스템 back button을 사용합니다.")
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 4)
            }

            Section("좋은 신호") {
                Label("왼쪽 위 Back으로 이전 화면을 예측할 수 있음", systemImage: "chevron.backward.circle")
                Label("중앙 제목이 현재 화면만 짧게 설명함", systemImage: "textformat")
                Label("본문은 제목을 반복하지 않고 다음 정보를 보여줌", systemImage: "doc.text")
            }
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                } label: {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
            }
        }
    }
}

struct NavigationToolbarScreen: View {
    @State private var notificationsEnabled = true
    @State private var compactMode = false

    var body: some View {
        Form {
            Section("화면 액션") {
                Toggle("중요 알림만 보기", isOn: $notificationsEnabled)
                Toggle("간단 모드", isOn: $compactMode)
            }

            Section {
                Text("Toolbar는 현재 화면에서 자주 쓰는 액션만 올려야 합니다. 저장/취소처럼 작업을 끝내는 버튼과 필터/공유처럼 보조 액션을 구분합니다.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Actions")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("취소") {}
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("저장") {}
            }
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button("공유", systemImage: "square.and.arrow.up") {}
                    Button("복제", systemImage: "doc.on.doc") {}
                } label: {
                    Label("More", systemImage: "ellipsis.circle")
                }
            }
        }
    }
}

struct CompareScreen: View {
    var body: some View {
        List {
            Section("Bad") {
                Text("탭을 기능 버튼처럼 늘어놓기")
                Text("상세 화면을 계속 Sheet로 띄우기")
                Text("키보드가 CTA를 가리는데 그대로 두기")
                Text("앱 실행 직후 권한을 먼저 요구하기")
            }
            Section("Good") {
                Text("큰 영역은 Tab Bar")
                Text("목록 → 상세는 NavigationStack")
                Text("입력 오류는 필드 가까이에 표시")
                Text("권한은 필요한 순간에 이유와 함께 요청")
            }
        }
        .navigationTitle("Compare")
    }
}

struct LabScreen: View {
    var body: some View {
        ContentUnavailableView(
            "Lab 준비 중",
            systemImage: "hand.tap",
            description: Text("다음 단계에서 실제 터치 실습을 하나씩 추가합니다.")
        )
        .navigationTitle("Lab")
    }
}

struct ChecklistScreen: View {
    var body: some View {
        List {
            Section("Structure") {
                Label("최상위 목적지만 Tab Bar에 넣었는가", systemImage: "checkmark.circle")
                Label("목록 → 상세는 NavigationStack인가", systemImage: "checkmark.circle")
                Label("짧은 작업만 Sheet로 띄우는가", systemImage: "checkmark.circle")
            }

            Section("Input") {
                Label("필드 라벨이 명확한가", systemImage: "checkmark.circle")
                Label("키보드 타입이 입력 목적과 맞는가", systemImage: "checkmark.circle")
                Label("오류를 고칠 위치 가까이에 보여주는가", systemImage: "checkmark.circle")
            }

            Section("Privacy") {
                Label("권한이 필요한 기능을 쓰는 순간에 요청하는가", systemImage: "checkmark.circle")
                Label("시스템 alert 전에 이유를 설명하는가", systemImage: "checkmark.circle")
                Label("거절 후 설정 복구 경로를 제공하는가", systemImage: "checkmark.circle")
            }
        }
        .navigationTitle("Review")
    }
}

struct FilterSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var importantOnly = true
    @State private var unfinishedOnly = false

    var body: some View {
        NavigationStack {
            Form {
                Section("보기 옵션") {
                    Toggle("중요한 항목만 보기", isOn: $importantOnly)
                    Toggle("완료 안 한 항목", isOn: $unfinishedOnly)
                }

                Section {
                    Text("Sheet는 현재 화면 위에서 잠깐 끝나는 필터나 짧은 입력에 적합합니다.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("필터")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("적용") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    RootView()
}
