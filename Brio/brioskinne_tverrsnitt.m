function [ punkt, flater] = brioskinne_tverrsnitt()
    H = 12; % [mm] høyde
    W = 40; % [mm] bredde
    v =  6; % [mm] bredde av enkeltspor
    w = 26; % [mm] avstand mellom sentrum av enkeltspor
    d =  3; % [mm] dybde av enkeltspor
    punkt = [ 0 0
              W 0
              W H
              W-(W-w-v)/2 H
              W-(W-w-v)/2 H-d
              W-(W-w-v)/2-v H-d
              W-(W-w-v)/2-v H
             (W-w-v)/2+v H
             (W-w-v)/2+v H-d
             (W-w-v)/2 H-d
             (W-w-v)/2 H
              0 H];
          
    N = size(punkt,1);
    C = [(1:(N-1))' (2:N)'; N 1];
    DT = delaunayTriangulation(punkt,C);
    IO = isInterior(DT); 
    flater = DT.ConnectivityList(IO,[1 3 2]);
    punkt = transpose(punkt);
    flater = flater(:,[1 3 2]);
    triplot(flater,punkt(1,:),punkt(2,:)), axis equal
end