//
//  main.swift
//  Lession14
//
//  Created by Oleg Konstantinov on 17.10.2025.
//

import Foundation

//1 -Функция поиска элемента
//Создай обобщённую функцию containsElement(_:_:), которая проверяет, содержится ли элемент в массиве.

//MARK: - Вариант 1
func containsElement<T>(_ item: T, in array: [T]) -> Bool where T: Equatable {
    array.contains(item)
}

//MARK: - Вариант 2
func containsElement<T>(in array: [T], _ item: T ) -> Bool where T: Equatable {
    for element in array {
        if element == item {
            return true
        }
    }
    return false
}

//MARK: - Тесты
let isContains = containsElement("world", in: ["Hello", "world"])
print(isContains)

/*
 2- Создать массив из двух элементов
 Напиши функцию, которая принимает два значения одного типа и возвращает массив из них.

 пример
 makeArray(1, 2) → [1, 2]
 */

//Как мне кажется, этот вариант слишком перегружен
//func transformToArray<T>(_ a: T, _ b: T) -> [T] {
//    var array: [T] = []
//    array.append(a)
//    array.append(b)
//    
//    return array
//}
func transformToArray<T>(_ a: T, _ b: T) -> [T] { [a, b] }

let testInt = transformToArray(1, 2)
let testString = transformToArray("Hello", "world")
print(testInt)
print(testString)

/*
 3- Напиши обобщённую функцию, которая сравнивает два значения (если тип поддерживает Equatable).

 пример
 isEqual("hi", "hi") → true
 isEqual(10, 20) → false
 */

func isEqual<T>(_ first: T, _ second: T) -> Bool where T: Equatable {
    first == second
}

print(isEqual("hi", "hi"))
print(isEqual(10, 20))


/*
 4-Напиши функцию, которая создаёт словарь из массивов ключей и значений.

 пример
 makeDictionary(keys: ["a", "b"], values: [1, 2]) → ["a": 1, "b": 2]
 */

func makeDictionary<Key, Value>(keys: [Key], values: [Value]) -> Dictionary<Key, Value> {
    var dict: [Key: Value] = [:]
    if keys.count == values.count {
        for (index, item) in keys.enumerated() {
            dict[item] = values[index]
        }
    }
    return dict
}


print(makeDictionary(keys: ["a", "b"], values: [1, 2]))

/*
 5 - Обобщённая структура Pair
 Создай структуру Pair, которая хранит два значения любого типа.
 */
//MARK: - Вариант 1
struct Pair<T> {
    var first: T
    var second: T
}

//MARK: - Вариант 2
//В этом случае, первое и второе свойства, могут быть двух разных типов
//struct Pair<T, V> {
//    var first: T
//    var second: V
//}
let pairString: Pair = Pair(first: "Hello", second: "World")
let pairInt: Pair = Pair(first: 10, second: 1)
let pairChar: Pair<Character> = Pair(first: "A", second: "B")


//MARK: - Сложнее

/*
 1- Создай класс Cache<Key, Value>, где Key: Hashable.
 Добавь методы set, get, remove.
 */
class Cache<Key: Hashable, Value> {
    private var cache: [Key: Value] = [:]
    
    func set(key: Key, for value: Value) {
        cache[key] = value
    }
    
    func get() {
        if !cache.isEmpty {
            print(cache)
        } else {
            print("Cache not found")
        }
    }
    
    func remove(key: Key) { // Здесь идет обработка опционала в теле метода, а в следующем задании обработка делается вне метода
        if let removedValue = cache.removeValue(forKey: key) {
            print("Удален ключ: \(key) со значением \(removedValue)")
        } else {
            print("Ключ \(key) в словаре не найден")
        }
    }
    
}

let dict = Cache<String, String>()

dict.set(key: "Car", for: "BMW")
dict.get()

dict.set(key: "Fruit", for: "Apple")
dict.get()

dict.remove(key: "Car")
dict.get()

/*
 2- Класс KeyValueStore
 Создай дженерик-класс для хранения пар "ключ-значение".

 пример
 let userAges = KeyValueStore<String, Int>()
 userAges.set(25, for: "Alice")
 print(userAges.get(for: "Alice") ?? 0) // 25
 */

class KeyValueStore<Key: Hashable, Value> {
    var storage: [Key: Value] = [:]
    
    func set(_ value: Value, for key: Key) {
        storage[key] = value
    }
    
    func get(for key: Key) -> Value? {
        storage[key]
    }
}

let userAges = KeyValueStore<String, Int>()
userAges.set(25, for: "Alice")
print(userAges.get(for: "Alice") ?? 0) // 25

/*
 3- Класс Logger
 Создай класс Logger, который принимает сообщения любого типа и сохраняет их в массив.

 пример
 let intLogger = Logger<Int>()
 intLogger.add(1)
 intLogger.add(2)
 intLogger.showAll() // 1 2

 let stringLogger = Logger<String>()
 stringLogger.add("Start")
 stringLogger.add("End")
 stringLogger.showAll() // Start End
 */

class Logger<Element> {
    private var storage: [Element] = []
    
    private var description: String {
        storage.map { "\($0)" }.joined(separator: " ")
    }
    
    func add(_ item: Element) {
        storage.append(item)
    }
    
    func showAll() {
        print(description)
    }
}

let intLogger = Logger<Int>()
intLogger.add(1)
intLogger.add(2)
intLogger.showAll()

let stringLogger = Logger<String>()
stringLogger.add("Start")
stringLogger.add("End")
stringLogger.showAll() // Start End

/*
 4 - Создай протокол Repository, который хранит данные любого типа (ассоциативный тип) и имеет методы save и getAll. Реализуй этот протокол для дженерик класса
 */

protocol Repository {
    associatedtype T
    
    func save(_ element: T)
    func getAll()
}

class Request<V>: Repository {
    private var storage: [V] = []
    
    private var description: String {
        storage.map { "\($0)" }.joined(separator: " ")
    }
    
    func save(_ element: V) {
        storage.append(element)
    }
    
    func getAll() {
        print(description)
    }
    
    
}

let requestString = Request<String>()
requestString.save("Hello")
requestString.save("World")
requestString.getAll()


let requestInt = Request<Int>()
requestInt.save(1)
requestInt.save(3487)
requestInt.getAll()



