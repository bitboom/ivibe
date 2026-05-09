# NavigationStack / Tab Bar / Sheet

> iOS 앱 구조를 잡을 때 가장 먼저 구분해야 하는 세 가지입니다.

<div class="article-summary-card compact-summary">
  <p><strong>먼저 감으로 보기</strong></p>
  <p>처음부터 긴 원칙을 외우기보다, 화면이 <strong>앱의 큰 방</strong>인지, <strong>한 단계 더 들어가는 화면</strong>인지, <strong>잠깐 띄우는 작업</strong>인지부터 보면 됩니다.</p>
</div>

## 실제 앱 화면으로 먼저 보기


<div class="real-screenshot-grid">
  <figure class="real-screenshot-card">
    <img src="/screenshots/ios26/navigation-normal.png" alt="ivibe 앱 Learn 탭의 실제 iOS 26 스크린샷" />
    <figcaption>
      <span>Top-level</span>
      <strong>Tab Bar</strong>
      <p>Learn / Compare / Lab / Checklist처럼 앱의 큰 영역을 오갈 때 씁니다.</p>
    </figcaption>
  </figure>

  <figure class="real-screenshot-card">
    <img src="/screenshots/ios26/navigation-structureDetail.png" alt="ivibe 앱 Structure 상세 화면의 실제 iOS 26 스크린샷" />
    <figcaption>
      <span>Depth</span>
      <strong>Navigation Stack</strong>
      <p>Learn 안에서 목록을 누르고 상세 화면으로 들어갈 때 씁니다.</p>
    </figcaption>
  </figure>

  <figure class="real-screenshot-card">
    <img src="/screenshots/ios26/navigation-filterSheet.png" alt="ivibe 앱 필터 Sheet의 실제 iOS 26 스크린샷" />
    <figcaption>
      <span>Temporary task</span>
      <strong>Sheet</strong>
      <p>현재 화면 위에서 필터처럼 짧게 끝나는 작업을 처리할 때 씁니다.</p>
    </figcaption>
  </figure>
</div>

## 가장 짧은 판단법

<div class="decision-strip">
  <div>
    <span>1</span>
    <strong>앱의 큰 방인가?</strong>
    <p>그렇다면 Tab Bar</p>
  </div>
  <div>
    <span>2</span>
    <strong>안으로 들어가는가?</strong>
    <p>그렇다면 NavigationStack</p>
  </div>
  <div>
    <span>3</span>
    <strong>잠깐 끝나는 작업인가?</strong>
    <p>그렇다면 Sheet</p>
  </div>
</div>

---

## 각 컴포넌트 설명

### Tab Bar

**무엇인가**

앱의 최상위 영역을 전환하는 하단 탭입니다.

**언제 쓰나**

- 앱 안에 서로 다른 큰 목적지가 3~5개 정도 있을 때
- 사용자가 자주 오가는 영역일 때
- 각 탭이 독립적인 시작점처럼 느껴질 때

**좋은 예**

```text
Learn | Compare | Lab | Checklist
```

**나쁜 예**

```text
Home | Write | Filter | Sort | Settings
```

`Write`, `Filter`, `Sort`는 보통 최상위 목적지라기보다 현재 화면에서 수행하는 작업입니다. 이런 항목을 탭으로 넣으면 Tab Bar가 앱 구조가 아니라 버튼 모음처럼 보입니다.

### NavigationStack

**무엇인가**

한 영역 안에서 목록 → 상세 → 더 깊은 화면으로 들어가는 구조입니다.

**언제 쓰나**

- 리스트에서 항목을 누르면 상세로 들어갈 때
- 사용자가 “뒤로” 돌아가는 흐름을 기대할 때
- 같은 탭 안에서 정보의 깊이가 생길 때

**좋은 예**

```text
Learn 탭
└─ 글 목록
   └─ 글 상세
      └─ 예시 상세
```

**나쁜 예**

상세 화면을 전부 Sheet로 띄우고, 그 Sheet 안에서 또 다른 Sheet를 띄우는 구조입니다. 사용자가 지금 “들어간 것”인지 “잠깐 열린 것”인지 헷갈립니다.

### Sheet

**무엇인가**

현재 화면 위에 잠깐 올라오는 작업 표면입니다.

**언제 쓰나**

- 필터 선택
- 짧은 항목 추가
- 공유 전 옵션 선택
- 권한 요청 전 설명
- 현재 화면과 관련된 보조 작업

**좋은 예**

```text
Checklist 화면 위에 Filter Sheet 표시
```

**나쁜 예**

