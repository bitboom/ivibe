# Loading / Empty / Error State

> 앱은 성공 화면만으로 완성되지 않습니다. 사용자가 기다릴 때, 아직 볼 것이 없을 때, 실패했을 때도 iOS답게 안내해야 합니다.

<div class="compact-summary">
  <strong>가장 짧은 결론</strong>
  <span>Loading은 진행 중임을, Empty는 비어 있는 이유와 첫 행동을, Error는 복구 행동을 보여줘야 합니다.</span>
</div>

## 먼저 실제 앱 화면으로 보기

<div class="real-screenshot-grid">
  <figure class="real-screenshot-card">
    <img src="/screenshots/ios26/feedback-loading.png" alt="ProgressView와 대기 설명이 보이는 ivibe Loading 상태 화면" />
    <figcaption>
      <span>Loading</span>
      <strong>기다림을 설명</strong>
      <p>작업 중임을 즉시 보여주고, 가능하면 무엇을 불러오는지 말합니다.</p>
    </figcaption>
  </figure>

  <figure class="real-screenshot-card">
    <img src="/screenshots/ios26/feedback-empty.png" alt="ContentUnavailableView와 첫 행동 버튼이 보이는 ivibe Empty 상태 화면" />
    <figcaption>
      <span>Empty</span>
      <strong>빈 이유와 첫 행동</strong>
      <p>빈 화면을 방치하지 않고 사용자가 다음에 할 일을 제안합니다.</p>
    </figcaption>
  </figure>

  <figure class="real-screenshot-card">
    <img src="/screenshots/ios26/feedback-error.png" alt="오류 설명과 다시 시도 버튼이 보이는 ivibe Error 상태 화면" />
    <figcaption>
      <span>Error</span>
      <strong>복구 가능한 실패</strong>
      <p>문제 원인을 짧게 말하고 다시 시도 같은 복구 행동을 제공합니다.</p>
    </figcaption>
  </figure>
</div>

## 한눈에 보기

<div class="decision-strip">
  <div>
    <span>1</span>
    <strong>아직 결과를 기다리는 중인가?</strong>
    <p>Loading</p>
  </div>
  <div>
    <span>2</span>
    <strong>성공했지만 보여줄 항목이 없는가?</strong>
    <p>Empty</p>
  </div>
  <div>
    <span>3</span>
    <strong>작업이 실패했고 복구가 필요한가?</strong>
    <p>Error</p>
  </div>
</div>

## 컴포넌트로 이해하기

### Loading

**무엇인가**

데이터를 불러오거나 작업을 처리하는 중이라는 상태입니다. SwiftUI에서는 보통 `ProgressView`로 표현합니다.

**언제 쓰나**

- 네트워크 요청 중
- 저장/업로드/동기화 중
- 다음 화면에 필요한 데이터가 아직 준비되지 않았을 때

**주의점**

무한 spinner만 두면 사용자는 앱이 멈춘 것인지, 실패한 것인지 알 수 없습니다. 짧은 작업은 간단한 progress indicator로 충분하지만, 길어질 수 있는 작업은 무엇을 기다리는지 설명해야 합니다.

### Empty

**무엇인가**

요청은 성공했지만 아직 표시할 콘텐츠가 없는 상태입니다. SwiftUI에서는 `ContentUnavailableView`가 빈 상태 안내에 적합합니다.

**언제 쓰나**

- 처음 앱을 열었고 아직 항목이 없을 때
- 검색 결과가 없을 때
- 필터를 적용했더니 표시할 콘텐츠가 없을 때

**주의점**

Empty는 Error가 아닙니다. 빈 상태를 오류처럼 겁주거나, 반대로 아무 설명 없이 빈 흰 화면만 남기면 사용자는 다음 행동을 알 수 없습니다.

### Error

**무엇인가**

작업이 실패했고 사용자가 복구하거나 이해해야 하는 상태입니다.

**언제 쓰나**

- 네트워크 요청 실패
- 권한/설정 문제
- 저장 실패
- 사용자가 다시 시도하거나 선택을 바꿀 수 있는 상황

**주의점**

`NSError`, `timeout`, `500` 같은 개발자식 메시지를 그대로 노출하지 않는 것이 좋습니다. 사용자가 이해할 수 있는 말로 설명하고, 다시 시도/설정 열기/문제 신고 같은 행동을 제공합니다.

## Bad / Good 빠른 비교

<div class="compare-section">
  <div class="bad-panel">
    <span class="panel-label">Bad</span>
    <h3>빈 화면만 보여줌</h3>
    <p>사용자는 로딩 중인지, 데이터가 없는지, 실패했는지 구분할 수 없습니다.</p>
  </div>
  <div class="good-panel">
    <span class="panel-label">Good</span>
    <h3>상태를 명확히 분리</h3>
    <p>Loading, Empty, Error를 다른 문구와 행동으로 보여줍니다.</p>
  </div>
</div>

