# Form / Keyboard / Validation

> 입력 화면은 “예쁘게 칸을 배치하는 일”이 아니라, 사용자가 막히지 않고 끝까지 제출할 수 있게 돕는 흐름입니다.

<div class="article-summary-card compact-summary">
  <p><strong>먼저 실제 앱 화면으로 보기</strong></p>
  <p>이 페이지의 이미지는 ivibe iOS 앱을 iOS 26 Simulator에서 실행해 캡처한 화면입니다. Form, keyboard, validation 상태를 문서용 목업이 아니라 실제 SwiftUI 화면으로 확인합니다.</p>
</div>

## 한눈에 보기

<div class="real-screenshot-grid">
  <figure class="real-screenshot-card">
    <img src="/screenshots/ios26/formOverview.png" alt="ivibe 앱 Form 입력 화면의 실제 iOS 26 스크린샷" />
    <figcaption>
      <span>Input structure</span>
      <strong>Form</strong>
      <p>관련 입력을 섹션으로 묶고, 라벨과 도움말을 가까이에 둡니다.</p>
    </figcaption>
  </figure>

  <figure class="real-screenshot-card">
    <img src="/screenshots/ios26/formKeyboard.png" alt="ivibe 앱 키보드 입력 상태의 실제 iOS 26 스크린샷" />
    <figcaption>
      <span>Input flow</span>
      <strong>Keyboard</strong>
      <p>입력 중인 필드, 키보드, 완료 액션이 서로 충돌하지 않는지 확인합니다.</p>
    </figcaption>
  </figure>

  <figure class="real-screenshot-card">
    <img src="/screenshots/ios26/formValidation.png" alt="ivibe 앱 validation 오류 상태의 실제 iOS 26 스크린샷" />
    <figcaption>
      <span>Recovery</span>
      <strong>Validation</strong>
      <p>오류는 사용자가 바로 고칠 수 있는 입력 필드 근처에 구체적으로 보여줍니다.</p>
    </figcaption>
  </figure>
</div>

## 가장 짧은 판단법

<div class="decision-strip">
  <div>
    <span>1</span>
    <strong>무엇을 입력해야 하는가?</strong>
    <p>라벨과 섹션으로 먼저 설명</p>
  </div>
  <div>
    <span>2</span>
    <strong>입력 중에 막히는가?</strong>
    <p>키보드 타입, 포커스, 완료 액션 확인</p>
  </div>
  <div>
    <span>3</span>
    <strong>오류를 고칠 수 있는가?</strong>
    <p>필드 가까이에 구체적 오류 표시</p>
  </div>
</div>

---

## 각 컴포넌트 설명

### Form

**무엇인가**

관련 입력 항목을 섹션으로 묶어 보여주는 iOS 입력 화면 구조입니다.

**언제 쓰나**

- 설정, 가입, 요청, 프로필 편집처럼 여러 값을 입력할 때
- 입력 항목을 “기본 정보 / 상세 설명 / 옵션”처럼 의미 단위로 나눌 수 있을 때
- 각 필드에 라벨, 도움말, 상태를 붙여야 할 때

**좋은 예**

```text
기본 정보
- 목적
- 앱 이름
- 이메일

상세 설명
- 개선하고 싶은 점
```

**나쁜 예**

```text
placeholder만 있는 빈 칸 8개
오류는 제출 후 alert 하나로 표시
```

placeholder는 입력을 시작하면 사라지기 때문에, 중요한 설명을 placeholder에만 의존하면 사용자가 맥락을 잃기 쉽습니다.

### Keyboard

**무엇인가**

입력 중에 화면 하단을 차지하는 시스템 입력 도구입니다. 키보드는 단순한 부속물이 아니라 입력 UX의 일부입니다.

**언제 확인해야 하나**

- TextField, TextEditor, 검색, 댓글, 메시지 입력을 넣을 때
- 하단 CTA가 있는 화면을 만들 때
- 이메일, 숫자, URL, 검색 등 입력 목적에 맞는 키보드 타입이 필요할 때
- Return/Done/Search 같은 제출 액션이 흐름에 영향을 줄 때

**좋은 예**

```swift
TextField("이메일", text: $email)
    .keyboardType(.emailAddress)
    .textContentType(.emailAddress)
    .textInputAutocapitalization(.never)
```

**나쁜 예**

모든 입력에 기본 키보드를 쓰고, 키보드가 올라왔을 때 제출 버튼이나 오류 메시지가 가려지는지 확인하지 않는 것입니다.

### Validation

**무엇인가**

입력값이 조건을 만족하지 않을 때, 사용자가 무엇을 어떻게 고쳐야 하는지 알려주는 회복 장치입니다.

**언제 쓰나**

- 이메일 형식, 비밀번호 조건, 필수 입력, 최소 길이, 숫자 범위처럼 명확한 조건이 있을 때
- 제출 전 사용자가 미리 고칠 수 있을 때
- 제출 버튼을 비활성화해야 할 때 그 이유를 함께 설명해야 할 때

**좋은 예**

```text
이메일 필드 아래
⚠ 올바른 이메일 주소를 입력해 주세요.
```

**나쁜 예**

```text
제출 버튼을 눌렀을 때 Alert:
입력값이 잘못되었습니다.
```

어떤 필드가 왜 잘못됐는지 알 수 없으면 사용자는 화면 전체를 다시 훑어야 합니다.

---

## Bad / Good 빠른 비교

