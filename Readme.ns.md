
## Использование (Objective-C)
### Запуск
#### Для инициализации SDK используйте `convenience init`

```swift
    [NSMediatagSDK.shared 
      setConfigurationWithCid: @"cid" 
      tms: @"tms" 
      uid: @"uid" 
      hid: @"hid" 
      uidc: @1
    ];
```
  
#### или объект конфигурации:

```swift
    NSConfiguration *configuration = [[NSConfiguration alloc] 
      initWithCid: @"userCid"
      tms: @"tms"
      uid: @"uid"
      hid: @"hid"
      uidc: @1
    ];
    configuration.baseUrl = [NSURL URLWithString:@"https://some_url.com"];
    [config setPluginWithModify:^NSMutableURLRequest * _Nonnull(NSMutableURLRequest * request) {
      NSString *requestPath = [[request URL] absoluteString];
      NSLog(@"%@", requestPath);
      return request;
    }];
    [NSMediatagSDK.shared setConfigurationWithConfiguration: configuration];

```

### Проверка конфигурации
  ```swift
    func getUserAttributes() -> NSMutableDictionary
  ```
### Отправка событий
```swift
  [mediatagSDK 
    nextWithContactType: @1
    view: @2
    idc: @3
    idlc: @"idlc"
    fts: @43234
    urlc: @"http://event_url.ru?query=query"
    media: @"media"
    ver: @36 
  ];
```
