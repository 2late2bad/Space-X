# Space-X
Тестовое задание на стажировку от компании "Контур".
Приложение показывает информацию о космических ракетах SpaceX и список их запусков.

![iOS](https://img.shields.io/badge/iOS-13+%20-white?logo=Apple&logoColor=white)
![Swift](https://img.shields.io/badge/Swift-5.5-red?logo=Swift&logoColor=red)
![Xcode](https://img.shields.io/badge/Xcode-14.3%20-00B2FF?logo=Xcode&logoColor=00B2FF)

Реализованы все фичи согласно [техническому заданию](https://drive.google.com/file/d/1IvYa62XtcAzl4JfU78-4roD08ifKGypE/view)

## Preview
Экраны приложения:
| Rockets | Launches | Settings |
:---:|:---:|:---:
![Rockets](https://github.com/2late2bad/Space-X/assets/121951550/29fb83f5-9184-4b20-94ff-950b56688138) | ![Launches](https://github.com/2late2bad/Space-X/assets/121951550/28a8c1be-0f28-4d8a-813f-8356839d4a0a) | ![Settings](https://github.com/2late2bad/Space-X/assets/121951550/eb3a1952-4cdc-4e55-b0d7-4085887c5d4c)

## Tech stack
* UIKit
* GCD
* URLSession
* UserDefaults
* MVP + Router + Assembly

## Highlights
* Верстка экранов кодом (без storyboards), верстка ячеек таблицы с помощью xib-файлов
* Адаптивная высота content view и table view
* Ограничения скроллинга, адаптированные под любой смартфон
* Универсальный NetworkService и StorageService на дженериках
* Обновление изображения свайпом БЕЗ использования UIRefreshControl
* Изменение единиц измерения по всем экранам через NotificationCenter
* Анимация кнопок и появления изображения
* Локализация на русском и английском языках
* Без использования сторонних библиотек

### Resources
* [SpaceX API](https://github.com/r-spacex/SpaceX-API)
