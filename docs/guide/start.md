# iOS 앱은 웹사이트가 아니다

> 첫 번째 원칙: iOS 앱은 “작은 웹사이트”가 아니라, iPhone 시스템 안에서 예측 가능하게 움직이는 제품입니다.

<div class="article-summary-card">
  <p><strong>이 글의 목표</strong></p>
  <p>AI/vibe coding으로 빠르게 만든 앱에서 자주 나오는 “웹페이지 같은 iOS 앱” 문제를 iOS 공식 문서 기준으로 분해합니다. 모든 주장은 <strong>공식 문서 근거</strong>와 <strong>ivibe 해석</strong>을 구분합니다.</p>
</div>


## 기본 iOS UI를 먼저 눈으로 보기

첫 문서는 원칙을 읽기 전에, iOS 앱을 이루는 기본 표면을 먼저 눈으로 확인하는 곳입니다. 아래 화면들은 각 상세 글에서 다루는 핵심 UI입니다.

<div class="real-screenshot-grid">
  <figure class="real-screenshot-card">
    <img src="/screenshots/ios26/navigation-normal.png" alt="Tab Bar와 NavigationStack으로 구성된 iOS 앱 구조 화면">
    <figcaption>
      <span>Structure</span>
      <strong>Tab Bar / NavigationStack / Sheet</strong>
      <p>최상위 섹션, 상세 이동, 짧은 작업 표면을 서로 섞지 않습니다.</p>
      <p><a href="./navigation-structure">구조 가이드 보기 →</a></p>
    </figcaption>
  </figure>
  <figure class="real-screenshot-card">
    <img src="/screenshots/ios26/nav-title-large.png" alt="Large Title이 적용된 iOS Navigation Bar 화면">
    <figcaption>
      <span>Navigation UI</span>
      <strong>Navigation Bar / Title / Toolbar</strong>
      <p>현재 위치, 뒤로가기, 주요 행동을 시스템 내비게이션 영역에 배치합니다.</p>
      <p><a href="./navigation-bars-titles">내비게이션 UI 보기 →</a></p>
    </figcaption>
  </figure>
  <figure class="real-screenshot-card">
    <img src="/screenshots/ios26/formOverview.png" alt="라벨과 도움말이 있는 iOS Form 입력 화면">
    <figcaption>
      <span>Input</span>
      <strong>Form / Keyboard / Validation</strong>
      <p>입력 목적, 키보드 타입, 오류 복구를 필드 가까이에 둡니다.</p>
      <p><a href="./forms-keyboard-validation">입력 가이드 보기 →</a></p>
    </figcaption>
  </figure>
  <figure class="real-screenshot-card">
    <img src="/screenshots/ios26/privacyPrePrompt.png" alt="권한 요청 전 이유를 설명하는 iOS Privacy 화면">
    <figcaption>
      <span>Privacy</span>
      <strong>Permission / Privacy</strong>
      <p>권한은 앱 시작 즉시가 아니라 기능 맥락 안에서 이유를 설명한 뒤 요청합니다.</p>
      <p><a href="./permissions-privacy">권한 가이드 보기 →</a></p>
    </figcaption>
  </figure>
  <figure class="real-screenshot-card">
    <img src="/screenshots/ios26/feedback-empty.png" alt="ContentUnavailableView로 구성된 iOS Empty State 화면">
    <figcaption>
      <span>Feedback</span>
      <strong>Loading / Empty / Error State</strong>
      <p>성공 화면뿐 아니라 대기, 빈 상태, 실패 후 다음 행동까지 설계합니다.</p>
      <p><a href="./loading-empty-error">상태 가이드 보기 →</a></p>
    </figcaption>
  </figure>
  <figure class="real-screenshot-card">
    <img src="/screenshots/ios26/accessibility-dynamic-type.png" alt="Dynamic Type을 고려한 iOS Accessibility 화면">
    <figcaption>
      <span>Accessibility</span>
      <strong>Dynamic Type / VoiceOver / Touch Target</strong>
      <p>글자 크기, 읽기 순서, 최소 터치 영역을 기본 품질로 봅니다.</p>
      <p><a href="./accessibility-basics">접근성 가이드 보기 →</a></p>
    </figcaption>
  </figure>
