# Navigation Bar / Title / Toolbar

> NavigationStack이 “어디로 이동하는가”를 다룬다면, Navigation Bar는 사용자가 **지금 어디에 있고 무엇을 할 수 있는지**를 알려줍니다.

<div class="compact-summary">
  <strong>가장 짧은 결론</strong>
  <span>큰 제목은 현재 영역을 알려주고, inline title은 들어간 화면의 위치를 고정하며, toolbar는 화면 전체에 필요한 액션만 남깁니다.</span>
</div>

## 먼저 실제 앱 화면으로 보기

<div class="real-screenshot-grid">
  <figure class="real-screenshot-card">
    <a class="screenshot-link" href="../screenshots/ios26/nav-title-large.png" target="_blank" rel="noreferrer" aria-label="원본 스크린샷 열기">
    <img src="/screenshots/ios26/nav-title-large.png" alt="큰 Navigation Title과 우측 toolbar 버튼이 보이는 ivibe 앱 화면" />
    </a>
    <figcaption>
      <span>Large title</span>
      <strong>현재 영역 인식</strong>
      <p>최상위 화면에서는 큰 제목이 사용자의 현재 위치를 빠르게 알려줍니다.</p>
    </figcaption>
  </figure>

  <figure class="real-screenshot-card">
    <a class="screenshot-link" href="../screenshots/ios26/nav-inline-back.png" target="_blank" rel="noreferrer" aria-label="원본 스크린샷 열기">
    <img src="/screenshots/ios26/nav-inline-back.png" alt="inline title, 시스템 back button, 공유 toolbar 버튼이 보이는 ivibe 상세 화면" />
    </a>
    <figcaption>
      <span>Inline title</span>
      <strong>들어간 화면</strong>
      <p>상세 화면은 짧은 제목과 back button으로 이전 위치를 예측할 수 있게 합니다.</p>
    </figcaption>
  </figure>

  <figure class="real-screenshot-card">
    <a class="screenshot-link" href="../screenshots/ios26/nav-toolbar-actions.png" target="_blank" rel="noreferrer" aria-label="원본 스크린샷 열기">
    <img src="/screenshots/ios26/nav-toolbar-actions.png" alt="취소, 저장, 더보기 toolbar 액션이 있는 ivibe 앱 화면" />
    </a>
    <figcaption>
      <span>Toolbar</span>
      <strong>화면 액션</strong>
      <p>저장/취소/더보기처럼 화면 전체에 필요한 작업만 toolbar에 둡니다.</p>
    </figcaption>
  </figure>
</div>

## 한눈에 보기

<div class="decision-strip">
  <div>
    <span>1</span>
    <strong>현재 영역을 알려야 하는가?</strong>
    <p>최상위 화면은 large title</p>
  </div>
  <div>
    <span>2</span>
    <strong>한 단계 들어간 화면인가?</strong>
    <p>상세 화면은 inline title + Back</p>
  </div>
  <div>
    <span>3</span>
    <strong>화면 전체 액션인가?</strong>
    <p>그때만 toolbar에 배치</p>
  </div>
</div>

## 컴포넌트로 이해하기

### Navigation Bar

**무엇인가**

화면 상단에서 현재 위치, 뒤로가기, 주요 액션을 담는 iOS의 기본 영역입니다.

**언제 중요해지나**

- 화면이 여러 단계로 깊어질 때
- 사용자가 “지금 어디인지” 알아야 할 때
- 저장, 취소, 공유, 필터처럼 화면 단위 액션이 있을 때

Navigation Bar는 단순한 장식 헤더가 아닙니다. 제목, back button, toolbar item이 모두 사용자의 길찾기와 작업 완료를 돕는 신호입니다.

### Large title

**무엇인가**

최상위 화면에서 크게 보이는 navigation title입니다.

**언제 쓰나**

- 탭의 첫 화면
- 목록/설정/라이브러리처럼 사용자가 자주 돌아오는 시작점
- 화면 자체의 목적을 먼저 인식해야 할 때

**나쁜 예**

```text
모든 화면에 큰 제목을 계속 유지
상세 화면 상단에 제목과 본문 제목을 중복 표시
```

큰 제목은 강한 위치 신호라서, 상세 화면까지 계속 쓰면 위계가 무거워집니다.

### Inline title + Back button

**무엇인가**

상세 화면에서 상단 중앙에 짧게 고정되는 제목과, 이전 화면으로 돌아가는 시스템 back button입니다.

**언제 쓰나**

- 목록에서 상세로 들어간 화면
- 사용자가 이전 화면으로 돌아갈 가능성이 높은 화면
- 제목은 필요하지만 본문 공간을 더 많이 써야 하는 화면

Back button을 커스텀 닫기 버튼으로 바꾸면 사용자는 “이 화면이 들어온 화면인지, 잠깐 열린 화면인지” 헷갈릴 수 있습니다. Push로 들어온 화면은 기본 back 흐름을 우선합니다.

### Toolbar

**무엇인가**

Navigation Bar 안이나 화면 하단에 배치되는 작업 버튼 영역입니다. SwiftUI에서는 `toolbar` modifier로 구성합니다.

**언제 쓰나**

- 저장 / 완료 / 취소처럼 작업을 끝내는 액션
- 공유 / 필터 / 편집처럼 현재 화면 전체에 적용되는 액션
- 자주 쓰지만 본문 콘텐츠는 아닌 액션

**주의점**

