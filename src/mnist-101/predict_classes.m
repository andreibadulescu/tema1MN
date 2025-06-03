function [classes] = predict_classes(X, weights, ...
                  input_layer_size, hidden_layer_size, ...
                  output_layer_size)
  % X -> the test examples for which the classes must be predicted
  % weights -> the trained weights (after optimization)
  % [input|hidden|output]_layer_size -> the sizes of the three layers

  % classes -> a vector with labels from 1 to 10 corresponding to
  %            the test examples given as parameter

  % computing classes for given test samples
  testCount = size(X, 1);
  classes = zeros(testCount, 1);

  elementCountTheta1 = hidden_layer_size * (input_layer_size + 1);
  Theta1 = weights(1: elementCountTheta1); % extracting params
  Theta2 = weights(elementCountTheta1 + 1:end);
  Theta1 = reshape(Theta1, hidden_layer_size, input_layer_size + 1); % reshaping
  Theta2 = reshape(Theta2, output_layer_size, hidden_layer_size + 1);

  for i = 1 : testCount
    % building input layer
    a1 = zeros(input_layer_size + 1, 1);
    a1(1) = 1;
    a1(2:end) = X(i, :);

    % intermediary results
    z2 = Theta1 * a1;
    a2 = sigmoid(z2);
    a2 = [1; a2];

    % final results
    z3 = Theta2 * a2;
    a3 = sigmoid(z3);

    % saving predictions
    percentages(i, :) = a3;

    maxIndex = 1;

    % computing resulting class
    for j = 2 : output_layer_size
      if a3(maxIndex) < a3(j)
        maxIndex = j;
      endif
    endfor

    % saving class
    classes(i) = maxIndex;
  endfor
end