</div>

---

## 근거 수준

ivibe는 좋은 예/나쁜 예를 만들 때 다음 순서로 판단합니다.

1. **Apple 공식 문서/SDK 문서에 직접 근거가 있는가?**
2. **직접 문장은 없어도 HIG가 설명하는 목적과 역할에 맞는가?**
3. **실제 iOS 앱에서 사용자가 기대하는 기본 행동과 충돌하지 않는가?**
4. **단순 취향인가, 사용성/접근성/시스템 일관성 문제인가?**

단순히 “iOS스러워 보인다”는 이유만으로 좋은 예로 분류하지 않습니다.

---

## 공식 문서에서 출발하기

<div class="evidence-grid">
  <a class="evidence-card" href="https://developer.apple.com/design/human-interface-guidelines/designing-for-ios">
    <span>Apple HIG</span>
    <strong>Designing for iOS</strong>
    <p>iPhone은 이동 중, 다양한 맥락에서 개인적이고 즉각적인 작업을 돕는 기기라는 전제에서 설계해야 합니다.</p>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/design/human-interface-guidelines/navigation-and-search">
    <span>Apple HIG</span>
    <strong>Navigation and search</strong>
    <p>사람들이 앱 안에서 현재 위치를 이해하고 원하는 콘텐츠를 찾고 이동할 수 있게 해야 합니다.</p>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/design/human-interface-guidelines/tab-bars">
    <span>Apple HIG</span>
    <strong>Tab bars</strong>
    <p>탭 바는 앱의 최상위 섹션 사이를 이동하게 하는 컴포넌트입니다.</p>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/design/human-interface-guidelines/sheets">
    <span>Apple HIG</span>
    <strong>Sheets</strong>
    <p>시트는 현재 맥락과 밀접한 제한된 작업을 수행하게 하는 별도 표면입니다.</p>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/design/human-interface-guidelines/entering-data">
    <span>Apple HIG</span>
    <strong>Entering data</strong>
    <p>사람들이 실수 없이 쉽게 정보를 입력할 수 있게 설계해야 합니다.</p>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/design/human-interface-guidelines/privacy">
    <span>Apple HIG</span>
    <strong>Privacy</strong>
    <p>필요한 데이터와 리소스에 대해 투명해야 하며, 사용자가 허용한 데이터를 보호해야 합니다.</p>
  </a>
</div>

---

## 핵심 판단

웹에서는 한 페이지 안에 섹션을 계속 쌓고, 버튼으로 여기저기 이동시키는 방식이 자연스러울 수 있습니다. 하지만 iOS 앱에서는 사용자가 보통 다음을 기대합니다.

- 내가 앱의 어느 위치에 있는지 알 수 있음
- 뒤로가기가 예측 가능함
- 최상위 기능은 Tab Bar나 명확한 홈 구조에 있음
- 잠깐 처리하는 작업은 Sheet나 Alert로 범위가 제한됨
- 키보드, 권한, 알림, 공유, 설정이 시스템 규칙과 충돌하지 않음
- 터치 영역, 글자 크기, 다크모드, VoiceOver가 기본적으로 고려됨

따라서 ivibe에서 말하는 “iOS답다”는 뜻은 시각 스타일만 의미하지 않습니다.

<div class="principle-card">
  <strong>ivibe 원칙</strong>
  <p>iOS답다는 것은 Apple처럼 예쁘게 꾸미는 것이 아니라, iOS 사용자가 이미 배운 시스템 행동을 깨지 않는 것입니다.</p>
</div>

---

## Bad / Good 1 — 화면 이동을 웹 링크처럼 다루기

<div class="bad-good-grid">
  <div class="bad-panel">
    <p class="panel-label">나쁜 예</p>
    <h3>모든 화면을 임의 버튼 링크로 이동</h3>
    <ul>
      <li>상세 화면에서 뒤로갈 길이 명확하지 않다.</li>
      <li>탭, 상세, 편집, 설정의 계층이 섞인다.</li>
      <li>모달이 필요한 작업과 push가 필요한 이동을 구분하지 않는다.</li>
    </ul>
  </div>
  <div class="good-panel">
    <p class="panel-label">좋은 예</p>
    <h3>최상위·상세·임시 작업을 구분</h3>
    <ul>
      <li>최상위 영역은 Tab Bar나 명확한 홈 구조로 둔다.</li>
      <li>목록에서 상세로 들어가는 흐름은 NavigationStack으로 표현한다.</li>
      <li>현재 맥락과 관련된 짧은 작업은 Sheet로 분리한다.</li>
    </ul>
  </div>
