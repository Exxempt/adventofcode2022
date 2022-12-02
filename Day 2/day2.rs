use std::collections::HashMap;

fn get_hashmap_first() -> HashMap<&'static str, i32> {
    let mut map = HashMap::new();

    map.insert("A X", 1 + 3);
    map.insert("A Y", 2 + 6);
    map.insert("A Z", 3 + 0);
    map.insert("B X", 1 + 0);
    map.insert("B Y", 2 + 3);
    map.insert("B Z", 3 + 6);
    map.insert("C X", 1 + 6);
    map.insert("C Y", 2 + 0);
    map.insert("C Z", 3 + 3);

    return map;
}

fn get_hashmap_second() -> HashMap<&'static str, i32> {
    let mut map = HashMap::new();

    map.insert("A X", 3 + 0);
    map.insert("A Y", 1 + 3);
    map.insert("A Z", 2 + 6);
    map.insert("B X", 1 + 0);
    map.insert("B Y", 2 + 3);
    map.insert("B Z", 3 + 6);
    map.insert("C X", 2 + 0);
    map.insert("C Y", 3 + 3);
    map.insert("C Z", 1 + 6);

    return map;
}

fn main() {
    let input = std::fs::read_to_string("./src/day2.txt").unwrap();

    let lines: Vec<&str> = input.split("\n").collect();

    let hashmap_first = get_hashmap_first();

    let mut sum_first = 0;
    for x in &lines {
        if let Some(score) = hashmap_first.get(x) {
            sum_first += score;
        }
    }

    println!("First part answer: {}", sum_first);

    let hashmap_second = get_hashmap_second();

    let mut sum_second = 0;
    for x in lines {
        if let Some(score) = hashmap_second.get(x) {
            sum_second += score;
        }
    }

    println!("Second part answer: {}",sum_second)
}