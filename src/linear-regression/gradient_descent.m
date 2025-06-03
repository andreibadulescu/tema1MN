function [Theta] = gradient_descent(FeatureMatrix, Y, n, m, alpha, iter)
  % FeatureMatrix -> the matrix with all training examples
  % Y -> the vector with all actual values
  % n -> the number of predictors
  % m -> the number of trainings
  % alpha -> the learning rate
  % iter -> the number of iterations

  % Theta -> the vector of weights

  % setting up variables
  xPrev = zeros(n, 1);
  x = xPrev;

  % Gradient Descent algorithm

  while iter > 0
    % computing partial derivatives
    partialDerivatives = zeros(n, 1);

    for j = 1 : n
      sum = 0;

      for i = 1 : m
        currentElement = 0;
        currentElement += FeatureMatrix(i, :) * xPrev - Y(i);
        currentElement *= FeatureMatrix(i, j);
        sum += currentElement;
      endfor

      sum /= m;
      partialDerivatives(j) = sum;
    endfor

    % computing iter-th weights

    for j = 1 : n
      x(j) = xPrev(j) - alpha * partialDerivatives(j);
    endfor

    xPrev = x;
    iter -= 1;
  endwhile


  Theta = zeros(n + 1, 1);
  Theta(2:end) = x;
end
