# Accessibility Basics

> 접근성은 나중에 붙이는 옵션이 아닙니다. iOS 기본 컴포넌트를 쓰는 이유 중 하나는 큰 글자, VoiceOver, 터치 영역 같은 기본 접근성 기대치를 함께 얻기 위해서입니다.

<div class="compact-summary">
  <strong>가장 짧은 결론</strong>
  <span>텍스트는 커질 수 있어야 하고, 화면은 읽힐 수 있어야 하며, 버튼은 안정적으로 눌릴 수 있어야 합니다.</span>
</div>

## 먼저 실제 앱 화면으로 보기

<div class="real-screenshot-grid three">
  <figure class="real-screenshot-card">
    <a class="screenshot-link" href="../screenshots/ios26/accessibility-dynamic-type.png" target="_blank" rel="noreferrer" aria-label="원본 스크린샷 열기">
    <img src="/screenshots/ios26/accessibility-dynamic-type.png" alt="큰 글자 설정에서 제목과 설명이 여러 줄로 자연스럽게 보이는 Dynamic Type 화면" />
    </a>
    <figcaption>
      <span>DYNAMIC TYPE</span>
      <strong>큰 글자에서도 무너지지 않기</strong>
      <p>고정 높이와 한 줄 제한을 피하고, 시스템 글꼴과 자연스러운 줄바꿈을 우선합니다.</p>
    </figcaption>
  </figure>
  <figure class="real-screenshot-card">
    <a class="screenshot-link" href="../screenshots/ios26/accessibility-voiceover.png" target="_blank" rel="noreferrer" aria-label="원본 스크린샷 열기">
    <img src="/screenshots/ios26/accessibility-voiceover.png" alt="의미 있는 접근성 라벨과 힌트를 설명하는 VoiceOver 화면" />
    </a>
    <figcaption>
      <span>VOICEOVER</span>
      <strong>보이는 모양보다 읽히는 의미</strong>
      <p>아이콘, 상태 카드, 버튼은 화면을 보지 않아도 의미와 행동을 알 수 있어야 합니다.</p>
    </figcaption>
  </figure>
  <figure class="real-screenshot-card">
    <a class="screenshot-link" href="../screenshots/ios26/accessibility-touch-target.png" target="_blank" rel="noreferrer" aria-label="원본 스크린샷 열기">
    <img src="/screenshots/ios26/accessibility-touch-target.png" alt="44pt 이상 터치 영역을 설명하는 Touch Target 화면" />
    </a>
    <figcaption>
      <span>TOUCH TARGET</span>
      <strong>안정적으로 누를 수 있는 영역</strong>
      <p>작아 보이는 아이콘 버튼도 실제 터치 가능한 영역은 충분히 커야 합니다.</p>
    </figcaption>
  </figure>
</div>

## 한눈에 보기

<div class="decision-strip">
  <div>
    <span>1</span>
    <strong>글자를 키워도 읽히는가?</strong>
    <p>Dynamic Type</p>
  </div>
  <div>
    <span>2</span>
    <strong>화면을 보지 않고도 이해되는가?</strong>
    <p>VoiceOver</p>
  </div>
  <div>
    <span>3</span>
    <strong>손가락으로 쉽게 누를 수 있는가?</strong>
    <p>Touch Target</p>
  </div>
</div>

## 화면 위에 올려서 확인할 기준

<div class="decision-strip">
  <div>
    <span>AA</span>
    <strong>Dynamic Type</strong>
    <p>텍스트가 커졌을 때 카드 높이가 늘어나고, 버튼·설명이 겹치지 않아야 합니다.</p>
  </div>
  <div>
    <span>VO</span>
    <strong>Reading order</strong>
    <p>VoiceOver 순서는 제목 → 상태 설명 → 가능한 행동 순서로 읽히는지 봅니다.</p>
  </div>
  <div>
    <span>44</span>
    <strong>Hit area</strong>
    <p>아이콘 크기가 아니라 실제 누를 수 있는 프레임과 주변 간격을 확인합니다.</p>
  </div>
