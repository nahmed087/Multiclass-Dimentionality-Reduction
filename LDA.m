function [SW,SB] = LDA(Data, a)

% c=unique(a);
c = a;
pos=1;
for i=1:length(c)
   for j=1:a(i)
      Labels(pos,1)=i;
      pos=pos+1;
   end
end

%% Calculate Mean of each class
for i=1:length(c)
    mu(i,1:size(Data,2)) = mean(Data(Labels==i,:));
end

%% Calculate the total mean of all classes
muTotal = zeros(size(mu(1,:)));
for i=1:length(c)
    muTotal = muTotal+a(i)*mu(i,:);
end
muTotal=muTotal/(sum(a));

%% Subtract the original data from the mean
D = zeros(size(Data,1),size(Data,2));
for i=1:length(c)
    D(Labels==i,:) = Data(Labels==i,:) - repmat(mu(i,:),a(i),1);
end

%% Calculate the within class variance (SW)
SW = zeros(size(Data,2),size(Data,2));
for i=1:c
    SW = SW + D(Labels==i,:)'*D(Labels==i,:);
end

%% Calculate the Between-class variance (SB)
SB=zeros(size(Data,2),size(Data,2));
for i=1:length(c)
   SB= SB + a(i)*(mu(i,:)-muTotal)'*(mu(i,:)-muTotal);
end
