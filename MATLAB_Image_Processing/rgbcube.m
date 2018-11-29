function rgbcube(vx,vy,vz)
    vertices_matrix = [0 0 0;0 0 1;0 1 0;0 1 1;1 0 0;1 0 1;1 1 0;1 1 1];
    faces_matrix = [1 5 6 2; 1 3 7 5; 1 2 4 3;2 4 8 6;3 7 8 4; 5 6 8 7];
    colors = vertices_matrix;
    patch('Vertices', vertices_matrix, 'Faces', faces_matrix, 'FaceVertexCData', colors, 'Facecolor', 'interp', 'EdgeAlpha', 0);
    if nargin == 0
        vx = 10;
        vy = 10;
        vz = 4;
    elseif nargin ~= 3
        error('Wrong Number of Inputs');
    end
    view([vx ,vy ,vz]);
    axis square;
end

