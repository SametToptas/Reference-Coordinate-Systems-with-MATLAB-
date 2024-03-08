% Abdulsamet Toptaş - 21905024
% I created nested function for conversion from Global ellipsoidal system to Local ellipsoidal systems.
% 'xyz2blh' created for lambda and phi angles in rotation matrices.
% The function we created will give us Zenith, Azimuth, Slant range (r) values.
function [azim, zen, r] = global2local(P, R) , [b,l,h] = xyz2blh(R(1),R(2),R(3));

% For the rotation matrices created, the 'Right-Handed Coordinate System' was taken as reference. (8-9 rows) 
R3 = [cosd(180-l),sind(180-l),0;-sind(180-l),cosd(180-l),0;0,0,1];
R2 = [cosd(90-b),0,-sind(90-b);0,1,0;sind(90-b),0,cosd(90-b)];
% The reflection matrix 'S2' is referenced from Slide 3 of GMT225. (row 11) 
S2 = [1,0,0;0,-1,0;0,0,1];

% I created formula A for conversion from local cartesian to global cartesian. (row 15)
% Formula A is referenced from GMT225 Slide 3. (row 15)
A = R3 * R2 * S2;

% At this stage, I converted the GLOBAL SYSTEM that I converted in the A formula to the LOCAL ELLIPSOIDAL SYSTEM.
DeltaX = [P(1)-R(1);P(2)-R(2);P(3)-R(3)];
% I used the Delta X Transpose formula in GMT225 Slide 3 for this. (row 20)
DeltaX_T = transpose(A)*DeltaX;

% Finally, I proceed to the calculation by creating the zenith, azimuth and slant range (r) formulas. (23-25 rows)
r = sqrt(DeltaX_T(1)^2+DeltaX_T(2)^2+DeltaX_T(3)^2);
zen_f = acosd(DeltaX_T(3)/r);
azim_f = acosd(DeltaX_T(1)/(r*sind(zen_f)));

% As stated in assignment 4, I made a condition for the range values of our zenith and azimuth angles. (28-38 rows)
if (0 <= azim_f)&&(azim_f <= 360)
    azim = azim_f;
else
    disp("The azimuth angle is out of range! Check the values you entered.")
end

if (0 <= zen_f)&&(zen_f <= 180)
    zen = zen_f;
else
    disp("The zenith angle is out of range! Check the values you entered.")
end

end
% COMMAND WINDOWS ENTRY below;    ([3D COORDINATES OF THE TARGET POINT])  , [3D COORDINATES OF THE OBSERVATION POINT])              
% [azim, zen, r] = global2local([21007733.6107;15033152.8348;-7112458.1231],[4208830.726;2334850.0235;4171267.089])