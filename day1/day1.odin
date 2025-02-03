package day1 

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"
import "core:slice"
import "core:math"

main :: proc () {
	data, ok := os.read_entire_file(
		"example.txt", 
		context.allocator)
	if !ok {
		fmt.println("failed to read file");
	}
	defer delete (data, context.allocator)

	left: [dynamic]int
	right: [dynamic]int

	it := string(data)
	fmt.println(it)
	for line in strings.split_lines_iterator(&it) {
		ids := strings.split(line, " ")
		defer delete(ids)
		for id in ids {
			if len(id) != 0 && len(left) == len(right)
			{
				append(&left, strconv.atoi(id))
			} else if len(id) != 0 {
				append(&right, strconv.atoi(id))
			}
		}
	}

	// Sort the list 
	slice.sort(left[:])
	slice.sort(right[:])

	fmt.println(left)
	fmt.println(right)

	p1: int
	for i := 0; i < len(left); i+= 1 {
		p1 += math.abs(left[i] - right[i])
	}
	fmt.println("Result Part1:", p1)

	p2: int
	for left_location in left {
		similarity_score: int
		for right_location in right {
			if (left_location == right_location) {
				similarity_score += 1
			}
		}
		p2 += left_location * similarity_score
	}
	fmt.println("Result Part2:", p2)
}
