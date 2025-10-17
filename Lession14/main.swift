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


