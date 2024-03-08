% Abdulsamet Toptaş - 21905024
% I created rotation function.
function [nvec] = rotation(vec,ang,ax) 

% As stated in the assignment, I created the rotation matrices as 3x3.
% Matrices reference the "Right-Handed Coordinate System".
% R1 For X Matrix , R2 For Y Matrix , R3 For Z Matrix
R1 = [1,0,0;0,cosd(ang),sind(ang);0,-sind(ang),cosd(ang)];
R2 = [cosd(ang),0,-sind(ang);0,1,0;sind(ang),0,cosd(ang)];
R3 = [cosd(ang),sind(ang),0;-sind(ang),cosd(ang),0;0,0,1];

% ('ax==1' For X axis)
if ax == 1 
    nvec = R1*vec;
% ('ax==2' For Y axis)
elseif ax == 2
    nvec = R2*vec;
% ('ax==3' For Z axis)    
elseif ax == 3
    nvec = R3*vec;
end

end
% COMMAND WINDOW ENTRY = rotation([100;120;200],-20,2) --> It will rotate clockwise(-) by an angle λ on the Y axis.
% COMMAND WINDOW ENTRY = rotation(ans,25,3) --> It will rotate counter-clockwise(+) by an angle δ on the Z axis.
% COMMAND WINDOW ENTRY = rotation(ans,7,2) --> It will rotate counter-clockwise(+) by an angle β on the Y axis.
