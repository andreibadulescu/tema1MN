function [G, c] = get_Jacobi_parameters (Link)
	% Link -> the link matrix (edge with probabilities matrix)

  % G -> iteration matrix
	% c -> iteration vector

  % setting up matrices
  length = size(Link, 1);
  c = sparse(length - 2, 1);
  G = sparse(length - 2);

  % computing iteration vector
  for i = 1 : length - 2
    c(i, 1) = Link(i, length - 1);
  endfor

  % computing iteration matrix
  for i = 1 : length - 2
    for j = 1 : length - 2
      G(i, j) = Link(i, j);
    endfor
  endfor
end
