function [Error] = ridge_regression_cost_function(Theta, Y, FeatureMatrix, lambda)
  % Theta -> the vector of weights
  % Y -> the vector with all actual values
  % FeatureMatrix -> the matrix with all training examples
  % lambda -> regularization parameter that controls the amount of
  %           shrinkage applied to the regression coefficients

  % Error -> the error of the regularized cost function

  % preparing variables
  m = size(FeatureMatrix, 1); % training count
  n = size(Theta); % weight count
  sqWeightSum = 0;

  for i = 2 : n
    sqWeightSum += Theta(i) * Theta(i);
  endfor

  sqWeightSum *= lambda;

  % computing values
  sum = 0;

  % Ridge Regression algorithm
  for i = 1 : m
    currentValue = FeatureMatrix(i, :) * Theta(2:end);
    currentValue += Theta(1);
    currentValue -= Y(i);
    currentValue *= currentValue;
    sum += currentValue;
  endfor

  m *= 2;
  sum /= m;
  sum += sqWeightSum;
  Error = sum;
end
