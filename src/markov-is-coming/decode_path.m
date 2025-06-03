function [decoded_path] = decode_path (path, lines, cols)
	% path -> vector containing the order of the states that arrived
	% 		 to a winning position
	% lines -> numeber of lines
	% cols -> number of columns

	% decoded_path -> vector of pairs (line_index, column_index)
  %                 corresponding to path states
  % hint: decoded_path does not contain indices for the WIN state

  % setting up decoded_path
  length = size(path, 1);
  length -= 1
  decoded_path = zeros(length, 1);

  % transforming values from path in coordinates
  for i = 1 : length
    value = floor((path(i) - 1) / cols);
    decoded_path(i, 1) = value + 1;
    decoded_path(i, 2) = path(i) - value * cols;
  endfor
end
