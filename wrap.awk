#!/usr/bin/env -S gawk -f

BEGIN {
	if (!width) {
		width = 79;
	}
}

{
	gsub(/\r/, $0, "");
	match($0, /^[[:space:]]*/);
	indent_len = RLENGTH;
	indent = substr($0, 1, indent_len);
	$0 = substr($0, indent_len + 1);
	cur_line = indent;
	wrap = 0;
	while (length != 0) {
		if (match($0, /^[[:space:]]*$/) && wrap) {
			break;
		}
		add = match($0, /[[:space:]]/) ? RSTART : length;
		cur_width = length(cur_line);
		if (add + indent_len > width) {
			printf( \
				"error: word \"%s\" too long (%d chars long, but max allowed is %d)\n", \
				substr($0, 1, add), add, width \
			) >"/dev/stderr";
			_err = 1;
			exit 1;
		}
		if (cur_width + add > width) {
			print cur_line;
			cur_line = indent;
			wrap = 1;
		}
		cur_line = cur_line substr($0, 1, add);
		$0 = substr($0, add+1);
	}
	print cur_line;
}

END {
	if (_err) {
		exit 1;
	}
}
