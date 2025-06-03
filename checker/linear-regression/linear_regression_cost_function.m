function [Error] = linear_regression_cost_function(Theta, Y, FeatureMatrix)
  % Theta -> the vector of weights
  % Y -> the vector with all actual values
  % FeatureMatrix -> the matrix with all training examples

  % Error -> the error of the regularized cost function

  % preparing variables
  m = size(FeatureMatrix, 1); % training count
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
  Error = sum;
end
