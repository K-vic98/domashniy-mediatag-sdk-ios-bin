
## Применение

Вы должны создать объект конфигурациий с реализацией протокола `ConfigurationType`

  ```swift
    final class SDKConfiguration: ConfigurationType{

      var cid: String! = "example_com"
      
      var hid: String? = "27fa89c8-e7af-435d-b0b7-0dd2b17b3fa7"
      
      var uid: String? = nil
      
      var idc: Int? = nil
      
      var uidc: Int?  = 2

    }
  ```
### Настройка параметров конфигурации по умолчанию:
Протокол ConfigurationTyp eнаследуется от `RequestConfiguration`
> Вы можете переопределить методы построения URL-адреса

- `baseUrl` (базовая реализация):
  ```swift
    var baseUrl: URL {
      return URL(string: "https://tns-counter.ru/e/msdkev")!
    }
  ```

- `plugins`
  набор объектов преобразования URLRequest перед его отправкой [пример](/#подготовка-запроса)
  ```swift
     var plugins: [PluginType]?
  ```

- `encodingSet`
  преобразует URLQueryItem[key] используя value
  ```swift
    var encode: [String: CharacterSet]
  ```
  > при переопределении данного параметра установите .urlHostAllowed для urlc, media

- `urlReplacingOccurrences`
  Замените все вхождения целевого URL значением соответствующего ключа.
  ```swift
    var urlReplacingOccurrences: [String: String]
  ```

- `sendingQueueBufferSize`
  размер буфера для хранения данный в случае отсутствия соединения с интренетом
  ```swift
    var sendingQueueBufferSize: Int {
      return 1000
    }
  ```
  >  без '/' в конце, иначе запрос может быть отклонен

- `dataManager` 
  объект реализации протокола `DataManager` [по умолчанию UserDefaultsDataManager()](./UserDefaultsDataManager.swift)
  ```swift
    var saveManager: SaveDelegate?
  ```

- `toQuery()` 
  преобразовать конфигурацию в Dictionary<String, Any?> для [инициализации](./../#Проверка-базовых-аттрибутов) элементов базового url
  ```swift
    func toQuery() -> [[String: Any?]] {}
  ```

- `mapQuery` 
  измените элементы запроса URL-адреса перед отправкой запроса по адресу `только при инициализации url`:
  ```swift
    func mapQuery(query: [[String: Any?]]) -> [URLQueryItem] {}
  ```
   - [x] для прроверки
   - [x] фильтрации
   - [x] добавления кастомных параметров
   

### Запуск
```swift
  // user variable 
  let mediatagSDK = MediatagSDK(configuration: config)
  // shared 
  MediatagSDK.shared.setConfiguration(configuration: Configuration())
```
  
### Подготовка запроса
```swift
  // MARK: - PluginType Implementation
  struct SDKPlugin :PluginType {
    func prepare(_ request: URLRequest) -> URLRequest {
      ///  some request modification code
      return request
    }
  }

  let mediatagSDK = MediatagSDK(configuration: config, plugins: [SDKPlugin()])
  
```
### Преобразование значений URLQueryItem
- `encodingSet`
```swift
  var encodingSet: [String: CharacterSet] // (URLQueryItem.key : Метод кодирования)
```

- `prepareQueryItemValue`
```swift
  func prepareQueryItem(encodingSet: inout [String: CharacterSet], key: String, value: String?) -> String?
```
  возвращает новую строку преобразовая `value` согласно `encodingSet[key]`
