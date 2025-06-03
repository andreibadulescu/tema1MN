function [Y, InitialMatrix] = parse_csv_file(file_path)
  % path -> a relative path to the .csv file

  % Y -> the vector with all actual values
  % InitialMatrix -> the matrix that must be transformed

  readFile = fopen(file_path);

  % skipping first line
  fgetl(readFile);

  % reading into separate matrices
  [Y, tempMatrix] = textread(file_path, '%f,%s');

  % removing headers
  Y = Y(2:end, :);
  tempMatrix = tempMatrix(2:end, :);

  % splitting features and saving them in result matrix
  n = size(tempMatrix, 1);
  InitialMatrix = cell(n, 12);

  for i = 1 : n
    InitialMatrix(i, :) = ostrsplit(tempMatrix{i, 1}, ",");
  endfor

  fclose(readFile);
end
