function [Y, InitialMatrix] = parse_data_set_file(file_path)
  % path -> a relative path to the .txt file

  % Y -> the vector with all actual values
  % InitialMatrix -> the matrix that must be transformed

  % reading sizes
  readFile = fopen(file_path, 'r');
  n = fscanf(readFile, "%d", 1);
  m = fscanf(readFile, "%d", 1);
  Y = zeros(n, 1);
  InitialMatrix = cell(n, m);

  % reading data
  for i = 1 : n
    % saving actual values in Y
    Y(i, 1) = fscanf(readFile, "%d", 1);

    % reading features
    for j = 1 : m
      InitialMatrix{i, j} = fscanf(readFile, "%s", 1);
    endfor
  endfor

  fclose(readFile);
end