</div>

### 근거

- Apple HIG의 **Tab bars**는 탭 바를 “앱의 최상위 섹션 사이 이동”으로 설명합니다.
- Apple HIG의 **Sheets**는 시트를 “현재 맥락과 밀접한 scoped task”로 설명합니다.
- SwiftUI의 **NavigationStack** 문서는 루트 뷰 위로 추가 뷰를 표시하는 내비게이션 구조를 제공합니다.

### ivibe 해석

탭, push, sheet는 단순한 모양 차이가 아니라 **정보 구조의 약속**입니다. AI가 만든 앱에서 화면 전환이 모두 버튼 링크처럼 처리되면, 사용자는 앱의 구조를 배울 수 없습니다.

---

## Bad / Good 2 — 입력 화면을 웹 폼처럼 만들기

<div class="bad-good-grid">
  <div class="bad-panel">
    <p class="panel-label">나쁜 예</p>
    <h3>placeholder만 있는 입력창</h3>
    <ul>
      <li>입력 후 필드 의미가 사라진다.</li>
      <li>오류가 화면 상단에만 있어 어느 필드 문제인지 찾기 어렵다.</li>
      <li>키보드가 CTA를 가린다.</li>
    </ul>
  </div>
  <div class="good-panel">
    <p class="panel-label">좋은 예</p>
    <h3>라벨, 도움말, 오류를 필드 가까이에 배치</h3>
    <ul>
      <li>필드 목적을 항상 볼 수 있게 한다.</li>
      <li>오류는 해당 필드 바로 아래에 표시한다.</li>
      <li>키보드가 올라와도 다음 행동이 유지되게 한다.</li>
    </ul>
  </div>
</div>

### 근거

- Apple HIG의 **Entering data**는 사람들이 실수 없이 쉽게 정보를 제공할 수 있게 설계하라고 설명합니다.
- Apple HIG의 **Inputs**는 사람들이 앱을 제어하고 데이터를 입력하는 다양한 방법을 고려해야 한다는 출발점을 제공합니다.

### ivibe 해석

공식 문서가 “placeholder-only label 금지” 같은 모든 세부 패턴을 한 문장으로 강제하지 않더라도, 입력 목적이 사라지고 오류 복구가 어려워지는 UI는 “실수 없이 쉽게 입력”한다는 목표와 충돌합니다.

---

## Bad / Good 3 — 권한을 앱 시작 즉시 요청하기

<div class="bad-good-grid">
  <div class="bad-panel">
    <p class="panel-label">나쁜 예</p>
    <h3>첫 실행 직후 알림·위치·사진 권한 요청</h3>
    <ul>
      <li>사용자는 아직 기능 가치를 모른다.</li>
      <li>거부 후 대체 경로나 설정 안내가 없다.</li>
      <li>앱이 데이터를 먼저 요구하는 느낌을 준다.</li>
    </ul>
  </div>
  <div class="good-panel">
    <p class="panel-label">좋은 예</p>
    <h3>필요한 순간에 이유를 먼저 설명</h3>
    <ul>
      <li>기능 맥락 안에서 권한이 왜 필요한지 보여준다.</li>
      <li>시스템 권한 다이얼로그는 사용자가 행동을 선택한 뒤 표시한다.</li>
      <li>거부 상태에서도 설정 이동이나 제한 모드를 제공한다.</li>
    </ul>
  </div>
</div>

### 근거

- Apple HIG의 **Privacy**는 필요한 데이터와 리소스에 대해 투명해야 하며 사용자가 허용한 데이터를 보호해야 한다고 설명합니다.
- iOS의 권한 요청은 시스템 다이얼로그로 처리되며, 앱은 사용자가 왜 허용해야 하는지 이해할 수 있는 맥락을 제공해야 합니다.

