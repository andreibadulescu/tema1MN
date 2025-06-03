function [J, grad] = cost_function(params, X, y, lambda, ...
                   input_layer_size, hidden_layer_size, ...
                   output_layer_size)

  % params -> vector containing the weights from the two matrices
  %           Theta1 and Theta2 in an unrolled form (as a column vector)
  % X -> the feature matrix containing the training examples
  % y -> a vector containing the labels (from 1 to 10) for each
  %      training example
  % lambda -> the regularization constant/parameter
  % [input|hidden|output]_layer_size -> the sizes of the three layers

  % J -> the cost function for the current parameters
  % grad -> a column vector with the same length as params
  % These will be used for optimization using fmincg

  % TODO: cost_function implementation

  % TODO1: get Theta1 and Theta2 (from params). Hint: reshape
  elementCountTheta1 = hidden_layer_size * (input_layer_size + 1);
  Theta1 = params(1: elementCountTheta1); % extracting params
  Theta2 = params(elementCountTheta1 + 1:end);
  Theta1 = reshape(Theta1, hidden_layer_size, input_layer_size + 1); % reshaping
  Theta2 = reshape(Theta2, output_layer_size, hidden_layer_size + 1);

  % TODO2: Forward propagation
  % computing classes for given training samples
  trainingCount = size(X, 1);
  expectedResults = zeros(trainingCount, output_layer_size);
  percentages = expectedResults;

  for i = 1 : trainingCount
    expectedResults(i, y(i)) = 1;
  endfor

  delta1 = zeros(size(Theta1));
  delta2 = zeros(size(Theta2));

  % building input layer
  a1 = ones(1, size(X, 1));
  a1 = [a1; X'];

  % intermediary results
  z2 = Theta1 * a1;
  nonlinearFunction = sigmoid(z2);
  a2 = nonlinearFunction;
  a2 = [ones(1, size(a2, 2)); a2];

  % final results + saving predictions
  z3 = Theta2 * a2;
  percentages = (sigmoid(z3))';

  % TODO3: Compute the error in the output layer and perform backpropagation

  % computing errors
  outputLayerError = (percentages - expectedResults)';
  hiddenLayerError = Theta2' * outputLayerError;
  hiddenLayerError = hiddenLayerError(2:end, :); % removing bias
  hiddenLayerError = hiddenLayerError .* (nonlinearFunction .* (1 - nonlinearFunction));

  % accumulating gradients
  delta2 = outputLayerError * a2';
  delta1 = hiddenLayerError * a1';

##  for i = 1 : trainingCount
##    % building input layer
##    a1 = [1; X(i, :)'];
##    %a1 = zeros(input_layer_size + 1, 1);
##    %a1(1) = 1;
##    %a1(2:end) = X(i, :);
##
##    % intermediary results
##    z2 = Theta1 * a1;
##    a2 = sigmoid(z2);
##    a2 = [1; a2];
##
##    % final results + saving predictions
##    z3 = Theta2 * a2;
##    percentages(i, :) = sigmoid(z3);
##
##    % TODO3: Compute the error in the output layer and perform backpropagation
##
##    % computing errors
##    expectedResults(i, y(i)) = 1;
##    outputLayerError = (percentages(i, :) - expectedResults(i, :))';
##    hiddenLayerError = Theta2' * outputLayerError;
##    hiddenLayerError = hiddenLayerError(2:end);% removing bias
##    nonlinearFunction = sigmoid(z2);
##    hiddenLayerError = hiddenLayerError .* (nonlinearFunction .* (1 - nonlinearFunction));
##
##    % accumulating gradients
##    delta2 = delta2 + outputLayerError * a2';
##    delta1 = delta1 + hiddenLayerError * a1';
##  endfor

  % TODO4: Determine the gradients
  gradient1 = delta1;
  gradient2 = delta2;

  for i = 1 : hidden_layer_size
    for j = 2 : input_layer_size + 1
      gradient1(i, j) += lambda * Theta1(i, j);
    endfor
  endfor

  for i = 1 : output_layer_size
    for j = 2 : hidden_layer_size + 1
      gradient2(i, j) += lambda * Theta2(i, j);
    endfor
  endfor

  gradient1 /= trainingCount;
  gradient2 /= trainingCount;

  % TODO5: Final J and grad
  grad = [gradient1(:); gradient2(:)];
  J = 0;

  % computing J
  for i = 1 : trainingCount
    for k = 1 : output_layer_size
      J -= expectedResults(i, k) * log(percentages(i, k));
      J -= (1 - expectedResults(i, k)) * log(1 - percentages(i, k));
    endfor
  endfor

  sum = 0;

  Theta1 = Theta1 .^ 2;
  Theta2 = Theta2 .^ 2;

  for j = 2 : input_layer_size + 1
    for k = 1 : hidden_layer_size
      sum += Theta1(k, j);
    endfor
  endfor

  for j = 2 : hidden_layer_size + 1
    for k = 1 : output_layer_size
      sum += Theta2(k, j);
    endfor
  endfor

  sum *= lambda;
  sum /= 2;
  J += sum;
  J /= trainingCount;
end
