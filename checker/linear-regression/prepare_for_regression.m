function [FeatureMatrix] = prepare_for_regression(InitialMatrix)
  % InitialMatrix -> the matrix that must be transformed

  % FeatureMatrix -> the matrix with all training examples

  % calculating new sizes
  [n m] = size(InitialMatrix);
  FeatureMatrix = zeros(n, m * 2);

  % translating strings to numbers
  for i = 1 : n
    j = 1;
    index2 = 1;
    while j <= m
      % encode string and transfer the resulting code in feature matrix
      if strcmp("no", InitialMatrix{i, j}) == 1
        FeatureMatrix(i, index2) = 0;
      elseif strcmp("yes", InitialMatrix{i, j}) == 1
        FeatureMatrix(i, index2) = 1;
      elseif strcmp("furnished", InitialMatrix{i, j}) == 1
        FeatureMatrix(i, index2) = 0;
        index2++; % this feature uses 2 bits
        FeatureMatrix(i, index2) = 0;
      elseif strcmp("unfurnished", InitialMatrix{i, j}) == 1
        FeatureMatrix(i, index2) = 0;
        index2++; % this feature uses 2 bits
        FeatureMatrix(i, index2) = 1;
      elseif strcmp("semi-furnished", InitialMatrix{i, j}) == 1
        FeatureMatrix(i, index2) = 1;
        index2++; % this feature uses 2 bits
        FeatureMatrix(i, index2) = 0;
      else
        % move number in the feature matrix
        FeatureMatrix(i, index2) = str2num(InitialMatrix{i, j});
      endif

      index2++;
      j++;
    endwhile
  endfor

  FeatureMatrix = FeatureMatrix(:, 1:index2 - 1);
end
