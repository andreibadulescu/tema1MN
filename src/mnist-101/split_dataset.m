function [X_train, y_train, X_test, y_test] = split_dataset(X, y, percent)
  % X -> the loaded dataset with all training examples
  % y -> the corresponding labels
  % percent -> fraction of training examples to be put in training dataset

  % X_[train|test] -> the datasets for training and test respectively
  % y_[train|test] -> the corresponding labels

  % Example: [X, y] has 1000 training examples with labels and percent = 0.85
  %           -> X_train will have 850 examples
  %           -> X_test will have the other 150 examples

  % computing random index values
  dimensions = size(X);
  randIndexesRows = randperm(dimensions(1)); % randomising row indexes

  % splitting indexes in train set & test set
  border = dimensions(1) * percent;
  border = ceil(border);
  trainSetIndexes = randIndexesRows(1:border);
  testSetIndexes = randIndexesRows(border + 1:end);

  % computing actual sets
  X_train = zeros(border, dimensions(2));
  y_train = zeros(border, 1);
  X_test = zeros(dimensions(1) - border, dimensions(2));
  y_test = zeros(dimensions(1) - border, 1);

  for i = 1 : border
    X_train(i, :) = X(trainSetIndexes(i), :);
    y_train(i) = y(trainSetIndexes(i));
  endfor

  for i = 1 : dimensions(1) - border
    X_test(i, :) = X(testSetIndexes(i), :);
    y_test(i) = y(testSetIndexes(i));
  endfor
end
