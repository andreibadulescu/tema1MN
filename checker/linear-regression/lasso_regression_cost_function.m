function [Error] = lasso_regression_cost_function(Theta, Y, FeatureMatrix, lambda)
  % Theta -> the vector of weights
  % Y -> the vector with all actual values
  % FeatureMatrix -> the matrix with all training examples
  % lambda -> regularization parameter that controls the amount of
  %           shrinkage applied to the regression coefficients

  % Error -> the error of the regularized cost function

  % preparing variables
  m = size(FeatureMatrix, 1); % training count
  weightsNorm = norm(Theta, 1);

  % computing values
  sum = 0;

  % Lasso Regression algorithm
  for i = 1 : m
    currentValue = Y(i);
    currentValue -= FeatureMatrix(i, :) * Theta(2:end);
    currentValue -= Theta(1);
    currentValue *= currentValue;
    currentValue += lambda * weightsNorm;
    sum += currentValue;
  endfor

  Error = sum / m
end
