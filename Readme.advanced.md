
## Применение

Вы должны создать объект конфигурациий с реализацией протокола `ConfigurationType`

  ```swift
    final class SDKConfiguration: ConfigurationType{

      var cid: String! = "example_com"
      
      var tms: String = "partner_tms"
      
      var hid: String? = "27fa89c8-e7af-435d-b0b7-0dd2b17b3fa7"
      
      var uid: String? = nil
      
      var uidc: NSNumber? = 2

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
  набор объектов преобразования URLRequest перед его отправкой
  ```swift
     var plugins: [PluginTypeEnum]?
  ```
  протоколо PluginType требует имплементацию функции: `func prepare(_ request: URLRequest) -> URLRequest`
    - customPlugin(PluginType) - с использованием имплементации протокола PluginType [пример](/#подготовка-запроса)
    - customFunction((_ request: NSMutableURLRequest) -> NSMutableURLRequest) - через предикат

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
  var plugins: [PluginTypeEnum] {
    [.customPlugin(SDKPlugin())]
  }
  
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
  
- `toQuery()` 
  преобразовать конфигурацию в Dictionary<String, Any?> для [инициализации](./../#Проверка-базовых-аттрибутов) элементов базового url
  ```swift
    func toQuery() -> [String: Any?] {}
  ```
  > при переопределении данного параметра передайте в encodingSet urlc и media со значением с `encodingCharacterSet`

- `mapQuery(items: [String: Any?])` 
    метод преобразования собранных нанных в urlQuery
  ```swift
    func mapQuery(query: [String: Any?]) -> String {}
  ```
   - [x] для прроверки
   - [x] фильтрации
   - [x] установка кодировки для value
   
- `prepareQueryItemValue`
  ```swift
     public func prepareQueryItemValue(encodingSet: inout [String: String], key: String, value: Any) -> String?
  ```
  Вызывается из mapQuery, преобразовывает набор символов с процентной кодировкой, учитывая набор символов (`encodingCharacterSet` по умолчанию)
>  если ключ указан в encodingSet, после преобразования он будет удален (отправлять копию в контексте mapQuery)

- `buildURL(query: String)`
  сгенерировать исходный URL для отправки
  ```swift
    public func buildURL(query: String) -> URL {
      return baseUrl + query
    }
  ```
