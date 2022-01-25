function plotLensDistortion(parameterValues)
% distortionX is the expression describing the distorted x coordinate
% distortionY is the expression describing the distorted y coordinate
% k1 and k2 are the radial distortion coefficients 
% p1 and p2 are the tangential distortion coefficients 

x = 1:640;
y = 1:480;
im = meshgrid(x,y);
[imu,~,~]=undistort(im,parameterValues,90);

% Loop over the grid
for x_i = 1:64:640
    for y_j = 1:48:480
        
        [theta,phi]=backproject_dh([x_i,y_j],parameterValues,90);
        
        r = theta*parameterValues(1)+...
            theta^3*parameterValues(2)+...
            theta^5*parameterValues(7)+...
            theta^7*parameterValues(8)+...
            theta^9*parameterValues(9);
        % Compute the distorted location 
        xout = r*cos(phi);
        yout = r*sin(phi);
        
        % Plot the original point
        plot(x_i,y_j, 'o', 'Color', [1.0, 0.0, 0.0])
        hold on
       
        % Draw the distortion direction with Quiver
        p1 = [x_i,y_j];                     % First Point
        p2 = [xout,yout];                   % Second Point
        dp = p2-p1;                         % Difference
        quiver(p1(1),p1(2),dp(1),dp(2),'AutoScale','off','MaxHeadSize',1,'Color',[0 0 1])
        
    end
end
hold off
grid on

end