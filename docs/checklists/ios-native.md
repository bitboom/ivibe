# iOS-native 체크리스트

ivibe의 모든 예시는 이 체크리스트로 검토합니다.

## Accessibility

- [ ] 텍스트 대비가 충분하다.
- [ ] 아이콘-only 버튼에는 접근성 라벨이 있다.
- [ ] VoiceOver 읽기 순서가 자연스럽다.
- [ ] Dynamic Type에서 텍스트가 잘리지 않는다.

## Touch & Interaction

- [ ] 주요 터치 영역이 44pt 이상이다.
- [ ] 버튼에는 pressed/loading/disabled 상태가 있다.
- [ ] hover에만 의존하지 않는다.

## Navigation

- [ ] 뒤로가기 동작이 예측 가능하다.
- [ ] 탭은 5개 이하이고 목적이 겹치지 않는다.
- [ ] Sheet와 Push를 역할에 맞게 구분한다.

## Forms & Feedback

- [ ] placeholder-only label을 쓰지 않는다.
- [ ] 오류는 필드 가까이에 표시한다.
- [ ] 빈 상태, 로딩, 오류 상태에 다음 행동이 있다.

## System

- [ ] 권한 요청 전 이유를 설명한다.
- [ ] 거부 상태에서 Settings 회복 경로를 제공한다.
- [ ] 다크모드와 Reduce Motion을 고려한다.
