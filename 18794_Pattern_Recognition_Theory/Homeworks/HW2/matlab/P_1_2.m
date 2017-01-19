figure;
hold on;
%load data
c1=[2,2,2;1,2,3];
c2=[4,5,6;3,3,4];
c=[c1,c2];

%(1) calculate global mean and local means
mu=mean(c,2);
mu1=mean(c1,2);
mu2=mean(c2,2);

%(2) draw data points
plot(c1(1,:),c1(2,:),'rx',c2(1,:),c2(2,:),'bo');
axis([0,7,0,7]);
axis equal;

%(3) calcuate Sb
Sb=(mu1-mu2)*(mu1-mu2)';

%(4) calculate S1
S1=zeros(size(c1,1));
for i=1:size(c1,2)
    S1=S1+(c1(:,i)-mu1)*(c1(:,i)-mu1)';
end
S1=S1./size(c1,2);
%(5) calculate S2
S2=zeros(size(c2,1));
for j=1:size(c2,2)
    S2=S2+(c2(:,j)-mu2)*(c2(:,j)-mu2)';
end
S2=S2./size(c2,2);
%(6) calculate Sw
Sw=S1+S2;

%(7) calcuate generalized eigenvectors and eigenvalues of Sb*V=Sw*V*D
%[V,D]=eigs(inv(Sw)*Sb);
[V,D]=eigs(Sb,Sw);

%(8) sort eigenvalues and eigenvectors
[E,I]=sort(diag(D),'descend');
V=V(:,I);

%(9) normalize the desired eigenvector
V(:,1)=V(:,1)/norm(V(:,1));
%(10) calcuate w, the normal vector of the projection line
tempw=cross([0;0;1],[V(:,1);0]);
w=tempw(1:2,1);
w=w/norm(w); %the normal vector of the desired projection line
%(11) calcuate w0
w0=-w'*mu;

%draw projection line
fh=@(x1,x2) w(1)*x1+w(2)*x2+w0;
ezplot(fh,[0,7,0,7]);
axis equal;

%projected points
pc=V(:,1)*(V(:,1)'*cc)+repmat(mu,1,size(cc,2));

%draw projections
for i=1:size(pc,2)
    plot([c(1,i);pc(1,i)],[c(2,i);pc(2,i)],'black');
end

%(12) calcuate MSE
MSE=sum(sum((c-pc).^2,1),2)/size(c,2)

%(13) calcuate Fisher ratio
cc1=c1-repmat(mu,1,size(c1,2));
cc2=c2-repmat(mu,1,size(c2,2));
cc=[cc1,cc2];

pcc1=V(:,1)'*cc1;
pcc2=V(:,1)'*cc2;
pmu1=mean(pcc1,2);
pmu2=mean(pcc2,2);
pccc1=(pcc1-pmu1);
pccc2=(pcc2-pmu2);
ps1=(pccc1*pccc1')/size(pccc1,2);
ps2=(pccc2*pccc2')/size(pccc2,2);
FR=(pmu1-pmu2)^2/(ps1+ps2)

%set title
title(sprintf('[%f,%f]*x+%f=0; MSE=%f, FR=%f',w(1),w(2),w0,MSE,FR));