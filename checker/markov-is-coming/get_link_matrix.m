function [Link] = get_link_matrix (Labyrinth)
	% Labyrinth -> the matrix of all encodings

  % Link -> the link matrix associated to the given labyrinth

  % setting up the results matrix
  sizes = size(Labyrinth);
  elementCount = sizes(1) * sizes(2) + 2;
  Link = sparse(elementCount, elementCount);

  % computing value for each element of the Labyrinth
  for i = 1 : sizes(1)
    for j = 1 : sizes(2)
      code = Labyrinth(i, j);
      pos = (i - 1) * sizes(2) + j;

      base2 = 8;
      connectionCount = 0;

      while base2 >= 1
        if base2 > code
          connectionCount += 1;
        else
          code -= base2;
        endif

        base2 /= 2;
      endwhile

      code = Labyrinth(i, j);

      % checking bit by bit
      if !(code >= 8)
        if i == 1
          Link(pos, elementCount - 1) = 1 / connectionCount;
        else
          Link(pos, (i - 2) * sizes(2) + j) = 1 / connectionCount;
        endif
      else
        code -= 8;
      endif

      if !(code >= 4)
        if i == sizes(1)
          Link(pos, elementCount - 1) = 1 / connectionCount;
        else
          Link(pos, i * sizes(2) + j) = 1 / connectionCount;
        endif
      else
        code -= 4;
      endif

      if !(code >= 2)
        if j == sizes(2)
          Link(pos, elementCount) = 1 / connectionCount;
        else
          Link(pos, (i - 1) * sizes(2) + j + 1) = 1 / connectionCount;
        endif
      else
        code -= 2;
      endif

      if !(code >= 1)
        if j == 1
          Link(pos, elementCount) = 1 / connectionCount;
        else
          Link(pos, (i - 1) * sizes(2) + j - 1) = 1 / connectionCount;
        endif
      else
        code -= 1;
      endif
    endfor
  endfor

  Link(elementCount - 1, elementCount - 1) = 1;
  Link(elementCount, elementCount) = 1;

end
