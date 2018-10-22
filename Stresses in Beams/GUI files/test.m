% Polygonal Cross Section; Symmetric as well as Unsymmetric Pure Bending
% Scenario with Moment vector given at the cross section with phi as the
% angle between the plane of load and x-z plane; phi is taken positive
% counter-clockwise
clear
% constants
d2r = pi / 180;
 
% 3x5 test rectangle with long axis at 30 degrees
% area=15, x_cen=3.415, y_cen=6.549, perimeter=16
% I1=11.249, I2=31.247, J=42.496
x = [ 20  80  80  20];
y = [ 20  20  120  120];
% Enter X and Y coordinates of the points on cross section as matrices

M = [ 8000  0];   % Enter Moment Vector acting on the the centroid of the cross secrion as a vector
theta=atan(M(2)/M(1)); 
xx=50;          % Enter the x and y coordinate of the point at which you want to compute the stress wrt your defined X-Y coordinate axis
yy=120;

[geom,iner,cpmo,eig_vec, xm, ym ]=polygeom(x,y); 
%applying the function defined by the name polygeom in the polygeom.m file.
%Here x and y are the vectors representing the x and y coordinates of the
%points on the arbitrary polygonal cross section. This points are necessary
%to feed the algorithm, information about the geometry of the cross
%section.

A=geom(1);
X_C=geom(2);
Y_C=geom(3);
P=geom(4);
%geom = [ area   X_cen  Y_cen  perimeter ]
%iner = [ Ixx    Iyy    Ixy    Iuu    Ivv    Iuv ]
%u,v are centroidal axes parallel to x,y axes.
%cpmo= [ I1     ang1   I2     ang2   J ]
%I1,I2 are centroidal principal moments about axes
%at angles ang1,ang2.
%ang1 and ang2 are in radians.
%J is centroidal polar moment.  
%J = I1 + I2 = Iuu + Ivv

I_xx=iner(1);
I_yy=iner(2);
I_xy=iner(3);
I_uu=iner(4);
I_vv=iner(5);
I_uv=iner(6);

I1=cpmo(1);
ang1=cpmo(2);
I2=cpmo(3);
ang2=cpmo(4);
J=cpmo(5);

%plot cross section%
xplot = x( [ 1:end 1] );
yplot = y( [ 1:end 1] );
rad = 350;
x1 = [ X_C-rad*cos(ang1)  X_C+rad*cos(ang1) ];
y1 = [ Y_C-rad*sin(ang1)  Y_C+rad*sin(ang1) ];
x2 = [ X_C-rad*cos(ang2)  X_C+rad*cos(ang2) ];
y2 = [ Y_C-rad*sin(ang2)  Y_C+rad*sin(ang2) ];
plot( xplot,yplot,'b', X_C,Y_C,'ro', ...
      x1,y1,'g:', x2,y2,'g:'  )
axis( [ 0  rad  0  rad ] )
axis square

% Once we know the Principal Moments of Inertia what we can do is to
% project the Moment Vector acting on a given cross section along the
% direction of the principal axis.
% Thereafter calculating the norms of the respective projected vectors,
% we get M_1 and M_2.
% Now we can just plug in the above calculated quantities in the formula to
% determine stress at a particular point on the cross section.
% The necessary formula is mentioned as Equation (7.4) in Chapter 7 Bending
% of Straight Beams, Page No. 268 in Advanced Mechanics of Materials,
% 6th Edition Arthur P. Boresi, Richard J. Schmidt; ISBN: 978-0-471-43881-6
% if ang1*theta<0
%     gamma1=ang1+theta;
% end
% if ang1*theta>0
%     gamma1=ang1-theta;
% end
% 
% if ang2*theta<0
%     gamma2=ang2+theta;
% end
% if ang2*theta>0
%     gamma2=ang2-theta;
% end
% 
% if theta ==0
%     gamma1=ang1;
%     gamma2=ang2;
% end

M_11=proj(M,[eig_vec(1,1), eig_vec(2,1)]);
M_22=proj(M,[eig_vec(1,2), eig_vec(2,2)]);
M_1=norm(M_11);
M_2=norm(M_22);
M_111=norm(M)*cos(theta+ang1);
M_222=norm(M)*cos((d2r*90)+ang1+theta);

% shift the coordinates from the specified x-y coordinate frame defined by
% the user when she/he was giving the coordinates of the cross section as
% input to the centroidal coordinate frame and then to the Principal Axis 
% Coordinate Frame by transforming the coordinates by angle ang1.
% We are doing this as X and Y coordinates of the point at which the user 
% requires the Stress is wrt the coordinate axis defined by the user 
% whereas in the Equation (7.4) in Chapter 7 Bending
% of Straight Beams, Page No. 268 in Advanced Mechanics of Materials,
% 6th Edition Arthur P. Boresi, Richard J. Schmidt; ISBN: 978-0-471-43881-6
% x and y coordinates (in the formula) is wrt thw Principal Axis.
xx=xx-X_C;   
yy=yy-Y_C;
XT=(xx*cos(ang1))+(yy*sin(ang1));
YT=(-1*xx*sin(ang1))+(yy*cos(ang1));
if ang1==0
    S=((((M_1*yy)/I1)-((M_2*xx)/I2))*1000);
elseif ang2==0
    S=-1*((((M_1*xx)/I1)-((M_2*yy)/I2))*1000);
else
    S=((((M_111*YT)/I1)-((M_222*XT)/I2))*10000);
%     phi=input('Enter phi (in degrees): ');
%     phi=d2r*phi;
%     Mx=norm(M)*sin(phi);
%     ta=(I_uv-(I_uu*cot(phi)))/(I_vv-(I_uv*cot(phi)));
%     S=(Mx*(yy-(xx*ta)))/I_uu-(I_uv*ta);
end