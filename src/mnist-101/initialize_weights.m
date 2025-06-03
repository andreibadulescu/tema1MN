function [matrix] = initialize_weights(L_prev, L_next)
  % L_prev -> the number of units in the previous layer
  % L_next -> the number of units in the next layer

  % matrix -> the matrix with random values

  % computing max/min error value
  e0 = sqrt(6) / sqrt(L_prev + L_next);

  % building weights matrix
  matrix = zeros(L_next, L_prev + 1);
  L_prev += 1;

  for i = 1 : L_next
    for j = 1 : L_prev
      % generating random values in between [-e0, e0]
      matrix(i, j) = -e0 + rand(1, 1) * 2 * e0;
    endfor
  endfor
end
