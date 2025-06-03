function [Theta] = normal_equation(FeatureMatrix, Y, tol, iter)
  % FeatureMatrix -> the matrix with all training examples
  % Y -> the vector with all actual values
  % tol -> the learning rate
  % iter -> the number of iterations
  % tol -> the tolerance level for convergence of the conjugate gradient method

  % Theta -> the vector of weights

  % checking eigenvalues
  checkMatrix = FeatureMatrix' * FeatureMatrix;
  [a, b] = eig(checkMatrix);
  if any(diag(b) <= 0)
    Theta = zeros(size(FeatureMatrix, 2) + 1, 1);
    return;
  endif

  % setting up variables
  x0 = inv(FeatureMatrix' * FeatureMatrix) * FeatureMatrix' * Y;
  rPrev = Y - FeatureMatrix * x0;
  v = rPrev;
  vNext = v;
  xPrev = x0;
  x = xPrev;
  sqTol = tol * tol;

  % Conjugate Gradient algorithm
  while iter > 0 && rPrev' * rPrev > sqTol
    t = rPrev' * rPrev / (v' * FeatureMatrix * v);
    x = xPrev + t * v;
    r = rPrev - t * FeatureMatrix * v;
    s = r' * r / (rPrev' * rPrev);
    vNext = r + s * v;
    iter -= 1;
  endwhile

  % adding Theta(0), which is always null
  Theta = zeros(size(FeatureMatrix, 2) + 1, 1);
  Theta(2:end) = x;
end
