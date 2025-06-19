%% Bifurcation diagram of logistic map
close all;
r= linspace(2.4, 4,10000 );
n = 1000;
last = 100;
x = 1e-5 * ones(1, length(r));
figure;
hold on;
for i = 1:n
    x = r.*x.*(1-x);
    if i > n - last
        plot(r, x, '.k', 'MarkerSize' , 0.08 );
    end
end

%% Bifurcation diagram of quadratic map
r= linspace(0, 2, 100000 );   
n = 1000;
last = 200;
x = .05 * ones(1, length(r)); 
figure;
hold on;
for i = 1:n
    x = 1- r.*x.^2;
    if i > n - last
        plot(r, x, '.r', 'MarkerSize' , 0.08 ); 
    end
end
%%