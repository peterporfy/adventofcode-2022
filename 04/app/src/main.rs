use std::fs;

fn load_file(path: &str) -> String {
    fs::read_to_string(&path).expect("Failed to read.")
}

fn parse_to_pairs(line: &str) -> (&str, &str) {
    let mut pairs = line.split(",");
    return (pairs.next().unwrap(), pairs.next().unwrap());
}

fn parse_number(maybe: Option<&str>) -> u32 {
    maybe.unwrap().parse().unwrap()
}

fn parse_to_range(range: &str) -> (u32, u32) {
    let mut values = range.split("-");
    let min = parse_number(values.next());
    let max = parse_number(values.next());

    return (min, max);
}

fn has_overlap(left: (u32, u32), right: (u32, u32)) -> bool {
    left.0 <= right.1 && left.1 >= right.0
}

fn check_full_overlap(a: (u32, u32), b: (u32, u32)) -> bool {
    a.0 <= b.0 && a.1 >= b.1
}

fn has_full_overlap(left: (u32, u32), right: (u32, u32)) -> bool {
    check_full_overlap(left, right) || check_full_overlap(right, left)
}

fn main() {
    let contents = load_file("./data");

    let lines = contents.lines();
    let mut full_overlaps = 0;
    let mut overlaps = 0;

    for line in lines {
        let (left, right) = parse_to_pairs(line);
        let left = parse_to_range(left);
        let right = parse_to_range(right);

        if has_overlap(left, right) {
            overlaps += 1;

            if has_full_overlap(left, right) {
                full_overlaps += 1;
            }
        }
    }

    println!("Full overlaps: {full_overlaps}. Overlaps: {overlaps}");
}
