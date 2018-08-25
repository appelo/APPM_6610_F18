clear 
n = 50;
h = 2/n;
tend = 2;
a = 1;
x = -1+h*(1:n)';
u0 = exp(-36*x.^2);
for mtd = 1:4
    u = u0;
    up = zeros(size(u));
    k = 0.5*h^2;
    nt = ceil(tend/k);
    k = tend/nt; 
    lam = k/h;
    for it = 1:nt
        for i = 1:n
            ip = i+1;
            im = i-1;
            if (ip > n) 
                ip = ip - n;
            end
            if (im < 1) 
                im = im + n; 
            end                    
            switch mtd
              case 1 % downwind
                up(i) = u(i) - a*lam*(u(ip)-u(i));
              case 2 % upwind
                up(i) = u(i) - a*lam*(u(i)-u(im));
              case 3 % central
                up(i) = u(i) - 0.5*a*lam*(u(ip)-u(im));
              case 4 % LxF
                up(i) = 0.5*(u(ip)+u(im)) - 0.5*a*lam*(u(ip)-u(im));
            end
        end
        u = up;
        figure(mtd)
        plot(x,u,'ro',x,u0,'k')
        axis([-1 1 -0.1 1.1])
        drawnow
    end
end
