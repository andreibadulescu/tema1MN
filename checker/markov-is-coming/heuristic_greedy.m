function [path] = heuristic_greedy (start_position, probabilities, Adj)
	% start_position -> the starting point in the labyrinth
	% probabilities -> vector of associated probabilities: including WIN and LOSE
	% Adj -> adjacency matrix

	% path -> the states chosen by the algorithm

  % TODO: heuristic_greedy implementation

  % setting up
  path = [start_position];
  n = size(Adj, 1);
  n -= 1;
  visited = zeros(1, n);
  visited(start_position) = true;

  % heuristic greedy implementation
  while !isempty(path)
    position = size(path, 2);
    position = path(position);
    if position == n
      path = path';
      break;
    endif

    check = 0;
    savedIndex = 1;

    for i = 1 : n
      if Adj(position, i) == 1 && visited(i) == 0
        if !check
          savedIndex = i;
          check = 1;
        else
          if (probabilities(i) > probabilities(savedIndex))
            savedIndex = i;
          endif
        endif
      endif
    endfor

    if !check
      path(end) = [];
    else
      path = [path, savedIndex];
      visited(savedIndex) = true;
    endif

  endwhile
end
