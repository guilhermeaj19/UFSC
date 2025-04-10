:- use_module(library(readutil)).

read_file(FileName, Lines) :-
    open(FileName, read, Stream),
    read_lines(Stream, Lines),
    close(Stream).

read_lines(Stream, []) :-
    at_end_of_stream(Stream), !.
read_lines(Stream, [Line|Lines]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_string(Stream, LineString),
    string_chars(LineString, LineWithSpaces),
    exclude(=(' '), LineWithSpaces, Line),
    read_lines(Stream, Lines).

slice(List, Start, Size, Slice) :-
    length(Prefix, Start),
    append(Prefix, Rest, List),
    length(Slice, Size),
    append(Slice, _, Rest).