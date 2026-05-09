# NavigationStack / Tab Bar / Sheet를 언제 구분해야 하는가

> 두 번째 원칙: iOS 앱 구조는 “버튼으로 연결된 페이지 묶음”이 아니라, 사용자가 현재 위치와 작업 범위를 예측할 수 있는 계층입니다.

<div class="article-summary-card">
  <p><strong>이 글의 목표</strong></p>
  <p>AI/vibe coding으로 만든 iOS 앱에서 자주 섞이는 <strong>Tab Bar</strong>, <strong>NavigationStack</strong>, <strong>Sheet</strong>의 역할을 공식 문서 기준으로 분리합니다. 핵심은 “어떤 화면을 어떻게 띄울까?”가 아니라 <strong>이 화면이 앱의 최상위 영역인지, 한 흐름 안의 다음 깊이인지, 잠깐 수행하는 작업인지</strong>를 먼저 판단하는 것입니다.</p>
</div>

## 먼저 결론

- **Tab Bar**: 앱의 최상위 목적지가 여러 개일 때 사용합니다.
- **NavigationStack**: 한 목적지 안에서 목록 → 상세 → 편집처럼 깊이가 생길 때 사용합니다.
- **Sheet**: 현재 맥락 위에서 짧고 제한된 작업을 완료하거나 보조 정보를 입력할 때 사용합니다.

<div class="principle-card">
  <strong>ivibe 원칙</strong>
  <p>컴포넌트 선택은 화면 모양이 아니라 사용자의 위치 감각과 작업 범위로 결정합니다.</p>
</div>

---

## 공식 문서 근거

<div class="evidence-grid">
  <a class="evidence-card" href="https://developer.apple.com/design/human-interface-guidelines/navigation-and-search">
    <span>Apple HIG</span>
    <strong>Navigation and search</strong>
    <p>사용자가 앱 안에서 현재 위치를 이해하고, 원하는 콘텐츠를 찾고, 이동할 수 있게 하는 것이 내비게이션의 목적입니다.</p>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/design/human-interface-guidelines/tab-bars">
    <span>Apple HIG</span>
    <strong>Tab bars</strong>
    <p>탭 바는 앱의 최상위 섹션 사이를 전환하는 데 쓰는 iOS 컴포넌트입니다.</p>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/design/human-interface-guidelines/sheets">
    <span>Apple HIG</span>
    <strong>Sheets</strong>
    <p>시트는 현재 맥락과 관련된 별도 작업이나 선택을 수행하게 하는 임시 표면입니다.</p>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/documentation/swiftui/navigationstack">
    <span>SwiftUI</span>
    <strong>NavigationStack</strong>
    <p>SwiftUI에서 데이터 기반 내비게이션 경로를 구성하고 화면 깊이를 표현하는 컨테이너입니다.</p>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/documentation/swiftui/tabview">
    <span>SwiftUI</span>
    <strong>TabView</strong>
    <p>SwiftUI에서 탭 기반 인터페이스를 구성하는 컨테이너입니다.</p>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/documentation/swiftui/view/sheet%28ispresented%3Aondismiss%3Acontent%3A%29">
    <span>SwiftUI</span>
    <strong>sheet</strong>
    <p>현재 뷰 위에 모달 시트를 표시하는 SwiftUI API입니다.</p>
  </a>
</div>

### 근거 수준

- **직접 근거**: Tab Bar는 최상위 섹션 전환, Navigation은 위치/이동 이해, Sheet는 현재 맥락 위의 임시 작업이라는 Apple 문서의 컴포넌트 역할.
- **ivibe 해석**: “Home / Search / Settings 같은 앱의 큰 방”은 Tab Bar 후보이고, “목록에서 특정 항목으로 들어가기”는 NavigationStack 후보이며, “필터/추가/공유/짧은 설정”은 Sheet 후보입니다.
- **취향이 아닌 이유**: 잘못 고르면 예쁜 화면이어도 뒤로가기, 탭 상태 보존, 취소/완료 흐름, 접근성 탐색 순서가 불안정해집니다.

---

