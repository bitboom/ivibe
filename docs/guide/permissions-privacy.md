---
title: Permission / Privacy
---

# Permission / Privacy

권한 요청은 앱이 먼저 요구하는 절차가 아니라, 사용자가 **그 기능을 쓰려는 순간** 이해하고 선택할 수 있게 돕는 UX입니다.

<div class="compact-summary">
  <strong>가장 짧은 결론</strong>
  <span>앱 실행 직후 권한을 먼저 요구하지 말고, 기능 맥락 → 시스템 요청 → 거절 후 복구 안내 순서로 설계합니다.</span>
</div>

## 먼저 실제 앱 화면으로 보기

아래 이미지는 `ivibe` SwiftUI 앱을 iOS 26 Simulator에서 실행해 캡처한 화면입니다.

<div class="real-screenshot-grid">
  <figure class="real-screenshot-card">
    <img src="/screenshots/ios26/privacyPrePrompt.png" alt="카메라 권한을 요청하기 전에 기능 맥락과 이유를 설명하는 ivibe 앱 화면" />
    <figcaption>
      <span class="shot-label">Before request</span>
      시스템 alert 전에 왜 필요한지 먼저 설명합니다.
    </figcaption>
  </figure>

  <figure class="real-screenshot-card">
    <img src="/screenshots/ios26/privacySystemPrompt.png" alt="ivibe 앱 위에 표시된 실제 iOS 카메라 권한 요청 alert" />
    <figcaption>
      <span class="shot-label">System prompt</span>
      iOS 권한 alert는 앱이 꾸미는 화면이 아니라 시스템 결정 지점입니다.
    </figcaption>
  </figure>

  <figure class="real-screenshot-card">
    <img src="/screenshots/ios26/privacyRecovery.png" alt="권한 거절 후 설정에서 카메라 접근을 다시 켜도록 안내하는 ivibe 앱 화면" />
    <figcaption>
      <span class="shot-label">Recovery</span>
      거절 후에는 같은 요청을 반복하지 말고 설정 복구 경로를 안내합니다.
    </figcaption>
  </figure>
</div>

## 한눈에 보기

<div class="decision-strip">
  <div>
    <span>1</span>
    <strong>Pre-prompt</strong>
    <p>권한이 왜 필요한지 앱 화면에서 먼저 설명합니다.</p>
  </div>
  <div>
    <span>2</span>
    <strong>System prompt</strong>
    <p>사용자가 기능을 시작한 직후 iOS 권한 요청을 띄웁니다.</p>
  </div>
  <div>
    <span>3</span>
    <strong>Recovery</strong>
    <p>거절 이후에는 설정에서 다시 켜는 방법을 알려줍니다.</p>
  </div>
</div>

## 가장 짧은 판단법

권한 요청 화면을 만들 때는 이 세 질문만 먼저 봅니다.

1. **지금 요청해야 하는가?**  
   사용자가 아직 기능을 쓰지 않았는데 앱 실행 직후 요청한다면 대부분 너무 이릅니다.
2. **왜 필요한지 사용자 언어로 설명했는가?**  
   “카메라 권한 필요”보다 “사진 리뷰 기능에서 문제 화면을 촬영하기 위해 필요”가 낫습니다.
3. **거절해도 길을 막지 않았는가?**  
   권한을 거절하면 기능 제한과 설정 복구 경로를 알려줘야 합니다.

## 컴포넌트로 이해하기

### Pre-prompt

**무엇인가**

시스템 권한 alert를 띄우기 전에 앱 안에서 이유와 맥락을 설명하는 화면입니다.

**언제 쓰나**

- 권한이 기능의 핵심일 때
- 권한 요청 문구만으로 이유가 충분히 전달되지 않을 때
- 권한을 거절하면 기능이 제한되는 경우

**주의점**

Pre-prompt를 시스템 alert처럼 꾸미면 안 됩니다. 사용자가 시스템 요청과 앱 설명을 헷갈릴 수 있습니다.

### System permission prompt

**무엇인가**

iOS가 표시하는 실제 권한 결정 alert입니다. 앱은 이 alert의 디자인을 바꾸지 못하고, 사용자는 여기서 허용/거절을 선택합니다.

**언제 띄우나**

- 사용자가 해당 기능을 직접 시작했을 때
- 앱이 실제로 카메라, 위치, 사진, 마이크 같은 보호 리소스에 접근해야 할 때
- `Info.plist`의 usage description이 사용자가 이해할 수 있을 만큼 구체적일 때