</div>

이 기준은 별도 디자인 장식이 아니라 리뷰할 때 스크린샷 위에 겹쳐 보는 체크포인트입니다. 특히 AI가 만든 커스텀 카드와 아이콘 버튼은 시각적으로는 좋아 보여도 읽기 순서와 실제 터치 영역이 빠지는 경우가 많습니다.

## 컴포넌트로 이해하기

### Dynamic Type

**무엇인가**  
사용자가 시스템 설정에서 텍스트 크기를 키웠을 때 앱의 글자도 함께 커지는 iOS 접근성 기본값입니다.

**언제 확인하나**

- 카드나 리스트에 제목/설명이 많은 화면
- 폼, validation message, permission pre-prompt
- 버튼과 본문이 같은 카드 안에 있는 화면

**주의점**  
`frame(height:)`로 고정하거나 `lineLimit(1)`을 남용하면 큰 글자에서 정보가 잘립니다. iOS-native 화면은 텍스트가 커져도 구조가 깨지지 않아야 합니다.

### VoiceOver

**무엇인가**  
화면을 보지 않고도 앱의 요소를 순서대로 듣고 조작할 수 있게 하는 iOS 스크린 리더입니다.

**언제 확인하나**

- 아이콘만 있는 버튼
- 이미지가 의미를 전달하는 카드
- 상태/오류/권한 안내 화면
- 커스텀 컴포넌트

**주의점**  
`Image(systemName:)`이 보인다고 해서 VoiceOver가 올바른 의미를 읽는 것은 아닙니다. 장식 이미지는 숨기고, 조작 가능한 요소는 명확한 이름과 힌트를 가져야 합니다.

### Touch Target

**무엇인가**  
사용자가 손가락으로 실수 없이 누를 수 있는 실제 조작 영역입니다. Apple HIG는 터치 가능한 컨트롤에 충분한 hit target을 제공하라고 안내합니다.

**언제 확인하나**

- 상단 toolbar 아이콘 버튼
- 카드 안의 작은 버튼
- 리스트 row의 accessory action
- 탭/필터/segmented control

**주의점**  
시각적으로 작은 아이콘을 쓰더라도 실제 터치 영역은 충분히 커야 합니다. 아이콘만 20pt로 두고 hit target도 20pt인 버튼은 보기에는 깔끔해도 실제 사용성이 떨어집니다.

## Bad / Good 빠른 비교

<div class="bad-good-grid">
  <div class="bad-card">
    <span>BAD</span>
    <h3>고정 높이 카드</h3>
    <p>큰 글자에서 제목과 설명이 잘리거나 버튼과 겹칩니다.</p>
  </div>
  <div class="good-card">
    <span>GOOD</span>
    <h3>자연스러운 줄바꿈</h3>
    <p>시스템 text style을 쓰고, 텍스트가 여러 줄로 늘어나도 레이아웃이 유지됩니다.</p>
  </div>
  <div class="bad-card">
    <span>BAD</span>
    <h3>아이콘만 있는 버튼</h3>
    <p>VoiceOver가 “버튼” 또는 아이콘 이름만 읽어 사용자가 행동을 이해하기 어렵습니다.</p>
  </div>
  <div class="good-card">
    <span>GOOD</span>
    <h3>의미 있는 label/hint</h3>
    <p>“공유”, “필터 열기”, “설정에서 권한 켜기”처럼 행동을 읽을 수 있게 합니다.</p>
  </div>
  <div class="bad-card">
    <span>BAD</span>
    <h3>작은 hit target</h3>
    <p>아이콘 크기만큼만 눌려서 손가락으로 조작하기 어렵습니다.</p>
  </div>
  <div class="good-card">
    <span>GOOD</span>
    <h3>충분한 터치 영역</h3>
    <p>보이는 아이콘은 작아도 실제 버튼 프레임과 간격은 충분히 확보합니다.</p>
  </div>
