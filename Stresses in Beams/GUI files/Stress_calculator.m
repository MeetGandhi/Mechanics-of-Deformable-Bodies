function [Stress,rect_x,rect_y] = Stress_calculator(x,y,M)
% Inputs are the vertices of convex polygon and moment vector .function returns three matrices.
% rect_x rect_y are the meshgrid representing 'check rectangle'- the rectangle surrounding the 
% input convex polygon. This rectangle is scanned by the function named
% 'inpolygon' to get all the points which lie withinn the convex polygon
% whose vertices are provided as inputs. 
% Then using the input vector M and function stress_point , stresses at
% dicretized interior points are calculated and returned in form of matrix
% Stress

% creating rectangular area to check for (rect_x and rect_y)

% eps=5;   % discretization
n=10;  %number of vectors to be used for plotting in x and y directions 
eps_x=(max(x)-min(x))/(n)
eps_y=(max(y)-min(y))/(n)
points = [min(x)-eps_x  max(x)+eps_x  min(y)-eps_y  max(y)+eps_y];
rect_x=[];
rect_y=[];
for i=points(3):eps_y:points(4)
    rect_x=[rect_x;points(1):eps_x:points(2)];
end
j=zeros(1,size(points(1):eps_x:points(2),2));
for i=points(3):eps_y:points(4)
    rect_y=[rect_y;j+i];
end

% checking interior points for convex polygon
in=inpolygon(rect_x,rect_y,x,y);   %inpolygon takes input form of four vectors. 2 are the matrices representing 
                                   %coordinates to scan for. The second two are the vectors representing vertices 
                                   %of test polygon
                                   %returned value is a logical array 'in'
                                   %which represents the points to consider inside rect_x and rect_y 

%creating grid for interior points
rect=cellfun(@(x,y) [x y],num2cell(rect_x)',num2cell(rect_y)','un',0);% creates a cell array 'rect' containing coordinates of  
rect=rect';                                                           % interior points of the polygon reference for the function used
                                                                      % reference
                                                                      % https://in.mathworks.com/matlabcentral/answers
                                                                  
                                                                     
                                                                      

% calculating value of stress at interior points
Stress = zeros(size(rect_x));
a=cell2mat(rect(in==1));        %converts the cell array 'rect' to matrix form. 'a' contains the coordinates 
b=zeros(size(a,1),1);           %of interior points in matrix form
for i=1:size(a,1)
    z=[a(i,1) a(i,2)];
    b(i)=Stress_point( x,y,z,M);
end
Stress(in==1)= b;     % Stress is a matrix equivalent to the size of matrix rect_x or rect_y. Value of stress
                      % at the exterior points are 0. 




