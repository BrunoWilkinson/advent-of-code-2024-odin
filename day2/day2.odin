package day2

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

}
