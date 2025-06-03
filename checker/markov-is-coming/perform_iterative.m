function [x, err, steps] = perform_iterative (G, c, x0, tol, max_steps)
	% G -> iteration matrix
	% c -> iteration vector
	% x0 -> initial solution
	% tol -> accepted tolerance (norm of the difference between two solutions)
	% max_steps -> the maximum number of iterations

	% x -> final solution
	% err -> last calculated difference (as an euclidean norm)
	% steps -> actual number of steps performed

  % setting up matrices
  x = x0;
  steps = 0;

  % stopping if step number exceeds max
  while max_steps > steps
    steps++;
    xp = G * x + c;
    err = norm(x - xp, 2);
    x = xp;

    if err < tol
      break;
    endif
  endwhile
end