### ivibe 해석

권한 요청의 “타이밍”은 신뢰 문제입니다. 첫 실행 즉시 권한을 요청하는 방식은 사용자가 아직 앱의 가치를 확인하기 전이므로, 투명성과 맥락 제공이라는 Privacy 원칙에 약합니다.

---

## Bad / Good 4 — 로딩·빈 상태·오류 상태를 나중에 처리하기

<div class="bad-good-grid">
  <div class="bad-panel">
    <p class="panel-label">나쁜 예</p>
    <h3>성공 화면만 디자인</h3>
    <ul>
      <li>데이터가 없으면 빈 흰 화면만 보인다.</li>
      <li>로딩 중인지 멈춘 것인지 알 수 없다.</li>
      <li>오류가 나도 다음 행동이 없다.</li>
    </ul>
  </div>
  <div class="good-panel">
    <p class="panel-label">좋은 예</p>
    <h3>상태를 제품의 일부로 설계</h3>
    <ul>
      <li>빈 상태에는 설명과 첫 행동 CTA를 둔다.</li>
      <li>로딩은 위치를 예약하고 진행 중임을 표시한다.</li>
      <li>오류에는 원인과 복구 행동을 함께 제공한다.</li>
    </ul>
  </div>
</div>

### 근거

- Apple HIG의 **Alerts**는 사용자가 즉시 알아야 하는 중요한 정보를 제공하는 역할을 설명합니다.
- Apple HIG의 전반적 원칙은 사용자가 작업을 이해하고 완료할 수 있게 하는 명확한 피드백을 요구합니다.

### ivibe 해석

성공 상태만 있는 앱은 실제 제품이 아니라 데모에 가깝습니다. iOS 앱은 네트워크, 권한, 빈 데이터, 실패가 모두 시스템 경험 안에서 자연스럽게 처리되어야 합니다.

---

## SwiftUI로 옮길 때의 기본 구조

```swift
struct IvibeExampleApp: View {
    var body: some View {
        TabView {
            NavigationStack {
                LessonListView()
            }
            .tabItem { Label("Learn", systemImage: "book") }

            NavigationStack {
                ReviewView()
            }
            .tabItem { Label("Review", systemImage: "checkmark.circle") }
        }
    }
}
```

이 코드는 완성된 앱 구조가 아니라, ivibe가 권장하는 사고방식을 보여줍니다.

- 최상위 영역은 `TabView`
- 각 탭 내부의 계층 이동은 `NavigationStack`
- 짧은 맥락 작업은 `.sheet`
- 위험하거나 즉시 알아야 하는 정보는 `.alert`
- 입력 화면은 `Form`, `TextField`, `FocusState`, `submitLabel` 등을 사용해 시스템 행동과 맞춘다

---

## 확인할 것

### Structure

- [ ] 최상위 기능과 상세 흐름이 구분되어 있는가?
- [ ] Tab Bar는 앱의 최상위 섹션에만 쓰는가?
- [ ] 뒤로가기가 예측 가능한가?
- [ ] Sheet는 현재 맥락과 밀접한 짧은 작업에만 쓰는가?

### Input

- [ ] 입력 필드의 의미가 입력 후에도 남아 있는가?
- [ ] 오류는 해당 필드 가까이에 표시되는가?
- [ ] 키보드가 주요 CTA를 가리지 않는가?
- [ ] 입력 타입, 자동완성, 제출 키가 맥락에 맞는가?

### System

- [ ] 권한 요청 전에 이유와 가치를 설명하는가?
- [ ] 권한 거부 후에도 회복 경로가 있는가?
- [ ] 로딩, 빈 상태, 오류 상태를 성공 상태만큼 설계했는가?

### Accessibility

- [ ] 주요 터치 영역은 최소 44pt 수준인가?
- [ ] Dynamic Type에서 텍스트가 잘리지 않는가?
- [ ] 아이콘-only 버튼에는 접근성 라벨이 있는가?
- [ ] 색상만으로 의미를 전달하지 않는가?

---

## 다음 글

다음 글에서는 **NavigationStack / Tab Bar / Sheet를 언제 구분해야 하는지**를 Bad/Good 예시로 다룹니다.