회원가입, 긴 온보딩, 여러 단계 설정을 전부 Sheet 안에 넣는 것입니다. 작업이 길어지면 독립 화면이나 NavigationStack 흐름이 더 명확합니다.

---

## Bad / Good 빠른 비교

<div class="compare-section">
  <div class="bad-panel">
    <span class="panel-label">Bad</span>
    <h3>기능을 전부 탭에 넣음</h3>
    <p>탭이 앱의 큰 영역이 아니라 액션 버튼 모음이 됩니다.</p>
  </div>
  <div class="good-panel">
    <span class="panel-label">Good</span>
    <h3>큰 영역만 탭으로 둠</h3>
    <p>짧은 작업은 toolbar나 sheet로 분리합니다.</p>
  </div>
</div>

<div class="compare-section">
  <div class="bad-panel">
    <span class="panel-label">Bad</span>
    <h3>상세 화면을 sheet로 계속 띄움</h3>
    <p>닫기와 뒤로가기 의미가 섞입니다.</p>
  </div>
  <div class="good-panel">
    <span class="panel-label">Good</span>
    <h3>목록 → 상세는 NavigationStack</h3>
    <p>사용자가 들어가고 돌아오는 흐름을 예측할 수 있습니다.</p>
  </div>
</div>

<div class="compare-section">
  <div class="bad-panel">
    <span class="panel-label">Bad</span>
    <h3>긴 설정을 sheet에 가둠</h3>
    <p>작업 범위와 완료/취소 의미가 불명확합니다.</p>
  </div>
  <div class="good-panel">
    <span class="panel-label">Good</span>
    <h3>짧은 작업만 sheet로 둠</h3>
    <p>필터, 짧은 입력, 옵션 선택처럼 현재 맥락과 가까운 작업에 씁니다.</p>
  </div>
</div>

---

## SwiftUI로 보면

```swift
TabView {
    NavigationStack {
        LearnListView()
    }
    .tabItem { Label("Learn", systemImage: "book") }

    NavigationStack {
        ChecklistView()
    }
    .tabItem { Label("Checklist", systemImage: "checklist") }
}
```

```swift
Button("필터") {
    isFilterPresented = true
}
.sheet(isPresented: $isFilterPresented) {
    FilterSheet()
}
```

---

## 공식 근거

<div class="evidence-grid compact-evidence">
  <a class="evidence-card" href="https://developer.apple.com/design/human-interface-guidelines/navigation-and-search">
    <span>Apple HIG</span>
    <strong>Navigation and search</strong>
    <p>사용자가 앱 안에서 현재 위치를 이해하고 원하는 콘텐츠로 이동할 수 있게 해야 합니다.</p>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/design/human-interface-guidelines/tab-bars">
    <span>Apple HIG</span>
    <strong>Tab bars</strong>
    <p>탭 바는 앱의 최상위 섹션 사이를 전환하는 컴포넌트입니다.</p>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/design/human-interface-guidelines/sheets">
    <span>Apple HIG</span>
    <strong>Sheets</strong>
    <p>시트는 현재 맥락과 관련된 별도 작업이나 선택을 수행하게 하는 임시 표면입니다.</p>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/documentation/swiftui/navigationstack">
    <span>SwiftUI</span>
    <strong>NavigationStack</strong>
    <p>SwiftUI에서 화면 깊이와 내비게이션 경로를 구성합니다.</p>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/documentation/swiftui/tabview">
    <span>SwiftUI</span>
    <strong>TabView</strong>
    <p>SwiftUI에서 탭 기반 인터페이스를 구성합니다.</p>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/documentation/swiftui/view/sheet%28ispresented%3Aondismiss%3Acontent%3A%29">
    <span>SwiftUI</span>
    <strong>sheet</strong>
    <p>현재 뷰 위에 모달 시트를 표시합니다.</p>
  </a>
</div>

---

## 체크리스트

- [ ] 이 화면이 앱의 최상위 목적지인지 먼저 물었다.
- [ ] 최상위 목적지만 Tab Bar에 넣었다.
- [ ] 목록 → 상세 흐름은 NavigationStack으로 처리했다.
- [ ] 짧고 현재 맥락과 가까운 작업만 Sheet로 띄웠다.
- [ ] 뒤로가기와 닫기 버튼의 의미가 섞이지 않는다.
- [ ] Tab Bar를 기능 버튼 모음처럼 쓰지 않았다.

---

## 다음 글

다음에는 **Form / Keyboard / Validation**을 다룹니다. 키보드가 버튼을 가리는 문제, 입력 오류 표시, 저장/취소 흐름을 iOS 기준으로 정리합니다.
