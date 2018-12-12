clear all
close all
clc

baseaddress = 'shorthanddataset/';
Data = zeros(50,2500);
for i = 1:50
    if(i<=10)
        D = imread(strcat(baseaddress,num2str(i),'.jpg'));
        else if(i>10 && i<=20)
            D = imread(strcat(baseaddress,num2str(i),'.jpg'));
            else if(i>20 && i<=30)
                D = imread(strcat(baseaddress,num2str(i),'.jpg'));
                else if(i>30 && i<=40)
                    D = imread(strcat(baseaddress,num2str(i),'.jpg'));
                    else if(i>40 && i<=50)
                        D = imread(strcat(baseaddress,num2str(i),'.jpg'));
                        end
                    end
                end
            end
    end
    
    Data(i,:) = reshape(D(:,:,1),1,numel(D(:,:,1)));
end

C = 2500*ones(2,1);
%Data = Data(1:20,:);

c1 = Data(1:10,:)';
c2 = Data(11:20,:)';
c3 = Data(21:30,:)';
c4 = Data(31:40,:)';
c5 = Data(41:50,:)';

% Number of observations of each class
n1=size(c1,1);
n2=size(c2,1);
n3=size(c3,1);
n4=size(c4,1);
n5=size(c5,1);


%% Mean of each class
mu1=mean(c1);
mu2=mean(c2);
mu3=mean(c3);
mu4=mean(c4);
mu5=mean(c5);

%% Average of the mean of all classes
mu=(n1*mu1 + n2*mu2 + n3*mu3 + n4*mu4 + n5*mu5)/(n1+n2+n3+n4+n5);

%% Center the data (data-mean)
d1=c1-repmat(mu1,size(c1,1),1);
d2=c2-repmat(mu2,size(c2,1),1);
d3=c3-repmat(mu3,size(c3,1),1);
d4=c4-repmat(mu4,size(c4,1),1);
d5=c5-repmat(mu5,size(c5,1),1);

% Calculate the within class variance (SW)
s1=d1'*d1;
s2=d2'*d2;
s3=d3'*d3;
s4=d4'*d4;
s5=d5'*d5;
sw=s1+s2+s3+s4+s5;
s = svds(sw,50)
invsw=inv(sw);

% if more than 2 classes calculate between class variance (SB)
sb1=n1*(mu1-mu)'*(mu1-mu);
sb2=n2*(mu2-mu)'*(mu2-mu);
sb3=n3*(mu3-mu)'*(mu3-mu);
sb4=n4*(mu4-mu)'*(mu4-mu);
sb5=n5*(mu5-mu)'*(mu5-mu);
SB=sb1+sb2+sb3+sb4+sb5;

J=invsw*SB;

%% Calculate the eignevalues and eigenvectors of (J)
[evec,eval]=eig(J);
% Sort the eigenvectors according to their corresponding eigenvalues (descending order)
eval = diag(eval);
[junk, index] = sort(-eval);
eval = eval(index);
evec = evec(:, index);
% Select the largest k eigenvectors as a lower dimensional space
k = 7;
W=evec(1:k-1,:);

% project the original data on the lower dimensional space (W)
y1=uint8(abs(c1*W'));
y2=uint8(abs(c2*W'));
y3=uint8(abs(c3*W'));
y4=uint8(abs(c4*W'));
y5=uint8(abs(c5*W'));


[r,c] = size(y1);

for i = 1:c
    im1 = reshape(y1(:,i),50,50);
    im2 = reshape(y2(:,i),50,50);
    im3 = reshape(y3(:,i),50,50);
    im4 = reshape(y4(:,i),50,50);
    im5 = reshape(y5(:,i),50,50);
    imwrite(im1,strcat('c1reconstim',num2str(i),'.jpg'));
    imwrite(im2,strcat('c2reconstim',num2str(i),'.jpg'));
    imwrite(im3,strcat('c3reconstim',num2str(i),'.jpg'));
    imwrite(im4,strcat('c4reconstim',num2str(i),'.jpg'));
    imwrite(im5,strcat('c5reconstim',num2str(i),'.jpg'));
end
        
    
    