<div class="compare-section">
  <div class="bad-panel">
    <span class="panel-label">Bad</span>
    <h3>placeholder에 설명을 전부 넣음</h3>
    <p>입력하는 순간 설명이 사라져서 사용자가 조건을 다시 확인하기 어렵습니다.</p>
  </div>
  <div class="good-panel">
    <span class="panel-label">Good</span>
    <h3>라벨과 도움말을 유지</h3>
    <p>필드 이름, 예시, 조건을 사용자가 입력 중에도 볼 수 있게 둡니다.</p>
  </div>
</div>

<div class="compare-section">
  <div class="bad-panel">
    <span class="panel-label">Bad</span>
    <h3>키보드 상태를 확인하지 않음</h3>
    <p>키보드가 올라오면 입력 필드, 오류, CTA가 가려질 수 있습니다.</p>
  </div>
  <div class="good-panel">
    <span class="panel-label">Good</span>
    <h3>입력 중 화면을 실제로 캡처</h3>
    <p>포커스, 키보드 타입, 완료 버튼, safe area를 Simulator에서 확인합니다.</p>
  </div>
</div>

<div class="compare-section">
  <div class="bad-panel">
    <span class="panel-label">Bad</span>
    <h3>오류를 Alert 하나로 처리</h3>
    <p>사용자는 어떤 입력을 고쳐야 하는지 찾기 위해 다시 화면을 훑어야 합니다.</p>
  </div>
  <div class="good-panel">
    <span class="panel-label">Good</span>
    <h3>필드 가까이에 오류 표시</h3>
    <p>구체적인 해결 문구를 오류가 발생한 입력 바로 아래에 둡니다.</p>
  </div>
</div>

---

## SwiftUI로 보면

```swift
Form {
    Section("기본 정보") {
        TextField("앱 이름", text: $appName)
            .textInputAutocapitalization(.words)

        TextField("이메일", text: $email)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .textInputAutocapitalization(.never)

        if !isValidEmail {
            Label("올바른 이메일 주소를 입력해 주세요.",
                  systemImage: "exclamationmark.circle.fill")
                .foregroundStyle(.red)
        }
    }

    Section("상세 설명") {
        TextField("개선하고 싶은 점", text: $message, axis: .vertical)
            .lineLimit(3...5)
            .focused($focusedField, equals: .message)
            .submitLabel(.done)
    }
}
.toolbar {
    ToolbarItemGroup(placement: .keyboard) {
        Spacer()
        Button("완료") { focusedField = nil }
    }
}
```

핵심은 `Form`, `TextField`, `FocusState`, `submitLabel`, keyboard toolbar를 따로 보는 것이 아니라, **입력 → 확인 → 오류 회복** 흐름으로 함께 점검하는 것입니다.

---

## 공식 근거

<div class="evidence-grid">
  <div class="evidence-card">
    <span>Apple HIG</span>
    <h3>Entering data</h3>
    <p>입력은 사용자가 필요한 정보를 이해하고, 실수를 줄이고, 오류에서 회복할 수 있게 설계해야 합니다.</p>
    <a href="https://developer.apple.com/design/human-interface-guidelines/entering-data" target="_blank" rel="noreferrer">문서 보기</a>
  </div>
  <div class="evidence-card">
    <span>Apple HIG</span>
    <h3>Inputs</h3>
    <p>입력 방식과 컨트롤은 사용자의 현재 맥락, 기대, 접근성을 고려해야 합니다.</p>
    <a href="https://developer.apple.com/design/human-interface-guidelines/inputs" target="_blank" rel="noreferrer">문서 보기</a>
  </div>
  <div class="evidence-card">
    <span>SwiftUI</span>
    <h3>Form / TextField / FocusState</h3>
    <p>SwiftUI는 입력 그룹, 텍스트 입력, 포커스 관리를 위한 기본 컴포넌트를 제공합니다.</p>
    <a href="https://developer.apple.com/documentation/swiftui/form" target="_blank" rel="noreferrer">Form</a>
    <a href="https://developer.apple.com/documentation/swiftui/textfield" target="_blank" rel="noreferrer">TextField</a>
    <a href="https://developer.apple.com/documentation/swiftui/focusstate" target="_blank" rel="noreferrer">FocusState</a>
  </div>
</div>

### 근거 수준

- **직접 근거**: Apple HIG의 entering data / inputs 원칙, SwiftUI `Form`, `TextField`, `FocusState` 문서
- **ivibe 해석**: 오류를 필드 가까이에 두고, 키보드 상태를 실제 Simulator 캡처로 확인하는 운영 방식
- **취향이 아닌 이유**: 입력 UX는 미적 취향보다 완료율, 오류 회복, 접근성에 직접 영향을 줍니다.

---

## 체크리스트

- [ ] 입력 항목을 의미 있는 섹션으로 묶었는가?
- [ ] placeholder에만 중요한 설명을 넣지 않았는가?
- [ ] 이메일, 숫자, URL, 검색 등 입력 목적에 맞는 키보드 타입을 썼는가?
- [ ] 키보드가 올라온 실제 화면을 Simulator에서 확인했는가?
- [ ] 오류 메시지를 문제가 있는 필드 가까이에 표시했는가?
- [ ] 오류 문구가 “무엇을 어떻게 고칠지” 말해주는가?
- [ ] 제출 버튼 비활성화 이유가 사용자에게 보이는가?
- [ ] Dynamic Type에서도 필드, 오류, 버튼이 잘리지 않는가?

## 다음 글

다음은 `Permission / Privacy`입니다. 권한 요청을 앱 시작 시 한꺼번에 띄우는 대신, 필요한 순간에 맥락과 회복 경로를 함께 보여주는 구조를 실제 ivibe 앱 화면으로 만들겠습니다.
