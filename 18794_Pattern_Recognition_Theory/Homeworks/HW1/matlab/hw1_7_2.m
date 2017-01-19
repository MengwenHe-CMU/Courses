figure
hold on;

mu1=[0;0];
sigma1=[1 1 ; 1 8];
r1=chol(sigma1);
x1=repmat(mu1,1,400)+r1'*randn(2,400);

mu2=[4;0];
sigma2=[2 0 ; 0 2];
r2=chol(sigma2);
x2=repmat(mu2,1,400)+r2'*randn(2,400);

plot(x1(1,:),x1(2,:),'rx',x2(1,:),x2(2,:),'bo');
axis([-6 10 -8 8]);
axis equal;

hold off;