## 판단 질문 3개

### 1. 이 화면은 앱의 최상위 목적지인가?

그렇다면 **Tab Bar** 후보입니다.

예:

- Today / Search / Library
- Learn / Compare / Lab / Checklist
- Home / Messages / Profile

최상위 목적지는 사용자가 앱을 열 때 반복적으로 돌아오는 “큰 방”입니다. 단순히 자주 쓴다는 이유만으로 모든 기능을 탭으로 만들면 안 됩니다.

### 2. 같은 목적지 안에서 더 깊이 들어가는가?

그렇다면 **NavigationStack** 후보입니다.

예:

- Checklist 목록 → 특정 체크리스트 상세
- Article 목록 → 글 상세 → 예시 상세
- Settings 목록 → Notification 설정

NavigationStack은 사용자가 “들어갔다가 뒤로 나오는” 흐름을 예측할 수 있게 해줍니다.

### 3. 현재 화면 위에서 잠깐 끝나는 작업인가?

그렇다면 **Sheet** 후보입니다.

예:

- 필터 선택
- 새 항목 추가
- 공유 전 옵션 선택
- 짧은 편집
- 권한 요청 전 설명

Sheet는 별도 목적지가 아니라 현재 맥락을 잠시 덮는 작업 표면입니다. 작업이 길어지거나 여러 단계로 깊어지면 시트보다 NavigationStack 안의 화면으로 승격하는 편이 낫습니다.

---

## Bad / Good 1 — 모든 화면을 Tab Bar에 넣기

<div class="compare-section">
  <div class="bad-panel">
    <span class="panel-label">Bad</span>
    <h3>탭이 기능 버튼처럼 늘어남</h3>
    <ul>
      <li>Home</li>
      <li>Search</li>
      <li>Write</li>
      <li>Filter</li>
      <li>Settings</li>
    </ul>
    <p>탭이 “최상위 섹션”이 아니라 자주 쓰는 액션 모음처럼 변합니다.</p>
  </div>
  <div class="good-panel">
    <span class="panel-label">Good</span>
    <h3>탭은 큰 영역만 유지</h3>
    <ul>
      <li>Learn</li>
      <li>Compare</li>
      <li>Lab</li>
      <li>Checklist</li>
    </ul>
    <p>작성, 필터, 공유 같은 작업은 toolbar 버튼이나 sheet로 분리합니다.</p>
  </div>
</div>

### 왜 Bad인가

Tab Bar는 앱의 최상위 섹션 전환을 위한 컴포넌트입니다. 기능 버튼처럼 쓰면 사용자는 탭을 눌렀을 때 “앱의 다른 방으로 이동하는지”, “현재 화면에서 어떤 작업이 시작되는지”를 예측하기 어렵습니다.

### SwiftUI 힌트

```swift
TabView {
    LearnListView()
        .tabItem { Label("Learn", systemImage: "book") }

    CompareView()
        .tabItem {
            Label(
                "Compare",
                systemImage: "rectangle.split.2x1"
            )
        }

    LabView()
        .tabItem { Label("Lab", systemImage: "hand.tap") }

    ChecklistView()
        .tabItem { Label("Checklist", systemImage: "checklist") }
}
```

---

## Bad / Good 2 — 목록 상세를 Sheet로 계속 띄우기

<div class="compare-section">
  <div class="bad-panel">
    <span class="panel-label">Bad</span>
    <h3>상세 화면을 계속 sheet로 표시</h3>
    <p>카드를 누를 때마다 전체 상세가 sheet로 뜨고, 그 안에서 또 다른 sheet를 띄웁니다.</p>
    <p>결과적으로 닫기, 뒤로가기, 상태 보존이 섞입니다.</p>
  </div>
  <div class="good-panel">
    <span class="panel-label">Good</span>
    <h3>목록 → 상세는 NavigationStack</h3>
    <p>목록에서 항목을 누르면 상세로 push합니다.</p>
    <p>짧은 편집이나 필터만 sheet로 제한합니다.</p>
  </div>
</div>

### 왜 Good인가

