function ydot=ProjectFunction(t, y)
% Defines the ODEs derived in the TMME04 project
% David Wiman (davwi279) & Samuel Erickson Andersson (samer177)

% Pre-set variables
    m1 = 1;
    m2 = 2;
    m3 = 3;
    k = 1;
    R = 1;
    d = 4*R/(3*pi);
    l = 3;
    g = 9.81;

% Variable re-labeling    
    x = y(1);
    x_dot = y(2);
    theta = y(3);
    theta_dot = y(4);
    phi = y(5);
    phi_dot = y(6);

% Creates the A and b matrices    
    A=[m1+m2+m3 -d*sin(theta)*(m2+m3) m3*(l/2)*cos(phi);...
        -d*sin(theta)*(m2+m3) (((m2*(R^2))/2)+m3*(d^2)) -m3*d*(l/2)*sin(theta+phi);...
        m3*(l/2)*cos(phi) -m3*d*(l/2)*sin(theta+phi) (m3*(l^2))/3];

    b=[-k*x+d*(theta_dot^2)*cos(theta)*(m2+m3)+m3*(l/2)*(phi_dot^2)*sin(phi);...
        g*d*cos(theta)*(m2+m3)+m3*d*(l/2)*(phi_dot^2)*cos(theta+phi);...
        -m3*g*(l/2)*sin(phi)+m3*d*(l/2)*(theta_dot^2)*cos(theta+phi)];

% Solve the system of equationes    
    z=A\b;

% Allocate space for the output vector
    ydot=zeros(6,1);

% Assigne values in the output vector    
    ydot(1) = x_dot;
    ydot(2) = z(1);

    ydot(3) = theta_dot;
    ydot(4) = z(2);

    ydot(5) = phi_dot;
    ydot(6) = z(3);
    
end    