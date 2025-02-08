package day2

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"
import "core:slice"
import "core:math"

main :: proc () {
	data, ok := os.read_entire_file(
		"input.txt", 
		context.allocator)
	if !ok {
		fmt.println("failed to read file")
	}
	defer delete (data, context.allocator)

	num_safe_reports : int
	it := string(data)
	for line in strings.split_lines_iterator(&it) {
		ids := strings.split(line, " ")
		defer delete(ids)

		failed_report: bool
		for str_val, index in ids {
			if (index == len(ids) - 1) {
				break
			}

			val := strconv.atoi(str_val)
			next := strconv.atoi(ids[index + 1])

			if (!is_level_safe(val, next, index == 0)) {
				failed_report = true
				break
			}
		}

		if (failed_report) {
			outer: for _, i in ids {
				// create temp array
				temp_ids: [dynamic]int
				for str_val, y in ids {
					if (i != y) {
						append(&temp_ids, strconv.atoi(str_val))
					}
				}
				defer delete(temp_ids)

				dampener_safe := true
				for val, index in temp_ids {
					if (index == len(temp_ids) - 1) {
						if (dampener_safe) {
							failed_report = false
							break outer
						}
						break
					}

					if (!is_level_safe(val, temp_ids[index + 1], index == 0)) { 
						dampener_safe = false
						break
					}
				}
			}
		}

		if (!failed_report) {
			num_safe_reports += 1
		}
	}
	fmt.println(num_safe_reports)
}

is_level_safe :: proc (val: int, next: int, refresh: bool) -> bool {
	@static is_increasing: bool
	@static is_decreasing: bool  

	if (refresh) {
		is_increasing = val < next
		is_decreasing = val > next
	}

	if (val == next) {
		return false
	} else if (math.abs(val - next) > 3) {
		return false
	} else if (is_decreasing && val < next) {
		return false
	} else if (is_increasing && val > next) {
		return false
	}

	return true
}

