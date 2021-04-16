function [outlier_score] = my_knn(set1, k)

set2 = set1;
distance = zeros(size(set1, 1), size(set2, 1));
for i = 1:size(set1, 1)
    for j = 1:size(set2, 1)
        distance(i, j) = norm(set1(i,:)-set2(j,:), 2);
    end
end

[distance_sorted, ~] = sort(distance);
outlier_score = mean(distance_sorted(1:k,:));

end