<div class="compare-section">
  <div class="bad-panel">
    <span class="panel-label">Bad</span>
    <h3>무한 spinner만 배치</h3>
    <p>오래 걸리면 사용자는 앱이 멈췄다고 느낍니다.</p>
  </div>
  <div class="good-panel">
    <span class="panel-label">Good</span>
    <h3>무엇을 기다리는지 설명</h3>
    <p>진행 중인 작업과 예상되는 다음 상태를 짧게 알려줍니다.</p>
  </div>
</div>

<div class="compare-section">
  <div class="bad-panel">
    <span class="panel-label">Bad</span>
    <h3>기술 오류를 그대로 표시</h3>
    <p>“Request failed 500” 같은 문구는 사용자가 해결할 수 없습니다.</p>
  </div>
  <div class="good-panel">
    <span class="panel-label">Good</span>
    <h3>복구 행동을 제공</h3>
    <p>다시 시도, 설정 변경, 문제 신고처럼 다음 행동을 제안합니다.</p>
  </div>
</div>

## SwiftUI / iOS SDK 힌트

상태를 하나의 enum으로 모델링하면 Loading, Empty, Error가 섞이지 않습니다.

```swift
enum GuideState {
    case loading
    case empty
    case loaded([Guide])
    case failed(message: String)
}
```

Loading은 `ProgressView`로 시작할 수 있습니다.

```swift
ProgressView("가이드를 불러오는 중")
```

Empty는 `ContentUnavailableView`로 기본 구조를 얻을 수 있습니다.

```swift
ContentUnavailableView(
    "아직 점검 항목이 없습니다",
    systemImage: "tray",
    description: Text("첫 체크리스트를 만들면 여기에서 이어갈 수 있습니다.")
)
```

Error는 설명과 복구 행동을 같이 제공합니다.

```swift
VStack(alignment: .leading) {
    Label {
        Text("가이드를 불러오지 못했습니다")
    } icon: {
        Image(systemName: "wifi.exclamationmark")
    }

    Text("연결 상태를 확인한 뒤 다시 시도해 주세요.")

    Button("다시 시도") {
        Task { await reload() }
    }
}
```

파괴적인 작업이나 사용자의 결정을 요구하는 오류는 `alert` 또는 `confirmationDialog`를 검토합니다. 단, 단순 실패 상태를 모두 alert로 띄우면 흐름을 방해할 수 있습니다.

## 공식 근거

<div class="evidence-grid">
  <a class="evidence-card" href="https://developer.apple.com/design/human-interface-guidelines/progress-indicators" target="_blank" rel="noreferrer">
    <strong>Apple HIG — Progress indicators</strong>
    <span>작업이 진행 중임을 사용자에게 알려주는 방법을 다룹니다.</span>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/design/human-interface-guidelines/alerts" target="_blank" rel="noreferrer">
    <strong>Apple HIG — Alerts</strong>
    <span>중요한 문제와 사용자의 응답이 필요한 상황을 방해하지 않게 제시하는 기준입니다.</span>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/documentation/swiftui/progressview" target="_blank" rel="noreferrer">
    <strong>SwiftUI — ProgressView</strong>
    <span>작업 진행 또는 대기 상태를 표시하는 SwiftUI view입니다.</span>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/documentation/swiftui/contentunavailableview" target="_blank" rel="noreferrer">
    <strong>SwiftUI — ContentUnavailableView</strong>
    <span>콘텐츠가 없거나 사용할 수 없는 상태를 안내하는 SwiftUI view입니다.</span>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/documentation/swiftui/alert" target="_blank" rel="noreferrer">
    <strong>SwiftUI — alert</strong>
    <span>사용자의 주의와 결정을 요구하는 상황에 alert를 표시합니다.</span>
  </a>
</div>

### 근거 수준

- **직접 근거**: Apple HIG Progress indicators, Alerts, SwiftUI `ProgressView`, `ContentUnavailableView`, `alert`
- **ivibe 해석**: 화면 상태를 Loading / Empty / Error로 분리하고, 각 상태마다 사용자에게 필요한 정보와 행동을 다르게 제공하는 운영 기준

## 체크리스트

- [ ] Loading은 사용자가 앱이 멈췄다고 느끼기 전에 표시된다.
- [ ] 긴 Loading은 무엇을 기다리는지 설명한다.
- [ ] Empty는 오류가 아니라 “성공했지만 콘텐츠가 없음”으로 다룬다.
- [ ] Empty에는 첫 행동 또는 필터 해제 같은 다음 행동이 있다.
- [ ] Error는 개발자식 코드가 아니라 사용자가 이해할 수 있는 말로 설명한다.
- [ ] Error에는 다시 시도, 설정 변경, 문제 신고 등 복구 행동이 있다.
- [ ] 파괴적이거나 되돌리기 어려운 작업은 alert/confirmation으로 한 번 더 확인한다.
- [ ] Loading, Empty, Error 상태가 하나의 enum/state model로 분리되어 있다.

## 다음 글

다음은 `Accessibility 기본`입니다. Dynamic Type, VoiceOver label, 대비, 터치 영역을 실제 iOS 화면으로 확인합니다.
