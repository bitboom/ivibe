# ivibe

**ivibe**는 AI/vibe coding으로 빠르게 만든 앱을 iOS답게 다듬기 위한 iOS-native UX/UI field guide입니다.

목표는 단순한 디자인 취향이 아니라 Apple Human Interface Guidelines와 iOS SDK 문서에 근거한 좋은 예/나쁜 예, 체크리스트, SwiftUI 실습 흐름을 제공하는 것입니다.

## 방향

- iOS System First
- HIG Before Trend
- Bad vs Good with Evidence
- Learn by Touch
- Accessibility by Default
- SwiftUI-ready Structure

## 링크

- Site: https://bitboom.github.io/ivibe/
- Repository: https://github.com/bitboom/ivibe

## 개발

```bash
npm install
npm run dev
npm run build
```

### iOS 앱

```bash
ruby generate_ios_project.rb
xcodebuild -project ios/ivibe.xcodeproj -scheme ivibe \
  -destination 'platform=iOS Simulator,name=iPhone 17' build
```

문서에 들어가는 iOS 화면은 `ios/`의 실제 SwiftUI 앱을 iOS 26 Simulator에서 실행한 뒤 `docs/public/screenshots/ios26/`에 캡처합니다.

## 배포

GitHub Pages는 `.github/workflows/deploy.yml`에서 VitePress를 빌드해 배포합니다.

## 현재 체크리스트

- [x] VitePress 기반 GitHub Pages 사이트 생성
- [x] iOS-native 홈 초안 작성
- [x] 첫 글 `iOS 앱은 웹사이트가 아니다` 작성
- [x] Apple HIG / SDK 문서 근거 링크 반영
- [x] Bad / Good 비교 패널 스타일 추가
- [x] NavigationStack / Tab Bar / Sheet 글 작성
- [x] 실제 SwiftUI 체험 앱 MVP 생성
- [x] iOS 26 Simulator 실제 스크린샷을 Navigation 글에 반영
- [x] Form / Keyboard / Validation 글 작성
- [x] iOS 26 Simulator 실제 스크린샷을 Form 글에 반영
- [x] Permission / Privacy 글 작성
- [x] iOS 26 Simulator 실제 스크린샷을 Privacy 글에 반영
- [ ] Loading / Empty / Error State 글 작성
- [ ] Checklist 페이지를 시각 카드 형태로 개선
- [x] 실제 SwiftUI 체험 앱 MVP 설계