</div>

## SwiftUI / iOS SDK 힌트

시스템 text style을 먼저 사용합니다.

```swift
Text("큰 글자에서도 화면이 무너지지 않아야 합니다")
    .font(.title2.weight(.bold))
    .fixedSize(horizontal: false, vertical: true)
```

장식 아이콘은 VoiceOver에서 숨깁니다.

```swift
Image(systemName: "sparkles")
    .accessibilityHidden(true)
```

아이콘 버튼은 보이는 아이콘이 아니라 사용자의 행동으로 이름 붙입니다.

```swift
Button {
    share()
} label: {
    Image(systemName: "square.and.arrow.up")
}
.accessibilityLabel("공유")
.accessibilityHint("현재 가이드를 공유합니다")
```

작은 아이콘 버튼도 실제 터치 영역은 충분히 확보합니다.

```swift
Button {
    like()
} label: {
    Image(systemName: "hand.thumbsup")
        .frame(minWidth: 44, minHeight: 44)
}
```

## 공식 근거

<div class="evidence-grid">
  <a class="evidence-card" href="https://developer.apple.com/design/human-interface-guidelines/accessibility" target="_blank" rel="noreferrer">
    <span>Apple HIG</span>
    <strong>Accessibility</strong>
    <p>접근성은 앱 경험의 기본 품질이며, 다양한 사용자가 앱을 이해하고 조작할 수 있게 해야 합니다.</p>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/accessibility/" target="_blank" rel="noreferrer">
    <span>Apple Accessibility</span>
    <strong>Apple Accessibility</strong>
    <p>VoiceOver, Dynamic Type 등 Apple 플랫폼 접근성 기능의 큰 방향을 제공합니다.</p>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/design/human-interface-guidelines/buttons" target="_blank" rel="noreferrer">
    <span>Apple HIG</span>
    <strong>Buttons</strong>
    <p>버튼은 역할이 분명해야 하며, 사용자가 쉽게 인식하고 조작할 수 있어야 합니다.</p>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/documentation/swiftui/view/dynamictypesize(_:)" target="_blank" rel="noreferrer">
    <span>SwiftUI</span>
    <strong>dynamicTypeSize</strong>
    <p>SwiftUI에서 Dynamic Type 크기를 다루고 테스트할 때 참고할 수 있습니다.</p>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/documentation/swiftui/view/accessibilitylabel(_:)" target="_blank" rel="noreferrer">
    <span>SwiftUI</span>
    <strong>accessibilityLabel</strong>
    <p>시각적 요소가 VoiceOver에서 어떤 이름으로 읽힐지 지정합니다.</p>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/documentation/swiftui/view/accessibilityhint(_:)" target="_blank" rel="noreferrer">
    <span>SwiftUI</span>
    <strong>accessibilityHint</strong>
    <p>컨트롤을 실행하면 어떤 일이 일어나는지 보조 설명을 제공합니다.</p>
  </a>
</div>

## 확인할 것

- [ ] Dynamic Type을 키워도 제목/설명/버튼이 잘리지 않는다.
- [ ] 중요한 텍스트에 고정 높이와 불필요한 `lineLimit(1)`을 쓰지 않는다.
- [ ] 아이콘만 있는 버튼에는 의미 있는 accessibility label이 있다.
- [ ] 장식 이미지는 VoiceOver에서 숨긴다.
- [ ] 상태 화면은 현재 상태와 다음 행동을 읽을 수 있다.
- [ ] 주요 버튼과 아이콘 버튼의 실제 터치 영역이 충분하다.
- [ ] 버튼 사이 간격이 너무 좁지 않다.

## 다음 글

다음으로는 Search / Searchable을 다룹니다. 검색 전 상태, 결과 없음, 필터와 검색의 차이를 iOS 기본 컴포넌트 기준으로 정리합니다.
