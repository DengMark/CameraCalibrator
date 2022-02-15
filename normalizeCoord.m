function mn = normalizeCoord(m,u0,v0)
    translatedPts = m -[u0,v0];
    meanDist2Center = mean(vecnorm(translatedPts,1,2));
    if meanDist2Center
        scale = sqrt(2)/meanDist2Center;
    else
        scale = sqrt(2);
    end
    T = diag([scale,scale,1]); T(1:2,3)=-scale*[u0,v0]';
    homogeneousPts = [m';ones(1,size(m,1))];
    mn = T*homogeneousPts;
    mn = mn(1:2,:)';
end