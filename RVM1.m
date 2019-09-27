function P0 = RVM1(q1,q2,q3,q4,q5)

%parameters of RVM1


a = [0 250 160 0 0];
d = [300 0 0 0 72];
alpha = [90 0 0 90 0];
theta = [q1 q2 q3 (q4+90) (q5-90)];
P = [0;0;0;1];  %concatenate 1 to the position vector so it can be used with the homegeneous transform operator

for i = 5:-1:1
    
   A = [cosd(theta(i)), -cosd(alpha(i))*sind(theta(i)), sind(alpha(i))*sind(theta(i)) , a(i)*cosd(theta(i));
     sind(theta(i)), cosd(alpha(i))*cosd(theta(i)) , -sind(alpha(i))*cosd(theta(i)), a(i)*sind(theta(i));
     0            , sind(alpha(i))                 , cosd(alpha(i))                , d(i)               ;
     0            , 0                              , 0                             , 1                  ;];
  
 P = A*P;

end
 
P0 = P;
P0(4) = [];  %Removes the excess one

origin = [0 0 0];
f = [origin;P0'];
plot3(f(:,1),f(:,2),f(:,3));

%%
%the following are the coordinates of the first link
origin = [0 0 0];
link1 = [0 0 300];

%transforms the position of the link from spherical to Cartesian
x = 250*cosd(q2)*cosd(q1);
y = 250*cosd(q2)*sind(q1);
z = 250*sind(q2);
link2 = [x y z];

%transforms the position of the link from spherical to Cartesian
x = 160*cosd(q3+q2)*cosd(q1);
y = 160*cosd(q3+q2)*sind(q1);
z = 160*sind(q3+q2);
link3 = [x y z];

%transforms the position of the link from spherical to Cartesian
x = 72*cosd(q4+q3+q2)*cosd(q1);
y = 72*cosd(q4+q3+q2)*sind(q1);
z = 72*sind(q4+q3+q2);
link4 = [x y z];

%creates the componenet vector such that each link is connected to the end
%of the previous link; last column is the position vector in base frame
x = [origin(1)           , origin(1) + link1(1)           , origin(1) + link1(1) + link2(1)          , origin(1) + link1(1) + link2(1)+ link3(1)            , origin(1);
     origin(1) + link1(1), origin(1) + link1(1) + link2(1), origin(1) + link1(1) + link2(1)+ link3(1), origin(1) + link1(1) + link2(1)+ link3(1) + link4(1), P0(1)];
 
y = [origin(2)           , origin(2) + link1(2)           , origin(2) + link1(2) + link2(2)          , origin(2) + link1(2) + link2(2)+ link3(2)            , origin(2);
     origin(2) + link1(2), origin(2) + link1(2) + link2(2), origin(2) + link1(2) + link2(2)+ link3(2), origin(2) + link1(2) + link2(2)+ link3(2) + link4(2), P0(2)];
 
z = [origin(3)           , origin(3) + link1(3)           , origin(3) + link1(3) + link2(3)          , origin(3) + link1(3) + link2(3)+ link3(3)            , origin(3);
     origin(3) + link1(3), origin(3) + link1(3) + link2(3), origin(3) + link1(3) + link2(3)+ link3(3), origin(3) + link1(3) + link2(3)+ link3(3) + link4(3), P0(3)];
 
%graphs the link and the position vector in base frame 
plot3(x,y,z, 'LineWidth',8)
xlabel('X')
ylabel('Y')
zlabel('Z')
grid on
legend('Link 1', 'Link 2', 'Link 3', 'Link 4', 'Position Vector of End Effector Frame in terms of Base Frame')


text(P0(1),P0(2),P0(3), sprintf('x = %.4f\n y = %.4f\n z = %.4f\n',P0(1),P0(2),P0(3)),'FontSize',15);

