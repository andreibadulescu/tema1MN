function [Labyrinth] = parse_labyrinth(file_path)
	% file_path -> the relative path to a file that needs to
  %              be loaded

  % Labyrinth -> the matrix of all encodings for the labyrinth's walls

  % opening file and reading matrix dimensions
  readFile = fopen(file_path, 'r');
  m = fscanf(readFile, '%d', 1);
  n = fscanf(readFile, '%d', 1);

  % reading matrix from file
  Labyrinth = sparse(m, n);

  for i = 1 : m
    for j = 1 : n
      Labyrinth(i, j) = fscanf(readFile, '%d', 1);
    endfor
  endfor

  fclose(readFile);
end
