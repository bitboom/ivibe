import SwiftUI

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
            case .formOverview:
                NavigationStack { FormLessonScreen(mode: .overview) }
            case .formKeyboard:
                NavigationStack { FormLessonScreen(mode: .keyboard) }
            case .formValidation:
                NavigationStack { FormLessonScreen(mode: .validation) }
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
            .tabItem { Label("Checklist", systemImage: "checklist") }
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
    case formOverview
    case formKeyboard
    case formValidation

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
        case .normal, .structureDetail, .filterSheet, .formOverview, .formKeyboard, .formValidation:
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

    var body: some View {
        List {
            Section {
                NavigationLink {
                    LessonDetailScreen()
                } label: {
                    LessonRow(
                        title: "NavigationStack / Tab Bar / Sheet",
                        subtitle: "앱의 큰 방, 깊이, 잠깐 작업을 구분합니다.",
                        symbol: "rectangle.3.group"
                    )
                }

                NavigationLink {
                    FormLessonScreen(mode: .overview)
                } label: {
                    LessonRow(
                        title: "Form / Keyboard / Validation",
                        subtitle: "입력, 키보드, 오류 회복을 iOS답게 만듭니다.",
                        symbol: "keyboard"
                    )
                }

                LessonRow(
                    title: "Permission / Privacy",
                    subtitle: "권한 요청은 필요한 순간에 설명합니다.",
                    symbol: "lock.shield"
                )
            } header: {
                Text("START")
            } footer: {
                Text("ivibe는 실제 iOS 화면을 먼저 만들고, 그 스크린샷을 문서의 학습 자료로 사용합니다.")
            }
        }
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
                message = "키보드가 입력 중인 필드와 완료 버튼을 가리지 않게 확인합니다."
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
                    focusedField = .message
                }
            } else if mode == .validation {
                appName = ""
                email = "wrong-email"
                message = "짧음"
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
            }
            Section("Good") {
                Text("큰 영역은 Tab Bar")
                Text("목록 → 상세는 NavigationStack")
                Text("입력 오류는 필드 가까이에 표시")
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
        }
        .navigationTitle("Checklist")
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