목록에서 상세로 들어가는 흐름은 사용자가 “뒤로 돌아갈 수 있는 깊이”로 이해합니다. NavigationStack은 이 mental model에 맞고, iOS의 back affordance와도 잘 맞습니다.

### SwiftUI 힌트

```swift
NavigationStack {
    List(lessons) { lesson in
        NavigationLink(lesson.title, value: lesson)
    }
    .navigationDestination(for: Lesson.self) { lesson in
        LessonDetailView(lesson: lesson)
    }
    .navigationTitle("Learn")
}
```

---

## Bad / Good 3 — 긴 온보딩/설정을 Sheet에 가두기

<div class="compare-section">
  <div class="bad-panel">
    <span class="panel-label">Bad</span>
    <h3>여러 단계 설정을 sheet 안에 모두 넣음</h3>
    <p>계정 생성, 권한 설명, 프로필 입력, 알림 설정을 하나의 sheet에서 계속 진행합니다.</p>
    <p>사용자는 이 흐름이 취소 가능한 임시 작업인지, 앱의 핵심 설정인지 헷갈립니다.</p>
  </div>
  <div class="good-panel">
    <span class="panel-label">Good</span>
    <h3>짧은 작업만 sheet로 제한</h3>
    <p>필터, 간단 입력, 확인처럼 현재 맥락과 가까운 작업만 sheet로 둡니다.</p>
    <p>긴 설정은 독립 화면이나 NavigationStack 흐름으로 둡니다.</p>
  </div>
</div>

### 판단 기준

Sheet는 “잠깐 덮고 돌아오는” 표면입니다. 작업이 길거나 앱의 상태를 크게 바꾸면 사용자는 더 명확한 위치, 제목, 뒤로가기, 진행 상태를 기대합니다.

### SwiftUI 힌트

```swift
@State private var isFilterPresented = false

Button("필터") {
    isFilterPresented = true
}
.sheet(isPresented: $isFilterPresented) {
    FilterSheet()
        .presentationDetents([.medium, .large])
}
```

---

## ivibe 앱에 적용하면

ivibe의 iOS companion app은 다음 구조가 자연스럽습니다.

```text
TabView
├─ Learn
│  └─ NavigationStack: 글 목록 → 글 상세 → 예시 상세
├─ Compare
│  └─ NavigationStack: Bad/Good 목록 → 비교 상세
├─ Lab
│  └─ NavigationStack: 체험 목록 → 실습 화면
└─ Checklist
   └─ NavigationStack: 체크리스트 목록 → 항목 상세

Sheet
├─ 필터
├─ 짧은 입력
├─ 공유 옵션
└─ 권한 요청 전 설명
```

여기서 중요한 점은 `Lab` 자체는 탭이지만, `Lab` 안의 각 실습은 NavigationStack으로 들어간다는 것입니다. 그리고 실습 중 짧은 설정만 Sheet로 띄웁니다.

---

## 체크리스트

- [ ] 이 화면이 앱의 최상위 목적지인지 먼저 물었다.
- [ ] 최상위 목적지라면 Tab Bar 후보로 분류했다.
- [ ] 목록 → 상세 → 편집처럼 깊이가 생기면 NavigationStack으로 분류했다.
- [ ] 현재 화면 위에서 잠깐 끝나는 작업만 Sheet로 분류했다.
- [ ] Sheet 안에 또 다른 복잡한 navigation을 쌓지 않았다.
- [ ] Tab Bar를 액션 버튼 모음처럼 쓰지 않았다.
- [ ] 뒤로가기와 닫기 버튼의 의미가 섞이지 않는다.
- [ ] SwiftUI 구조가 컴포넌트 역할과 맞다: `TabView`, `NavigationStack`, `.sheet`.

---

## 다음 글

다음에는 **Form / Keyboard / Validation**을 다룹니다. AI로 만든 앱에서 자주 보이는 “키보드가 CTA를 가리는 문제”, “웹식 inline validation”, “입력 중 저장/취소 흐름이 불명확한 문제”를 Apple 문서 기준으로 분해합니다.
