clear all
close all
clc

parpool('local', 2);

load 'TrainingImages1D'
load 'TestImages1D'
load 'train_label'

% Variable Initialization
counter = 0;
iterator = 0;
ratio = 0;     % Total energy preservation ratio
distance = 0;  % Euclidean distance for Nearest Neighbor
accuracy_mat = zeros(3,10);      % Result accuracy map
scrsz = get(groot,'ScreenSize'); % Get screen width and height



% 1. Prepare data matrix
X = images; %training images
T = testimages; %test images

% Retrieve dimension and sample number
[d,N] = size(X);
[td, tn] = size(T);

% 2. Create covariance matrix S 
X_bar = mean(X, 2);
% Here, there is another approach by only calculate covariance of X
% S = cov(X);
S = (X-repmat(X_bar, [1,N])) * (X-repmat(X_bar,[1,N]))' .* (1/N);

% 3. Singular Value Decomposition of S
%    Get Projection matrix U
[U, D, V] = svd(S);
diag_vec = diag(D);
%% Task 1a: 2D - Visualization

p = 2;
% PCA Step 4. Reduce dimension to 2
G2 = U(:, 1:p);

% 5. Reconstruct train data matrix
Y2 = G2' * X;

for classid = 0:9
    
    mask = (train_label ==  classid);
    a = Y2(1,mask);
    b = Y2(2,mask);
    c = train_label(mask);
    
    % Draw 2D visualization in separate view
    subplot(4,5,classid+1);       % Add plot in 4 x 5 grid
    scatter(a', b');
    title(['Number ' , num2str(classid)]);
    
% Draw 2D visualization in one graph
    graph_2d(classid+1) = scatter(a', b',[], c, '+');
    hold on;
    title('PCA 2D Visualization');
end

delete(gcp);