function [t_vek,x,theta,phi,R,l,d,b] = ProjectMain
% The main function in solving the problem presented in the TMME04 project
% David Wiman (davwi279) & Samuel Erickson Andersson (samer177)

% Pre-set variables
    m1 = 1;
    m2 = 2;
    m3 = 3;
    k = 1;
    R = 1;
    d = 4*R/(3*pi);
    l = 3;
    b = 3;
    g = 9.81;
    t_max = 35;

% Initial values
    x0 = 0;
    x_dot0 = 0;
    theta0 = pi/4;
    theta_dot0 = 0;
    phi0 = pi;
    phi_dot0 = 0;

% Sets options for the ODE solver
    options = odeset('RelTol',10^-6,'AbsTol',10^-10);

% Solves the ODEs    
    [t_vek,Y] = ode45(@(t,y) ProjectFunction(t, y),[0 t_max],...
        [x0 x_dot0 theta0 theta_dot0 phi0 phi_dot0],options);

% Stores the values from the ODE solver
    x = Y(:,1);
    x_dot = Y(:,2);
    theta = Y(:,3);
    theta_dot = Y(:,4);
    phi = Y(:,5);
    phi_dot = Y(:,6);

% Plots the variables x, theta and phi over time
    figure(1)
    subplot(1,3,1)
    plot(t_vek,x)
    xlabel('Time (s)');
    ylabel('x (m)');
    title('Uppgift 4, x')
    

    subplot(1,3,2)
    plot(t_vek,theta*180/pi)
    xlabel('Time (s)');
    ylabel('Theta (degrees)');
    title('Uppgift 4, theta')

    subplot(1,3,3)
    plot(t_vek,phi*180/pi)
    xlabel('Time (s)');
    ylabel('Phi (degrees)');
    title('Uppgift 4, phi')
    
% Calculates the speeds of the centers of mass for body 2 and 3
    Vg2 = sqrt((x_dot-d*sin(theta).*theta_dot).^2 + (-d*cos(theta).*theta_dot).^2);

    Vg3 = sqrt((x_dot-d*sin(theta).*theta_dot+(l/2)*cos(phi).*phi_dot).^2 +...
        (-d*cos(theta).*theta_dot+(l/2)*sin(phi).*phi_dot).^2);

% Calculates the total energy of the system
    E = m1*(x_dot.^2)./2 + m2*(Vg2.^2)./2 + m3*(Vg3.^2)./2 + ...
        ((m2*(R^2))/2-m2*(d^2))*(theta_dot.^2)/2 + ((m3*(l^2))*(phi_dot.^2))/24 +...
        (k*(x.^2))/2 +  m2*g*(-d*sin(theta))+ m3*g*(-d*sin(theta)-(l/2)*cos(phi));

% Plots the total energy over time
    figure(2)
    plot(t_vek,E)
    xlabel('Time (s)');
    ylabel('Total energy (J)');
    title('Uppgift 5, default RelTol och AbsTol')

% Calculates the location of the combined center of mass for the system
    Gx = ((m1+m2+m3)*(x+b/2)+(m2+m3)*d*cos(theta)+m3*(l/2)*sin(phi))/(m1+m2+m3);
    Gy = (-m2*d*sin(theta)-m3*d*sin(theta)-m3*(l/2)*cos(phi))/(m1+m2+m3);

% Plots the combined center of mass for the system
    figure(3)
    plot(Gx,Gy)
    title('Center of mass, k=0')
    xlabel('x (m)');
    ylabel('y (m)');
    
end