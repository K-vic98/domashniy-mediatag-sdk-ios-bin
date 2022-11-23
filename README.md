
# Mediatag SDK (iOS версия)
SDK предназначен для анонимного сбора информации в Интернете для последующего статистического анализа. 

Данный SDK имеет следующие возможности:
- автоматический сбор базовых характеристик с устройства
- отправка событий `Event` с пользовательскими данными
- кэширование данных в случае временного отсутствия Интернет-соединения и постедующая автоматическая отправка

## Установка

### CocoaPods

```rb
  pod 'MediaTagSDK'
```

### Swift Package Manager

После того, как вы настроили свой пакет Swift, добавьте MediatagSDK путем добавления его к dependencies вашем файле Package.swift.

```swift
  dependencies: [
      .package(url: "https://github.com/MEDIASCOPE-JSC/media-tag-sdk-ios", .upToNextMajor(from: "1.0.8"))
  ]
```

> Эта статья об интеграции в `swift`, если вы хотите использовать `Objective-C`, вам [сюда](./Readme.ns.md)

В любом файле, в котором вы хотите использовать MediatagSDK, не забудьте добавить `import MediatagSDK`.

## Использование
### Инициализация SDK
```swift
  MediatagSDK.shared.configure(cid: "cid", tms: "tms", uid: "uid", hid: "hid", uidc: 1212)
```
> пример расширенной конфигурации SDK можно найти [здесь](./Readme.advanced.md)
#### Проверка базовых аттрибутов
  ```swift
    var userAttributes:  [[String: Any?]]
  ```

### Отправка событий
```swift
  let event = Event(contactType: .undefined, view: .start)
    MediatagSDK.shared.next(event)
```

- `Статус соединения` 
  если запрос не может быть отправлен или отклонен событие будет добавлено в очередь 
  ```swift 
    var sendingIsAvailable: Bool
  ```
    > После восстановления интернет-соединения MediatagSDK автоматически попытается отправить запросы из `очереди отправки`, в противном случае отправка ожидающих событий будет приостановлена.
  
- `Очередь отправки`
  массив запросов ожидающих отправления
  ```swift
    var sendingQueue: [String?]
  ```
  
