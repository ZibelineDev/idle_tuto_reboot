class_name StringFormat
extends Node


static func thousands_sep(number : int, prefix : String = '') -> String :
	var neg : bool  = false
	if number < 0:
		number = -number
		neg = true
	
	var string : String = str(number)
	var mod : int = string.length() % 3
	var res : String = ""
	
	for i : int in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += ","
		res += string[i]
	
	if neg: res = '-'+prefix+res
	else: res = prefix+res
	
	return res
