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

## 개발

```bash
npm install
npm run dev
npm run build
```

## 배포

GitHub Pages는 `.github/workflows/deploy.yml`에서 VitePress를 빌드해 배포합니다.

## 현재 체크리스트

- [x] VitePress 기반 GitHub Pages 사이트 생성
- [x] iOS-native 홈 초안 작성
- [x] 첫 글 `iOS 앱은 웹사이트가 아니다` 작성
- [x] Apple HIG / SDK 문서 근거 링크 반영
- [x] Bad / Good 비교 패널 스타일 추가
- [ ] NavigationStack / Tab Bar / Sheet 글 작성
- [ ] Form / Keyboard / Validation 글 작성
- [ ] Permissions / Privacy 글 작성
- [ ] Checklist 페이지를 시각 카드 형태로 개선
- [ ] 실제 SwiftUI 체험 앱 MVP 설계
