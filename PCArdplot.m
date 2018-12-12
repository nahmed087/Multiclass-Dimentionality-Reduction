function PCArdplot(image,score,coeff)
fid = imread(image);
rgbImage = fid;
figure,
scatter3(rgbImage(1,:), rgbImage(2,:), rgbImage(3,:));
grid on,
title('\fontsize{16} 3D RGB Plot')
xlabel('Value of R component')
ylabel('Value of G component')
zlabel('Value of B component')

xlim([0 255])
ylim([0 255])
zlim([0 255])



figure,
plot(coeff(:,1),'r','LineWidth',2),hold on
plot(coeff(:,2),'g','LineWidth',2),hold on
plot(coeff(:,3),'b','LineWidth',2),hold on
legend('PC1','PC2','PC3')
grid on,
title('\fontsize{16}Loadings Plot of the Scores')


vbls = {'Red','Green','Blue'};
figure,
biplot(coeff(:,1:3),'Scores',score(:,1:3),'Varlabels',vbls);
title('\fontsize{16} Scores/Coeff in 3D PC space')

figure,
scatter3(score(:,1),score(:,2),score(:,3))
axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
zlabel('3rd Principal Component')
title('\fontsize{16}Data representation in Tthree PCs')