### Recovery state

**무엇인가**

권한을 거절한 뒤 앱이 보여주는 복구 안내입니다.

**언제 쓰나**

- 사용자가 권한을 거절했거나 설정에서 꺼둔 경우
- 권한 없이는 기능이 제한되는 경우
- 앱이 반복해서 같은 권한 요청을 띄울 수 없는 경우

## Bad / Good 빠른 비교

<div class="compare-grid">
  <div class="compare-card bad">
    <p class="compare-label">Bad</p>
    <h3>앱 실행 직후 권한 몰아치기</h3>
    <ul>
      <li>사용자는 아직 왜 필요한지 모릅니다.</li>
      <li>거절하면 기능 흐름이 끊깁니다.</li>
      <li>권한 요청이 앱의 첫인상이 됩니다.</li>
    </ul>
  </div>
  <div class="compare-card good">
    <p class="compare-label">Good</p>
    <h3>기능 맥락 안에서 요청하기</h3>
    <ul>
      <li>사용자가 기능을 시작할 때 이유를 설명합니다.</li>
      <li>시스템 alert의 목적 문구를 구체적으로 씁니다.</li>
      <li>거절 후에도 설정 복구 경로를 제공합니다.</li>
    </ul>
  </div>
</div>

## SwiftUI / iOS SDK 힌트

```swift
import AVFoundation
import SwiftUI

struct CameraPermissionButton: View {
    @State private var status = AVCaptureDevice.authorizationStatus(for: .video)

    var body: some View {
        Button("사진 리뷰 시작") {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                Task { @MainActor in
                    status = AVCaptureDevice.authorizationStatus(for: .video)
                }
            }
        }
    }
}
```

권한 요청을 구현할 때는 코드보다 `Info.plist` 문구가 더 중요할 때가 많습니다.

```text
NSCameraUsageDescription = 사진 리뷰 기능에서 iOS UX 문제를 촬영해 확인하기 위해 카메라 접근이 필요합니다.
```

거절 후 복구 화면에서는 `UIApplication.openSettingsURLString`으로 앱 설정 화면을 열 수 있습니다. 다만 문서와 UI에서는 “설정에서 켜세요”만 반복하지 말고, **현재 어떤 기능이 제한되는지**를 함께 설명해야 합니다.

## 공식 근거

<div class="evidence-grid">
  <a class="evidence-card" href="https://developer.apple.com/design/human-interface-guidelines/privacy" target="_blank" rel="noreferrer">
    <strong>Apple HIG — Privacy</strong>
    <span>사용자 데이터 접근은 투명하고 필요한 맥락 안에서 다뤄야 합니다.</span>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/design/human-interface-guidelines/alerts" target="_blank" rel="noreferrer">
    <strong>Apple HIG — Alerts</strong>
    <span>alert는 중요한 결정을 방해 없이 전달해야 하며 남용하면 안 됩니다.</span>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/documentation/avfoundation/requesting-authorization-to-capture-and-save-media" target="_blank" rel="noreferrer">
    <strong>AVFoundation authorization</strong>
    <span>카메라/미디어 캡처 접근은 시스템 권한 요청 흐름을 따라야 합니다.</span>
  </a>
  <a class="evidence-card" href="https://developer.apple.com/documentation/corelocation/requesting-authorization-to-use-location-services" target="_blank" rel="noreferrer">
    <strong>Core Location authorization</strong>
    <span>위치 권한도 필요한 시점과 목적 설명이 중요합니다.</span>
  </a>
</div>

## 체크리스트

- [ ] 앱 실행 직후 권한을 먼저 요청하지 않는다.
- [ ] 권한이 필요한 기능을 사용자가 시작한 뒤 요청한다.
- [ ] 시스템 alert 전에 앱 화면에서 이유와 이점을 설명한다.
- [ ] `Info.plist` usage description이 구체적이다.
- [ ] 거절 후 같은 요청을 반복하지 않는다.
- [ ] 권한이 꺼졌을 때 제한되는 기능과 설정 복구 경로를 안내한다.
- [ ] 권한 없이도 가능한 대체 흐름이 있다면 제공한다.

## 다음 글

다음은 `Loading / Empty / Error State`입니다. AI로 만든 앱에서 자주 빠지는 “기다리는 중”, “아무것도 없음”, “실패 후 회복” 상태를 실제 iOS 앱 화면으로 만들고 비교합니다.
