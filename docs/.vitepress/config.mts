import { defineConfig } from 'vitepress'

export default defineConfig({
  base: '/ivibe/',
  title: 'ivibe',
  description: 'AI 시대 앱 제작자를 위한 iOS-native UX/UI 기본기 가이드',
  lang: 'ko-KR',
  cleanUrls: true,
  themeConfig: {
    logo: { text: 'ivibe' },
    nav: [
      { text: 'Start', link: '/guide/start' },
      { text: 'Structure', link: '/guide/navigation-structure' },
      { text: 'Input', link: '/guide/forms-keyboard-validation' },
      { text: 'Checklist', link: '/checklists/ios-native' }
    ],
    sidebar: [
      {
        text: 'Foundations',
        items: [
          { text: 'iOS 앱은 웹사이트가 아니다', link: '/guide/start' },
          { text: 'NavigationStack / Tab Bar / Sheet', link: '/guide/navigation-structure' },
          { text: 'Form / Keyboard / Validation', link: '/guide/forms-keyboard-validation' },
          { text: 'iOS-native 체크리스트', link: '/checklists/ios-native' },
          { text: '프로젝트 체크리스트', link: '/project-checklist' }
        ]
      }
    ],
    socialLinks: [
      { icon: 'github', link: 'https://github.com/bitboom/ivibe' }
    ],
    search: { provider: 'local' }
  },
  head: [
    ['meta', { name: 'theme-color', content: '#F5F5F7' }],
    ['meta', { property: 'og:title', content: 'ivibe' }],
    ['meta', { property: 'og:description', content: 'AI로 만든 앱을 iOS답게 다듬는 UX/UI 필드 가이드' }]
  ]
})
