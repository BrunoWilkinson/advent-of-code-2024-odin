package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"
import "core:slice"
import "core:math"

main :: proc () {
	data := load_input("input.txt")
	// Sort the list 
	slice.sort(data[0][:])
	slice.sort(data[1][:])

	fmt.println(data)

	p1: int
	for i := 0; i < len(data[0]); i+= 1 {
		p1 += math.abs(data[0][i] - data[1][i])
	}
	fmt.println("Result Part1:", p1)

	p2: int
	for left_location in data[0] {
		similarity_score: int
		for right_location in data[1] {
			if (left_location == right_location) {
				similarity_score += 1
			}
		}
		p2 += left_location * similarity_score
	}
	fmt.println("Result Part2:", p2)
}

load_input :: proc (path: string) -> [2][dynamic]int {
	all: [2][dynamic]int = { make([dynamic]int), make([dynamic]int) }

	data, ok := os.read_entire_file(path, context.allocator)
	if !ok {
		fmt.println("failed to read file:" , path);
		return all
	}
	defer delete (data, context.allocator)

	it := string(data)
	for line in strings.split_lines_iterator(&it) {
		ids := strings.split(line, " ")
		defer delete(ids)
		for id in ids {
			if len(id) != 0 && len(all[0]) == len(all[1])
			{
				append(&all[0], strconv.atoi(id))
			} else if len(id) != 0 {
				append(&all[1], strconv.atoi(id))
			}
		}
	}

	return all
}