Toolbar를 버튼 창고처럼 쓰면 안 됩니다. 한 화면에 필요한 액션을 모두 상단에 올리면 제목과 위치 신호가 약해지고, 사용자는 무엇이 주요 행동인지 알기 어렵습니다.

## Bad / Good 빠른 비교

<div class="compare-section">
  <div class="bad-panel">
    <span class="panel-label">Bad</span>
    <h3>커스텀 헤더로 제목을 직접 그림</h3>
    <p>시스템 back gesture, title collapse, toolbar 배치가 어긋나기 쉽습니다.</p>
  </div>
  <div class="good-panel">
    <span class="panel-label">Good</span>
    <h3>NavigationStack + navigationTitle 사용</h3>
    <p>iOS가 기대하는 제목, 뒤로가기, safe area 동작을 기본으로 얻습니다.</p>
  </div>
</div>

<div class="compare-section">
  <div class="bad-panel">
    <span class="panel-label">Bad</span>
    <h3>상세 화면도 계속 large title</h3>
    <p>화면 깊이가 커졌는데도 최상위 화면처럼 보여 위계가 흐려집니다.</p>
  </div>
  <div class="good-panel">
    <span class="panel-label">Good</span>
    <h3>상세는 inline title</h3>
    <p>현재 화면 이름은 유지하면서 본문과 back 흐름에 집중하게 합니다.</p>
  </div>
</div>

<div class="compare-section">
  <div class="bad-panel">
    <span class="panel-label">Bad</span>
    <h3>모든 버튼을 toolbar에 올림</h3>
    <p>필터, 정렬, 저장, 삭제, 공유가 한 줄에 몰리면 우선순위가 사라집니다.</p>
  </div>
  <div class="good-panel">
    <span class="panel-label">Good</span>
    <h3>주요 액션만 남김</h3>
    <p>저장/취소처럼 결정 버튼은 분명히, 나머지는 메뉴나 본문 액션으로 나눕니다.</p>
  </div>
</div>

## SwiftUI / iOS SDK 힌트

```swift
NavigationStack {
    List {
        NavigationLink("상세 화면") {
            DetailView()
        }
    }
    .navigationTitle("Titles")
    .navigationBarTitleDisplayMode(.large)
    .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
            Button("필터", systemImage: "line.3.horizontal.decrease.circle") {}
        }
    }
}
```

상세 화면은 보통 inline title을 씁니다.

```swift
struct DetailView: View {
    var body: some View {
        List {
            Text("상세 내용")
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("공유", systemImage: "square.and.arrow.up") {}
            }
        }
    }
}
```

저장/취소처럼 작업을 끝내는 버튼은 placement를 분리하면 의미가 선명해집니다.

```swift
.toolbar {
    ToolbarItem(placement: .cancellationAction) {
        Button("취소") {}
    }
    ToolbarItem(placement: .confirmationAction) {
        Button("저장") {}
    }
}
```

## 공식 근거

<div class="evidence-grid">
  <a class="evidence-card" href="https://developer.apple.com/design/human-interface-guidelines/navigation-bars" target="_blank" rel="noreferrer">
    <strong>Apple HIG — Navigation bars</strong>
    <span>Navigation bar는 앱의 계층 안에서 현재 위치와 작업을 제공하는 상단 영역입니다.</span>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/design/human-interface-guidelines/navigation-and-search" target="_blank" rel="noreferrer">
    <strong>Apple HIG — Navigation and search</strong>
    <span>사용자가 현재 위치를 이해하고 원하는 콘텐츠로 이동할 수 있어야 합니다.</span>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/documentation/swiftui/view/navigationtitle(_:)" target="_blank" rel="noreferrer">
    <strong>SwiftUI — navigationTitle</strong>
    <span>SwiftUI에서 현재 view의 navigation title을 지정합니다.</span>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/documentation/swiftui/view/navigationbartitledisplaymode(_:)" target="_blank" rel="noreferrer">
    <strong>SwiftUI — navigationBarTitleDisplayMode</strong>
    <span>large / inline 같은 title 표시 방식을 지정합니다.</span>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/documentation/swiftui/view/toolbar(content:)" target="_blank" rel="noreferrer">
    <strong>SwiftUI — toolbar</strong>
    <span>Navigation bar나 keyboard 주변에 작업 버튼을 배치합니다.</span>
  </a>
</div>

### 근거 수준

- **직접 근거**: Apple HIG Navigation bars, Navigation and search, SwiftUI `navigationTitle`, `navigationBarTitleDisplayMode`, `toolbar` 문서
- **ivibe 해석**: 최상위는 large title, 상세는 inline title + back, 화면 전체 액션만 toolbar에 남기는 운영 기준

## 확인할 것

- [ ] 최상위 화면은 사용자가 위치를 바로 알 수 있는 제목을 가진다.
- [ ] 상세 화면은 필요 이상으로 큰 제목을 반복하지 않는다.
- [ ] Push로 들어간 화면은 시스템 back 흐름을 우선한다.
- [ ] 닫기 버튼과 back button의 의미를 섞지 않는다.
- [ ] Toolbar에는 화면 전체에 적용되는 주요 액션만 둔다.
- [ ] 저장/취소/완료처럼 작업을 끝내는 액션은 placement 의미를 구분한다.
- [ ] 제목, toolbar, 본문 제목이 같은 말을 중복하지 않는다.

## 다음 글

다음은 `Loading / Empty / Error State`입니다. 기다림, 빈 화면, 실패 후 복구를 실제 iOS 화면으로 나눠 보여줍니다.
