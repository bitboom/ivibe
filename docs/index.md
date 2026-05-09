---
layout: page
aside: false
sidebar: false
editLink: false
lastUpdated: false
---

<section class="ivibe-hero">
  <div class="hero-copy">
    <p class="eyebrow">iOS-native UX/UI field guide</p>
    <h1>AI로 만든 앱을<br><span>iOS답게</span> 다듬기</h1>
    <p class="hero-lede">ivibe는 vibe coding으로 빠르게 만든 앱이 iOS 사용자의 기대를 놓치지 않도록, HIG 기반 원칙·나쁜 예·좋은 예·SwiftUI 실습을 한 흐름으로 제공합니다.</p>
    <div class="hero-actions">
      <a class="ios-button primary" href="/guide/start">학습 시작</a>
      <a class="ios-button secondary" href="/guide/accessibility-basics">접근성 기본 보기</a>
    </div>
  </div>

  <div class="iphone-stage" aria-label="Bad UX and Good UX comparison preview">
    <div class="iphone-frame">
      <div class="iphone-dynamic-island"></div>
      <div class="phone-screen">
        <div class="phone-nav">폼 UX</div>
        <div class="segmented-control">
          <span class="active">좋은 예</span>
          <span>나쁜 예</span>
        </div>
        <div class="settings-section">
          <p class="section-label">REVIEW</p>
          <div class="settings-row"><span>Visible label</span><strong>✓</strong></div>
          <div class="settings-row"><span>Error near field</span><strong>✓</strong></div>
          <div class="settings-row"><span>44pt touch target</span><strong>✓</strong></div>
        </div>
        <div class="input-card">
          <label>이메일</label>
          <div class="fake-input">sangwan@example.com</div>
          <p>필드 가까이에 도움말과 오류를 표시합니다.</p>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="ivibe-section">
  <div class="section-heading">
    <p class="eyebrow">Read · Compare · Try · Apply</p>
    <h2>문서를 읽는 순간부터 iOS 앱을 만지는 감각으로</h2>
    <p>ivibe의 웹사이트도 학습 대상입니다. iOS Settings, NavigationStack, Sheet, Form의 구조를 웹에 맞게 옮겨 사용합니다.</p>
  </div>
  <div class="feature-grid">
    <article class="feature-card">
      <span class="feature-icon">01</span>
      <h3>HIG Before Trend</h3>
      <p>Apple Human Interface Guidelines를 먼저 기준으로 삼고, 유행하는 웹/AI UI는 보조로만 사용합니다.</p>
    </article>
    <article class="feature-card">
      <span class="feature-icon">02</span>
      <h3>Bad vs Good</h3>
      <p>권한 요청, 폼, 키보드, 빈 상태처럼 실제 앱에서 자주 깨지는 장면을 비교합니다.</p>
    </article>
    <article class="feature-card">
      <span class="feature-icon">03</span>
      <h3>SwiftUI-ready</h3>
      <p>웹 문서의 구조가 나중에 SwiftUI 앱의 NavigationStack, List, Section, TabView로 옮겨지도록 설계합니다.</p>
    </article>
  </div>
</section>

<section class="ivibe-section split-section">
  <div>
    <p class="eyebrow">핵심 가이드</p>
    <h2>iOS답게 만드는 기본기</h2>
  </div>
  <div class="ios-list">
    <a class="ios-list-row" href="/guide/start"><span>iOS 앱은 웹사이트가 아니다</span><em>Start</em></a>
    <a class="ios-list-row" href="/guide/navigation-structure"><span>Navigation Stack / Tab Bar / Sheet</span><em>Structure</em></a>
    <a class="ios-list-row" href="/guide/forms-keyboard-validation"><span>Forms, Keyboard, Validation</span><em>Input</em></a>
    <a class="ios-list-row" href="/guide/loading-empty-error"><span>Loading, Empty, Error State</span><em>Feedback</em></a>
    <a class="ios-list-row" href="/guide/permissions-privacy"><span>Permissions, Privacy, Settings Recovery</span><em>System</em></a>
    <a class="ios-list-row" href="/guide/accessibility-basics"><span>Dynamic Type, VoiceOver, Touch Target</span><em>Accessibility</em></a>
  </div>
</section>

<section class="ivibe-section compare-section">
  <div class="comparison-card bad">
    <p class="eyebrow">Bad UX</p>
    <h3>앱 실행 즉시 권한 요청</h3>
    <p>사용자는 아직 기능 가치를 이해하지 못했습니다. 거부 이후 회복 경로도 보이지 않습니다.</p>
  </div>
  <div class="comparison-card good">
    <p class="eyebrow">Good UX</p>
    <h3>필요한 순간에 이유 먼저 설명</h3>
    <p>기능 맥락 안에서 권한이 왜 필요한지 설명하고, 거부 상태에서도 다음 행동을 안내합니다.</p>
  </div>
</section>

<section class="ivibe-section references-section">
  <div class="section-heading compact">
    <p class="eyebrow">기준 문서</p>
    <h2>기준은 명확하게, 표현은 ivibe답게</h2>
  </div>
  <div class="reference-pills">
    <a href="https://developer.apple.com/design/human-interface-guidelines/">Apple HIG</a>
    <a href="https://www.nngroup.com/articles/">NN/g</a>
    <a href="https://lawsofux.com/">Laws of UX</a>
    <a href="https://www.a11yproject.com/">A11Y Project</a>
    <a href="https://mobbin.com/">Mobbin</a>
  </div>
</section>
