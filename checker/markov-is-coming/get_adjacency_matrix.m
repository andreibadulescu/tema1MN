function [Adj] = get_adjacency_matrix (Labyrinth)
	% Labyrinth -> the matrix of all encodings

  % Adj -> the adjacency matrix associated to the given labyrinth

  % setting up the results matrix
  sizes = size(Labyrinth);
  elementCount = sizes(1) * sizes(2) + 2;
  Adj = sparse(elementCount, elementCount);

  % computing value for each element of the Labyrinth
  for i = 1 : sizes(1)
    for j = 1 : sizes(2)
      code = Labyrinth(i, j);
      pos = (i - 1) * sizes(2) + j;

      % checking bit by bit

      if !(code >= 8)
        if i == 1
          Adj(pos, elementCount - 1) = 1;
        else
          Adj(pos, (i - 2) * sizes(2) + j) = 1;
          Adj((i - 2) * sizes(2) + j, pos) = 1;
        endif
      else
        code -= 8;
      endif

      if !(code >= 4)
        if i == sizes(1)
          Adj(pos, elementCount - 1) = 1;
        else
          Adj(pos, i * sizes(2) + j) = 1;
          Adj(i * sizes(2) + j, pos) = 1;
        endif
      else
        code -= 4;
      endif

      if !(code >= 2)
        if j == sizes(2)
          Adj(pos, elementCount) = 1;
        else
          Adj(pos, (i - 1) * sizes(2) + j + 1) = 1;
          Adj((i - 1) * sizes(2) + j + 1, pos) = 1;
        endif
      else
        code -= 2;
      endif

      if !(code >= 1)
        if j == 1
          Adj(pos, elementCount) = 1;
        else
          Adj(pos, (i - 1) * sizes(2) + j - 1) = 1;
          Adj((i - 1) * sizes(2) + j - 1, pos) = 1;
        endif
      else
        code -= 1;
      endif
    endfor
  endfor

  Adj(elementCount - 1, elementCount - 1) = 1;
  Adj(elementCount, elementCount) = 1;
end
